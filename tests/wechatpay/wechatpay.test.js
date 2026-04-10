import { describe, test, expect, beforeAll, afterAll, beforeEach } from "bun:test";
import { readFileSync } from "fs";
import { join } from "path";
import {
  constants,
  createSign,
  createVerify,
  privateDecrypt,
} from "node:crypto";
import {
  startNginz,
  stopNginz,
  cleanupRuntime,
  TEST_URL,
  createHTTPMock,
  MOCK_PORTS,
} from "../harness.js";

const MODULE = "wechatpay";
const FIXTURES_DIR = join(process.cwd(), "tests", MODULE, "fixtures");
const PRIVATE_KEY = readFileSync(join(FIXTURES_DIR, "test_private.pem"), "utf8");
const PUBLIC_KEY = readFileSync(join(FIXTURES_DIR, "test_public.pem"), "utf8");
const APICLIENT_SERIAL = "APICLIENTSERIAL123";
const PLATFORM_SERIAL = "PLATFORMSERIAL456";
const MCH_ID = "1900001111";

let upstreamMock = null;

function signWechatpayMessage(body, { timestamp, nonce }) {
  const signer = createSign("RSA-SHA256");
  signer.update(`${timestamp}\n${nonce}\n${body}\n`);
  signer.end();
  return signer.sign(PRIVATE_KEY, "base64");
}

function buildWechatpayHeaders(body, overrides = {}) {
  const timestamp = overrides.timestamp ?? String(Math.floor(Date.now() / 1000));
  const nonce = overrides.nonce ?? "testnonce1234567890";
  const serial = overrides.serial ?? PLATFORM_SERIAL;
  const requestId = overrides.requestId ?? "req-123456";
  const signature =
    overrides.signature ?? signWechatpayMessage(body, { timestamp, nonce });

  return {
    "Content-Type": "application/json",
    "Request-ID": requestId,
    "Wechatpay-Serial": serial,
    "Wechatpay-Nonce": nonce,
    "Wechatpay-Timestamp": timestamp,
    "Wechatpay-Signature": signature,
  };
}

function parseAuthorizationHeader(header) {
  const [scheme, rawParams] = header.split(" ", 2);
  const params = {};

  for (const part of rawParams.split(",")) {
    const match = part.match(/([^=]+)="([^"]*)"/);
    if (match) {
      params[match[1]] = match[2];
    }
  }

  return { scheme, params };
}

function verifyProxyAuthorization(header, { method, path, query, body }) {
  const { scheme, params } = parseAuthorizationHeader(header);

  expect(scheme).toBe("WECHATPAY2-SHA256-RSA2048");
  expect(params.mchid).toBe(MCH_ID);
  expect(params.serial_no).toBe(APICLIENT_SERIAL);
  expect(params.timestamp).toBeDefined();
  expect(params.nonce_str).toBeDefined();
  expect(params.signature).toBeDefined();

  const verifier = createVerify("RSA-SHA256");
  verifier.update(`${method}\n${path}?${query}\n${params.timestamp}\n${params.nonce_str}\n${body}\n`);
  verifier.end();

  expect(verifier.verify(PUBLIC_KEY, params.signature, "base64")).toBe(true);
}

function signedUpstreamResponse(body, overrides = {}) {
  const timestamp = overrides.timestamp ?? String(Math.floor(Date.now() / 1000));
  const nonce = overrides.nonce ?? "upstreamnonce123456";
  const signature =
    overrides.signature ?? signWechatpayMessage(body, { timestamp, nonce });

  return {
    status: overrides.status ?? 200,
    body,
    headers: {
      "Content-Type": "application/json",
      "Request-ID": overrides.requestId ?? "upstream-req-1",
      "Wechatpay-Serial": overrides.serial ?? PLATFORM_SERIAL,
      "Wechatpay-Nonce": nonce,
      "Wechatpay-Timestamp": timestamp,
      "Wechatpay-Signature": signature,
    },
  };
}

