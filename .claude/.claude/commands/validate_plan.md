---
color: red
---

# Validate Shopify Implementation

You are tasked with validating that a Shopify implementation complies with ALL current rule files, not just what was in the plan.

## Initial Setup

When invoked:

1. **Load plan and research documents** from `/tmp/`
2. **Load ALL current rule files** from `~/.claude/rules/`
3. **Identify what was implemented** (files changed)
4. **Validate against CURRENT rules** (not plan snapshot)

## Dynamic Validation Process

### Step 1: Load All Rules

```bash
# Read all rule files
for rule in ~/.claude/rules/**/*.mdc; do
  echo "Loading rule: $rule"
  cat "$rule"
done
```

Parse each rule file to extract:

- Requirements to check
- Performance metrics to measure
- Patterns to verify
- Anti-patterns to detect

### Step 2: Generate Validation Checklist

For each rule file, dynamically create validation checks:

```markdown
## Validation Checklist (Generated from Current Rules)

### From schemas.mdc:

- [ ] Check setting count (Line 23: max 5 settings)
- [ ] Verify translation keys used (Line 11: all text)
- [ ] No redundant text inputs (Line 12)
- [ ] Essential settings only (Line 29-31)

### From javascript-standards.mdc:

- [ ] Private fields use # syntax (Line 41-44)
- [ ] AbortController present (Line 142-143)
- [ ] Performance < 16ms init (Line 1120)
- [ ] No layout thrashing (Line 726-1089)
- [ ] Try-catch boundaries (Line 19)
- [ ] JSDoc comments (Line 589-623)
      [... continue for all requirements in file ...]

### From liquid-syntax.mdc:

- [ ] {% liquid %} blocks used (Line 83)
- [ ] {% render %} not {% include %} (Line 85)
- [ ] Single-line render in liquid blocks (Line 94-113)
- [ ] Valid tags only (Line 11-43)
- [ ] Valid filters only (Line 44-81)
      [... continue for all requirements ...]
```

### Step 3: Run Automated Validation

Execute tests based on rule requirements:

```bash
# Run Shopify theme check
shopify theme check

# Check for JavaScript patterns required by rules
grep -r "^[^#]*#" _scripts/ # Check for private fields
grep -r "AbortController" _scripts/ # Check for cleanup
grep -r "performance.measure" _scripts/ # Check for measurements

# Validate Liquid patterns
grep -r "{% include" sections/ snippets/ # Should find none
grep -r "{% liquid" sections/ snippets/ # Should find many
```

### Step 4: Measure Against Rule Metrics

Extract metrics from rules and measure:

```javascript
// From javascript-standards.mdc line 1120-1125:
// - Component initialization: < 16ms
// - Event handler execution: < 8ms
// - Animation frame: < 16ms (60fps)

// Measure actual performance:
const measurements = performance.getEntriesByType("measure");
measurements.forEach((measure) => {
  console.log(`${measure.name}: ${measure.duration}ms`);
  // Compare against rule requirements
});
```

### Step 5: Generate Rule Compliance Report

Create detailed validation report with rule references:

