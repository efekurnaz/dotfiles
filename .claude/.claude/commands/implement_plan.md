---
color: purple
---

# Implement Shopify Plan

You are tasked with implementing a Shopify plan document. This command executes the phases defined in the plan while continuously checking against the current rule files.

## Initial Setup

When invoked:

1. **Load plan document** from `/tmp/shopify_plan_*.md` or provided path
2. **Load ALL rule files** from `~/.claude/rules/` (current versions)
3. **Cross-reference plan with current rules** to ensure still valid
4. **Create todo list** from uncompleted phases

## Rule-Driven Implementation

### Before Each Phase:

1. **Re-read relevant rule files** for this phase:
   - Phase 1: Read `schemas.mdc`
   - Phase 2: Read `liquid-syntax.mdc`, `liquid-documentation.mdc`
   - Phase 3: Read `javascript-standards.mdc`
   - Phase 4: Read `tailwindcss.mdc`
   - Phase 5: Read `accessibility.mdc` and all others

2. **Verify rules haven't changed** since plan creation:
   - If rules changed, note the differences
   - Adapt implementation to follow CURRENT rules
   - Document any deviations from original plan

3. **Implement following current rules** exactly:
   - Use code patterns from rule files
   - Apply performance targets from rules
   - Follow all requirements and restrictions

## Dynamic Implementation Process

### Phase 1: Schema Definition

```bash
# Read current schema rules
cat ~/.claude/rules/shopify/schemas.mdc

# Extract requirements dynamically
# Implement schema that satisfies CURRENT rules
# Test against rule requirements
```

Implementation checklist generated from `schemas.mdc`:
- Check each requirement in the rule file
- Verify implementation satisfies it
- Document compliance

### Phase 2: Liquid Implementation

```bash
# Read current Liquid rules
cat ~/.claude/rules/shopify/liquid-syntax.mdc
cat ~/.claude/rules/shopify/liquid-documentation.mdc

# Implement following CURRENT Liquid standards
# Use approved tags and filters only
# Follow formatting rules exactly
```

### Phase 3: JavaScript Enhancement

```bash
# Read current JavaScript standards
cat ~/.claude/rules/general/javascript-standards.mdc

# Parse for current requirements:
# - Performance targets (may have changed)
# - Required patterns (# syntax, AbortController, etc.)
# - Documentation standards
```

When implementing, continuously check:
- Does this match the pattern in rule file line X?
- Am I meeting the performance target specified?
- Have I included all required elements?

### Phase 4: Styling

```bash
# Read current Tailwind rules
cat ~/.claude/rules/general/tailwindcss.mdc

# Apply current utility-first approach
# Check for any new/deprecated utilities
```

### Phase 5: Testing & Validation

```bash
# Read ALL rule files for testing requirements
# Generate comprehensive test checklist from current rules
# Run tests that verify each rule requirement
```

## Real-Time Rule Validation

During implementation, continuously:

1. **Check against rule files** (not plan):
   ```javascript
   // Before writing JavaScript:
   // 1. Check javascript-standards.mdc for current pattern
   // 2. Implement following that pattern
   // 3. Verify against rule requirements
   ```

2. **Measure against rule metrics**:
   ```javascript
   // After implementation:
   performance.mark('component-init-start');
   // ... initialization code ...
   performance.mark('component-init-end');
   performance.measure('component-init', 'component-init-start', 'component-init-end');
   // CHECK: Is this < 16ms as specified in javascript-standards.mdc line 1120?
   ```

3. **Document rule compliance**:
   ```markdown
   ✅ Phase 3 Complete:
   - Private fields with # syntax (javascript-standards.mdc:41) ✓
   - AbortController implemented (javascript-standards.mdc:142) ✓
   - Init time: 12ms < 16ms (javascript-standards.mdc:1120) ✓
   ```

## Handling Rule Changes

If rules have changed since plan creation:

```markdown
⚠️ Rule Change Detected:

**Original Plan** (based on rules from [date]):
- Required: 5 settings maximum

**Current Rules** (as of now):
- Required: 3 settings maximum (schemas.mdc updated)

**Adaptation**:
Following current rules - implementing with 3 settings maximum.
```

## Progress Tracking with Rule References

Update plan document with rule compliance:

```markdown
## Phase 1: Schema Definition
✅ **COMPLETED** - [timestamp]

**Rule Compliance**:
- [x] Max settings: 3 used (schemas.mdc:23 - limit is 5) ✓
- [x] Translation keys: all text uses keys (schemas.mdc:11) ✓
- [x] No redundant inputs (schemas.mdc:12) ✓

**Rules Applied From**:
- ~/.claude/rules/shopify/schemas.mdc (version from [timestamp])
```

## Testing Against Current Rules

After each phase, validate against CURRENT rule files:

```bash
# Read rule file
RULE_CONTENT=$(cat ~/.claude/rules/shopify/schemas.mdc)

# Extract specific requirements
# Test implementation against each requirement
# Document compliance or violations
```

## Completion Report

```markdown
✅ Implementation Complete!

**Rules Applied**: 
- schemas.mdc (read at phase 1: [timestamp])
- liquid-syntax.mdc (read at phase 2: [timestamp])
- javascript-standards.mdc (read at phase 3: [timestamp])
- tailwindcss.mdc (read at phase 4: [timestamp])
- accessibility.mdc (read at phase 5: [timestamp])

**Rule Compliance Summary**:
| Rule File | Requirements Met | Violations | Notes |
|-----------|-----------------|------------|-------|
| schemas.mdc | 5/5 | 0 | All requirements satisfied |
| javascript-standards.mdc | 15/15 | 0 | Performance targets met |
| ... | | | |

**Performance vs Rules**:
- Component init: 12ms (rule requires < 16ms) ✅
- Event handlers: 5ms (rule requires < 8ms) ✅
- PageSpeed: 94 (rule requires > 90) ✅
```

## Important Guidelines

- **Always read CURRENT rules** - Don't rely on plan's snapshot
- **Implement against rule files** - They are the source of truth
- **Document rule compliance** - Reference specific lines
- **Adapt to rule changes** - Rules may update between plan and implementation
- **Test against current requirements** - Not what plan said

## Integration with Workflow

This command:
- **Reads**: Plan document + CURRENT rule files
- **Implements**: Following current rules exactly
- **Documents**: Compliance with specific rule references
- **Adapts**: To any rule changes since planning

The implementation always follows the most current rules, ensuring compliance with the latest standards.