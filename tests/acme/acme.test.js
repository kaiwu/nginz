import { describe, test, expect, beforeAll, afterAll } from "bun:test";
import {
  startNginz,
  stopNginz,
  cleanupRuntime,
  TEST_URL,
  createACMEMock,
  MOCK_PORTS,
} from "../harness.js";

const MODULE = "acme";
let acmeMock;

describe("acme module", () => {
  beforeAll(async () => {
    // Start ACME mock server
    acmeMock = createACMEMock(MOCK_PORTS.ACME);

    await startNginz(`tests/${MODULE}/nginx.conf`, MODULE);
  });

  afterAll(async () => {
    await stopNginz();
    if (acmeMock) {
      acmeMock.stop();
    }
    cleanupRuntime(MODULE);
  });

  test("placeholder - module not implemented", async () => {
    const res = await fetch(`${TEST_URL}/`);
    expect(res.status).toBe(200);
    const body = await res.text();
    expect(body).toContain("acme");
  });

  // Tests to enable when acme module is implemented:
  //
  // test("responds to ACME HTTP-01 challenge", async () => {
  //   // Create an order and get challenge token
  //   const orderRes = await fetch(`http://127.0.0.1:${MOCK_PORTS.ACME}/new-order`, {
  //     method: "POST",
  //     headers: { "Content-Type": "application/json" },
  //     body: JSON.stringify({
  //       identifiers: [{ type: "dns", value: "test.example.com" }],
  //     }),
  //   });
  //   const order = await orderRes.json();
  //
  //   // Get the challenge token
  //   const authzRes = await fetch(order.authorizations[0]);
  //   const authz = await authzRes.json();
  //   const challenge = authz.challenges.find((c) => c.type === "http-01");
  //
  //   // Nginx should serve the challenge response
  //   const res = await fetch(
  //     `${TEST_URL}/.well-known/acme-challenge/${challenge.token}`
  //   );
  //   expect(res.status).toBe(200);
  // });
  //
  // test("serves ACME challenge from configured path", async () => {
  //   const res = await fetch(`${TEST_URL}/.well-known/acme-challenge/test-token`);
  //   expect(res.status).toBe(200);
  // });
  //
  // test("auto-renews certificates before expiry", async () => {
  //   // This would test the background renewal process
  // });
});
