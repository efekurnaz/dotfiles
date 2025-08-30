---
color: orange
---

# Create Shopify Implementation Plan

You are tasked with creating a detailed implementation plan based on research findings. This command should be run AFTER `/research_codebase` to leverage the research document.

## Initial Setup

When invoked:

1. **Load research document** from `/tmp/shopify_research_*.md`
2. **Load all rule files** from `~/.claude/rules/`
3. **Create plan that enforces ALL rules dynamically**

If no research found, ask user to run `/research_codebase` first.

## Rule Loading Process

### Step 1: Read All Rules

Read and understand ALL rule files:
- `~/.claude/rules/shopify/*.mdc` - Shopify-specific rules
- `~/.claude/rules/general/*.mdc` - General development standards

Parse each rule file to extract:
- Requirements and restrictions
- Performance targets
- Code patterns to follow
- Anti-patterns to avoid

### Step 2: Create Rule-Based Plan Structure

Based on the rules loaded, dynamically structure the plan:

```markdown
# [Feature Name] Implementation Plan

**Based on Research**: `/tmp/shopify_research_[timestamp].md`
**Rules Applied**: [List all rule files being enforced]
**Created**: [current timestamp]

## Overview
[Brief description aligned with research findings]

## Rules Being Enforced

### From ~/.claude/rules/shopify/schemas.mdc:
[Extract and list key requirements from this rule]

### From ~/.claude/rules/general/javascript-standards.mdc:
[Extract and list key requirements from this rule]

[Continue for all rule files...]

## Implementation Approach
[Strategy that satisfies ALL loaded rules]

## Phase 1: Schema Definition

### Requirements (from schemas.mdc):
[Dynamically list requirements from the schema rules file]

### Implementation:
```liquid
[Schema following the rules loaded from schemas.mdc]
```

### Success Criteria:
[Generate checklist from schemas.mdc requirements]

## Phase 2: Liquid Implementation

### Requirements (from liquid-syntax.mdc):
[Dynamically list requirements from the liquid rules file]

### Implementation:
```liquid
[Code following the rules loaded from liquid-syntax.mdc]
```

### Success Criteria:
[Generate checklist from liquid-syntax.mdc requirements]

## Phase 3: JavaScript Enhancement

### Requirements (from javascript-standards.mdc):
[Dynamically list requirements from the JavaScript rules file]

### Implementation:
```javascript
[Code following the rules loaded from javascript-standards.mdc]
```

### Success Criteria:
[Generate checklist from javascript-standards.mdc requirements]

## Phase 4: Styling

### Requirements (from tailwindcss.mdc):
[Dynamically list requirements from the Tailwind rules file]

### Success Criteria:
[Generate checklist from tailwindcss.mdc requirements]

## Phase 5: Testing & Validation

### Requirements (from accessibility.mdc and all other rules):
[Dynamically list testing requirements from all rule files]

### Success Criteria:
[Generate comprehensive test checklist from all rules]

## Rule Compliance Matrix

| Rule File | Requirements | Implementation Phase | Validation Method |
|-----------|--------------|---------------------|-------------------|
| schemas.mdc | [Summary] | Phase 1 | [How to verify] |
| liquid-syntax.mdc | [Summary] | Phase 2 | [How to verify] |
| javascript-standards.mdc | [Summary] | Phase 3 | [How to verify] |
| [etc...] | | | |
```

## Dynamic Rule Enforcement

### For Each Rule File:

1. **Parse the rule file** to extract:
   - Core principles
   - Specific requirements
   - Code examples (good and bad)
   - Performance targets
   - Validation criteria

2. **Apply to relevant phase**:
   - Schema rules → Phase 1
   - Liquid rules → Phase 2
   - JavaScript rules → Phase 3
   - CSS/Tailwind rules → Phase 4
   - All rules → Phase 5 (validation)

3. **Generate success criteria** directly from rules:
   - Convert each rule requirement into a checklist item
   - Include specific metrics from rules (e.g., "<16ms" from JavaScript rules)
   - Reference rule file and line number for traceability

## Example Rule Application

When reading `javascript-standards.mdc`, extract and apply:

```markdown
### From javascript-standards.mdc:

**Core Requirements Found:**
- Line 41-44: Private fields MUST use # syntax
- Line 142-143: AbortController REQUIRED for event cleanup
- Line 1120: Component initialization must be < 16ms
- Line 726-1089: Avoid layout thrashing (detailed patterns)

**Applied to Phase 3:**
- [ ] Private fields with # syntax (Line 41)
- [ ] AbortController in all components (Line 142)
- [ ] Measure and ensure init < 16ms (Line 1120)
- [ ] Batch DOM operations (Line 726-1089)
```

## Process Flow

1. **Read research document** for context
2. **Read ALL rule files** to understand requirements
3. **Parse rules** to extract actionable requirements
4. **Generate plan phases** with rule-based success criteria
5. **Create compliance matrix** showing which rules apply where
6. **Save plan** with full rule traceability

## Important Guidelines

- **Never hardcode rules** - Always read from rule files
- **Include rule references** - Show which rule file and line
- **Update dynamically** - When rules change, plan adapts
- **Complete coverage** - Every rule must be addressed
- **Clear traceability** - Easy to see rule → requirement → implementation

## Integration with Workflow

This command:
- **Reads**: Research document + ALL rule files
- **Produces**: Plan with dynamic rule enforcement
- **Enables**: Implementation that automatically follows current rules
- **Adapts**: When rules are updated, plans reflect changes

The plan becomes a living document that enforces whatever rules exist in `~/.claude/rules/` at the time of creation.