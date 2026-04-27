import { describe, expect, test } from "bun:test";
import { __test__, validateScenarioPair } from "./validate.js";

describe("pgrest benchmark semantic validation", () => {
  test("treats numeric strings and numbers as equal", () => {
    expect(__test__.valuesEqual({ id: "1", org_id: "7" }, { id: 1, org_id: 7 })).toBe(true);
  });

  test("treats equivalent timestamp formats as equal", () => {
    expect(
      __test__.valuesEqual(
        { created_at: "2024-01-01 08:00:00+08" },
        { created_at: "2024-01-01T08:00:00+08:00" }
      )
    ).toBe(true);
  });

  test("rejects real row mismatches", () => {
    expect(() =>
      validateScenarioPair(
        { name: "medium-page" },
        { status: 200, json: [{ id: "1", name: "User 1" }] },
        { status: 200, json: [{ id: 1, name: "User X" }] }
      )
    ).toThrow("first row mismatch");
  });

  test("rejects row count mismatches", () => {
    expect(() =>
      validateScenarioPair(
        { name: "medium-page" },
        { status: 200, json: [{ id: "1" }] },
        { status: 200, json: [{ id: 1 }, { id: 2 }] }
      )
    ).toThrow("row count mismatch");
  });

  test("rejects object key mismatches", () => {
    expect(__test__.valuesEqual({ id: 1, name: "User 1" }, { id: 1, email: "user1@example.com" })).toBe(false);
  });
});
