function typeLabel(value) {
  if (Array.isArray(value)) return "array";
  if (value === null) return "null";
  return typeof value;
}

function isNumericString(value) {
  return typeof value === "string" && /^-?(?:0|[1-9]\d*)(?:\.\d+)?$/.test(value);
}

function isIsoLikeTimestamp(value) {
  return typeof value === "string" && /^\d{4}-\d{2}-\d{2}[ T]\d{2}:\d{2}:\d{2}(?:\.\d+)?(?:Z|[+-]\d{2}(?::?\d{2})?)$/.test(value);
}

function normalizeTimestamp(value) {
  if (!isIsoLikeTimestamp(value)) return value;

  let normalized = value.includes("T") ? value : value.replace(" ", "T");
  normalized = normalized.replace(/([+-]\d{2})$/, "$1:00");
  normalized = normalized.replace(/([+-]\d{2})(\d{2})$/, "$1:$2");
  const parsed = new Date(normalized);
  if (Number.isNaN(parsed.getTime())) return value;
  return parsed.toISOString();
}

function valuesEqual(left, right) {
  if (left === right) return true;

  if (typeof left === "number" && isNumericString(right)) {
    return Number(right) === left;
  }

  if (typeof right === "number" && isNumericString(left)) {
    return Number(left) === right;
  }

  const leftTs = normalizeTimestamp(left);
  const rightTs = normalizeTimestamp(right);
  if (leftTs !== left || rightTs !== right) {
    return leftTs === rightTs;
  }

  if (Array.isArray(left) && Array.isArray(right)) {
    if (left.length !== right.length) return false;
    return left.every((value, index) => valuesEqual(value, right[index]));
  }

  if (left && right && typeof left === "object" && typeof right === "object") {
    const leftKeys = Object.keys(left);
    const rightKeys = Object.keys(right);
    if (leftKeys.length !== rightKeys.length) return false;
    if (!leftKeys.every((key) => Object.hasOwn(right, key))) return false;
    return leftKeys.every((key) => valuesEqual(left[key], right[key]));
  }

  return false;
}

export function validateScenarioPair(scenario, left, right) {
  if (left.status !== 200 || right.status !== 200) {
    throw new Error(
      `Scenario ${scenario.name} validation failed: expected HTTP 200 from both services, got ${left.status} and ${right.status}`
    );
  }

  const leftType = typeLabel(left.json);
  const rightType = typeLabel(right.json);
  if (leftType !== rightType) {
    throw new Error(`Scenario ${scenario.name} validation failed: top-level JSON type mismatch (${leftType} vs ${rightType})`);
  }

  if (Array.isArray(left.json) && Array.isArray(right.json)) {
    if (left.json.length !== right.json.length) {
      throw new Error(
        `Scenario ${scenario.name} validation failed: row count mismatch (${left.json.length} vs ${right.json.length})`
      );
    }

    if (left.json.length > 0) {
      const leftFirst = left.json[0];
      const rightFirst = right.json[0];
      const leftLast = left.json[left.json.length - 1];
      const rightLast = right.json[right.json.length - 1];

      if (!valuesEqual(leftFirst, rightFirst)) {
        throw new Error(`Scenario ${scenario.name} validation failed: first row mismatch`);
      }
      if (!valuesEqual(leftLast, rightLast)) {
        throw new Error(`Scenario ${scenario.name} validation failed: last row mismatch`);
      }
    }
    return;
  }

  if (!valuesEqual(left.json, right.json)) {
    throw new Error(`Scenario ${scenario.name} validation failed: JSON body mismatch`);
  }
}

export const __test__ = {
  normalizeTimestamp,
  valuesEqual,
};