describe("wechatpay module", () => {
  beforeAll(async () => {
    upstreamMock = createHTTPMock(MOCK_PORTS.HTTP);
    await startNginz(`tests/${MODULE}/nginx.conf`, MODULE);
  });

  afterAll(async () => {
    await stopNginz();
    if (upstreamMock) {
      upstreamMock.stop();
    }
    cleanupRuntime(MODULE);
  });

  beforeEach(() => {
    upstreamMock.reset();
  });

  describe("OAEP handlers", () => {
    test("encrypts request bodies and decrypts them back", async () => {
      const plaintext = "wechatpay secret payload";

      const encryptRes = await fetch(`${TEST_URL}/encrypt`, {
        method: "POST",
        body: plaintext,
      });
      expect(encryptRes.status).toBe(200);

      const ciphertext = await encryptRes.text();
      expect(ciphertext).not.toBe(plaintext);

      const nodePlaintext = privateDecrypt(
        {
          key: PRIVATE_KEY,
          padding: constants.RSA_PKCS1_OAEP_PADDING,
        },
        Buffer.from(ciphertext, "base64")
      ).toString("utf8");
      expect(nodePlaintext).toBe(plaintext);

      const decryptRes = await fetch(`${TEST_URL}/decrypt`, {
        method: "POST",
        body: ciphertext,
      });
      expect(decryptRes.status).toBe(200);
      expect(await decryptRes.text()).toBe(plaintext);
    });
  });

  describe("access verification", () => {
    test("rejects requests with invalid signatures", async () => {
      const body = JSON.stringify({ event: "bad" });
      const headers = buildWechatpayHeaders(body, {
        signature: "invalid-signature",
      });

      const res = await fetch(`${TEST_URL}/notify`, {
        method: "POST",
        headers,
        body,
      });

      expect(res.status).toBe(401);
    });

    test("accepts valid signed requests and preserves request body", async () => {
      const body = JSON.stringify({ event: "payment.succeeded", id: "evt-1" });
      const headers = buildWechatpayHeaders(body);

      const res = await fetch(`${TEST_URL}/notify`, {
        method: "POST",
        headers,
        body,
      });

      expect(res.status).toBe(200);
      expect(await res.text()).toBe(`verified:${body}`);
    });
  });

  describe("proxy signing and response verification", () => {
    test("signs upstream requests and forwards verified responses", async () => {
      let observedRequest = null;

      upstreamMock.post("/proxy", async (req, url) => {
        const body = await req.text();
        observedRequest = {
          authorization: req.headers.get("authorization"),
          xTestHeader: req.headers.get("x-test-header"),
          method: req.method,
          path: url.pathname,
          query: url.searchParams.toString(),
          body,
        };

        return signedUpstreamResponse(JSON.stringify({ ok: true, echoedBody: body }));
      });

      const requestBody = JSON.stringify({ amount: 88, currency: "CNY" });
      const res = await fetch(`${TEST_URL}/proxy?foo=bar`, {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
          "X-Test-Header": "present",
        },
        body: requestBody,
      });

      expect(res.status).toBe(200);
      await expect(res.json()).resolves.toEqual({
        ok: true,
        echoedBody: requestBody,
      });

      expect(observedRequest).toBeTruthy();
      expect(observedRequest.xTestHeader).toBe("present");
      expect(observedRequest.authorization).toBeTruthy();
      verifyProxyAuthorization(observedRequest.authorization, observedRequest);

      const logged = upstreamMock.getLastRequest();
      expect(logged.path).toBe("/proxy");
      expect(logged.query).toEqual({ foo: "bar" });
      expect(logged.body).toEqual({ amount: 88, currency: "CNY" });
    });

    test("turns upstream responses into 401 when signature verification fails", async () => {
      let observedBody = null;

      upstreamMock.post("/proxy-bad", async (req) => {
        observedBody = await req.text();

        return signedUpstreamResponse(JSON.stringify({ ok: false }), {
          signature: "broken-signature",
        });
      });

      const res = await fetch(`${TEST_URL}/proxy-bad`, {
        method: "POST",
        headers: {
          "Content-Type": "text/plain",
        },
        body: "tamper-check",
      });

      expect(observedBody).toBe("tamper-check");
      expect(res.status).toBe(401);
    });
  });
});
