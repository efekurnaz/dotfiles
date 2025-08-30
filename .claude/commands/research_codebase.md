---
color: yellow
---

# Research Shopify Codebase

You are tasked with conducting comprehensive research across the Shopify theme codebase to gather all necessary context for planning and implementation. This research will be saved and used by subsequent commands.

## Initial Setup

When this command is invoked, respond with:

```
I'm ready to research the Shopify theme codebase. Please provide your research question or feature description, and I'll analyze the codebase thoroughly to gather all necessary context for planning and implementation.
```

Then wait for the user's research query.

## Research Process

### Step 1: Read Mentioned Files First

If the user mentions specific files:
- **ALWAYS** read them FULLY first (no limit/offset)
- This provides immediate context before decomposing research
- Understand the existing implementation before researching further

### Step 2: Create Research Plan

Use TodoWrite to track research tasks:
- Locate relevant files
- Analyze implementation patterns
- Find similar examples
- Research web documentation if needed
- Compile findings

### Step 3: Spawn Parallel Research Agents

Launch multiple specialized agents concurrently:

```markdown
**Codebase Research Tasks:**
1. Use `shopify-codebase-locator` to find WHERE relevant files exist
2. Use `shopify-codebase-analyzer` to understand HOW implementations work
3. Use `shopify-codebase-pattern-finder` to find EXAMPLES to follow

**Web Research Tasks (if needed):**
4. Use `shopify-web-researcher` for API documentation and platform features
```

### Step 4: Wait and Compile Results

- **IMPORTANT**: Wait for ALL agents to complete
- Compile findings from all sources
- Cross-reference patterns with our rules
- Note performance implications
- Identify reusable components

### Step 5: Generate Research Document

Save findings to `/tmp/shopify_research_[timestamp].md`:

```markdown
# Shopify Research Report

**Date**: [timestamp]
**Feature**: [user's request]
**Research ID**: [unique ID for reference]

## Executive Summary
[2-3 sentences summarizing key findings and recommendations]

## Existing Codebase Analysis

### Relevant Files Located
- `sections/[file].liquid` - [purpose]
- `snippets/[file].liquid` - [reusable component]
- `_scripts/components/[file].js` - [web component]

### Current Implementation Patterns
- [Pattern with file:line reference]
- [How it works]
- [Performance measurements]

### Reusable Components Found
- `snippets/[component].liquid` - Can be used for [purpose]
- `_scripts/utils/[utility].js` - Provides [functionality]

## Similar Implementations (Models to Follow)

### Example 1: [Component Name]
**Location**: `sections/[file].liquid:123-456`
**Pattern**: [Description]
**Performance**: [Measurements]
```liquid
[Code snippet]
```

## Rule Compliance Analysis

### Standards to Apply:
- **Schema Rules**: Max 5 settings, use translations
- **JavaScript**: Private fields, AbortController, <16ms init
- **Liquid**: {% liquid %} blocks, {% render %}, lazy loading
- **Accessibility**: WCAG 2.1 AA, keyboard navigation
- **Tailwind**: Mobile-first, utility classes only

### Violations Found in Existing Code:
- [File:line] - [Violation] - [How to fix]

## Platform Requirements

### Shopify APIs Needed:
- [API name] - [Purpose]
- Rate limits: [details]
- Authentication: [method]

### Theme Features:
- Online Store 2.0 compatible
- Section groups supported
- Dynamic sections allowed

## Performance Considerations
- Current similar components initialize in [X]ms
- Liquid render time for similar sections: [X]ms
- Bundle size impact: [X]kb

## Recommendations for Implementation

### Approach:
[Recommended approach based on findings]

### Files to Create/Modify:
1. `sections/[new-section].liquid` - Main section
2. `snippets/[new-snippet].liquid` - Reusable component
3. `_scripts/components/[new-component].js` - Web component

### Patterns to Follow:
- Use pattern from `sections/[example].liquid` for structure
- Follow schema from `sections/[example].liquid:100-120`
- Model JavaScript after `_scripts/components/[example].js`

### Potential Challenges:
- [Challenge and mitigation]

## Context for Next Steps

This research provides the foundation for:
- `/create_plan` - Will use these findings to create detailed implementation plan
- `/implement_plan` - Will reference these patterns during coding
- `/validate_plan` - Will check against these standards

**Research File Path**: `/tmp/shopify_research_[timestamp].md`
```

### Step 6: Present Summary

Provide concise summary to user:

```
Research complete! I've analyzed the codebase and compiled comprehensive findings.

**Key Discoveries:**
- [Most important finding]
- [Patterns to follow]
- [Potential challenges]

**Saved Research**: `/tmp/shopify_research_[timestamp].md`

This research document contains:
- All relevant file locations and patterns
- Rule compliance analysis
- Performance benchmarks
- Recommendations for implementation

You can now:
1. Run `/create_plan` to create a detailed implementation plan based on this research
2. Ask follow-up questions about specific findings
3. Request deeper analysis of particular areas
```

## Important Notes

- **Always save research** to `/tmp/shopify_research_[timestamp].md`
- **Include research ID** for reference by other commands
- **Wait for all agents** before compiling results
- **Cross-reference with rules** in ~/.claude/rules/
- **Focus on actionable findings** not just information
- **Provide clear recommendations** based on evidence

## Integration with Other Commands

This research will be used by:
- `/create_plan` - Reads research document to create informed plan
- `/implement_plan` - References patterns and examples during coding
- `/validate_plan` - Checks implementation against research findings

The research document serves as the single source of truth for the entire workflow.