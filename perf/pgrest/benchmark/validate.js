function typeLabel(value) {
  if (Array.isArray(value)) return "array";
  if (value === null) return "null";
  return typeof value;
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

      if (JSON.stringify(leftFirst) !== JSON.stringify(rightFirst)) {
        throw new Error(`Scenario ${scenario.name} validation failed: first row mismatch`);
      }
      if (JSON.stringify(leftLast) !== JSON.stringify(rightLast)) {
        throw new Error(`Scenario ${scenario.name} validation failed: last row mismatch`);
      }
    }
    return;
  }

  if (JSON.stringify(left.json) !== JSON.stringify(right.json)) {
    throw new Error(`Scenario ${scenario.name} validation failed: JSON body mismatch`);
  }
}
