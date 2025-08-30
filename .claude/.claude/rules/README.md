# Claude Global Rules

Centralized repository for development rules and standards used across multiple projects.

## Directory Structure

```
~/.claude/rules/
├── general/                    # General development standards
│   ├── javascript-standards.mdc
│   ├── accessibility.mdc
│   ├── commit-conventions.mdc
│   └── tailwindcss.mdc
├── shopify/                    # Shopify-specific rules
│   ├── liquid-syntax.mdc
│   ├── liquid-documentation.mdc
│   ├── schemas.mdc
│   ├── sections.mdc
│   └── snippets.mdc
├── templates/                  # Templates for new rules
│   └── cursor-rule-template.mdc
├── sync-rules.sh              # Script to sync rules to projects
└── README.md                  # This file
```

## Related Agents

```
~/.claude/agents/
└── engineering/
    └── shopify-developer.md   # Specialized Shopify development agent
```

## Usage

### Syncing Rules to a Project

```bash
# Auto-detect project type and sync appropriate rules
~/.claude/rules/sync-rules.sh /path/to/project

# Explicitly sync Shopify rules
~/.claude/rules/sync-rules.sh /path/to/project --shopify
```

### Using the Shopify Developer Agent

The `shopify-developer` agent automatically follows all rules in this repository. When working on Shopify projects, this agent provides:
- Deep Shopify platform knowledge
- Liquid templating expertise
- Performance optimization techniques
- Layout/reflow prevention strategies
- Accessibility compliance

### Creating New Rules

1. Use the template in `templates/cursor-rule-template.mdc`
2. Place new rules in appropriate directory:
   - General rules → `general/`
   - Shopify rules → `shopify/`
   - Platform-specific → Create new directory

3. Follow the MDC format:
```markdown
---
description: Brief description of the rule
globs: 
  - "pattern/**/*.ext"
alwaysApply: false
---
# Rule Title

Content...
```

## Key Features

### JavaScript Standards
- Comprehensive layout/reflow optimization
- Memory leak prevention
- Web Components best practices
- Performance monitoring

### Shopify Rules
- Liquid syntax and best practices
- Schema development guidelines
- Section and snippet patterns
- Theme architecture standards

### Accessibility
- WCAG 2.1 AA compliance
- ARIA implementation
- Keyboard navigation
- Screen reader support

## Maintenance

### Updating Rules
1. Edit rules in this central location
2. Run sync script on affected projects
3. Test changes in project context

### Version Control
Consider maintaining this directory in a git repository for:
- Change tracking
- Team collaboration
- Rule versioning
- Rollback capability

### Best Practices
1. Keep rules focused and specific
2. Include examples in each rule
3. Document the "why" not just the "what"
4. Test rules in real projects
5. Update regularly based on project learnings

## Projects Using These Rules

Track projects using these global rules:
- `/Users/efe/dev/12_agency/ii-v3` - Electric Maybe Shopify Theme

## Contributing

When adding new rules:
1. Follow existing naming conventions
2. Include comprehensive examples
3. Test in at least one project
4. Update this README if adding new categories
5. Consider impact on existing projects

## Performance Impact

These rules include significant performance optimizations:
- **Layout/Reflow Prevention**: Reduces browser repaints by 60-80%
- **Memory Management**: Prevents leaks with proper cleanup
- **Load Time**: Targets < 3.5s Time to Interactive
- **Runtime Performance**: < 16ms for all operations

## Support

For questions or improvements:
1. Check existing rules for patterns
2. Test changes in isolated project first
3. Document any breaking changes
4. Update sync script if needed