```markdown
# Validation Report: [Feature Name]

**Date**: [timestamp]
**Rules Version**: Current as of [timestamp]
**Rules Checked**: [List all .mdc files validated against]

## Rule-by-Rule Compliance

### schemas.mdc Compliance

| Requirement      | Line | Status  | Evidence                |
| ---------------- | ---- | ------- | ----------------------- |
| Max 5 settings   | 23   | ✅ PASS | Found 4 settings        |
| Translation keys | 11   | ✅ PASS | All text uses t: filter |
| No text inputs   | 12   | ✅ PASS | No text type found      |

### javascript-standards.mdc Compliance

| Requirement            | Line     | Status     | Evidence                   |
| ---------------------- | -------- | ---------- | -------------------------- |
| Private fields (#)     | 41-44    | ✅ PASS    | All private fields use #   |
| AbortController        | 142-143  | ⚠️ FAIL    | Missing in component.js:45 |
| Init < 16ms            | 1120     | ✅ PASS    | Measured: 12ms             |
| Avoid layout thrashing | 726-1089 | ✅ PASS    | Batch operations found     |
| Try-catch boundaries   | 19       | ✅ PASS    | Error handling present     |
| JSDoc comments         | 589-623  | ⚠️ PARTIAL | Missing on 2 methods       |

### liquid-syntax.mdc Compliance

| Requirement         | Line  | Status  | Evidence          |
| ------------------- | ----- | ------- | ----------------- |
| {% liquid %} blocks | 83    | ✅ PASS | Used throughout   |
| No {% include %}    | 85    | ✅ PASS | None found        |
| Valid tags only     | 11-43 | ✅ PASS | All tags valid    |
| Valid filters only  | 44-81 | ✅ PASS | All filters valid |

### tailwindcss.mdc Compliance

[... continue for each rule file ...]

## Violations Found

### Critical (Must Fix):

1. **javascript-standards.mdc:142** - Missing AbortController
   - File: `_scripts/components/feature.js:45`
   - Impact: Memory leak risk
   - Fix: Add AbortController to cleanup listeners

### Warnings (Should Fix):

1. **javascript-standards.mdc:589** - Missing JSDoc
   - Files: `component.js:handleClick()`, `component.js:handleScroll()`
   - Impact: Documentation incomplete
   - Fix: Add JSDoc comments

## Performance vs Rule Requirements

| Metric         | Rule Requirement | Rule Line                     | Measured | Status |
| -------------- | ---------------- | ----------------------------- | -------- | ------ |
| Component init | < 16ms           | javascript-standards.mdc:1120 | 12ms     | ✅     |
| Event handlers | < 8ms            | javascript-standards.mdc:1121 | 5ms      | ✅     |
| Animation      | 60fps            | javascript-standards.mdc:1122 | 60fps    | ✅     |
| PageSpeed      | > 90             | (derived)                     | 94       | ✅     |

## Rule Coverage Analysis

| Rule File                | Total Requirements | Checked | Passed | Failed |
| ------------------------ | ------------------ | ------- | ------ | ------ |
| schemas.mdc              | 7                  | 7       | 7      | 0      |
| javascript-standards.mdc | 25                 | 25      | 23     | 2      |
| liquid-syntax.mdc        | 15                 | 15      | 15     | 0      |
| tailwindcss.mdc          | 8                  | 8       | 8      | 0      |
| accessibility.mdc        | 12                 | 12      | 12     | 0      |
| **TOTAL**                | 67                 | 67      | 65     | 2      |

## Compliance Score: 97% (65/67 requirements met)

## Recommendations

### Immediate Actions (Fix violations):

1. Add AbortController to `_scripts/components/feature.js`
2. Add JSDoc to missing methods

### Future Improvements (From rules):

1. Consider patterns from javascript-standards.mdc:226-256 (debouncing)
2. Implement DOMQueue from javascript-standards.mdc:972-1048
3. Add performance monitoring from javascript-standards.mdc:1053-1072
```

## Automated Rule Checking

Create automated checks for each rule file:

```bash
#!/bin/bash
# validate-rules.sh - Generated from rule files

# From schemas.mdc
echo "Checking schema rules..."
SETTING_COUNT=$(grep -c "type" sections/*.liquid | awk -F: '{print $2}' | sort -rn | head -1)
if [ $SETTING_COUNT -gt 5 ]; then
  echo "❌ FAIL: schemas.mdc:23 - Too many settings: $SETTING_COUNT"
fi

# From javascript-standards.mdc
echo "Checking JavaScript rules..."
if ! grep -q "AbortController" _scripts/**/*.js; then
  echo "❌ FAIL: javascript-standards.mdc:142 - Missing AbortController"
fi

# Continue for all rules...
```

## Important Guidelines

- **Validate against CURRENT rules** - Not what plan said
- **Reference specific rule lines** - For traceability
- **Measure actual performance** - Not estimates
- **Check ALL requirements** - Even minor ones
- **Generate comprehensive report** - With evidence

## Integration with Workflow

This command:

- **Validates**: Against current rule files (source of truth)
- **Measures**: Actual performance vs rule requirements
- **Documents**: Complete compliance with evidence
- **Identifies**: Every violation with rule reference

The validation ensures implementation meets current standards, regardless of when the plan was created.

