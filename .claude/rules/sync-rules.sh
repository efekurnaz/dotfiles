#!/bin/bash

# Sync global rules to a project
# Usage: ./sync-rules.sh /path/to/project [--shopify]

PROJECT_DIR="$1"
RULES_DIR="$HOME/.claude/rules"
IS_SHOPIFY=false

# Check if project directory is provided
if [ -z "$PROJECT_DIR" ]; then
    echo "Usage: $0 /path/to/project [--shopify]"
    echo "  --shopify : Include Shopify-specific rules"
    exit 1
fi

# Check for --shopify flag
if [ "$2" == "--shopify" ]; then
    IS_SHOPIFY=true
fi

# Auto-detect Shopify project
if [[ -f "$PROJECT_DIR/shopify.theme.toml" ]] || [[ -f "$PROJECT_DIR/.shopifyignore" ]] || [[ -d "$PROJECT_DIR/sections" && -d "$PROJECT_DIR/templates" ]]; then
    IS_SHOPIFY=true
    echo "✓ Detected Shopify theme project"
fi

# Create .cursor/rules directory if it doesn't exist
mkdir -p "$PROJECT_DIR/.cursor/rules"

echo "📦 Syncing global rules to $PROJECT_DIR/.cursor/rules/"

# Copy general rules
echo "📋 Copying general development rules..."
cp "$RULES_DIR/general/"*.mdc "$PROJECT_DIR/.cursor/rules/" 2>/dev/null

# For Shopify projects, also copy Shopify rules
if [ "$IS_SHOPIFY" = true ]; then
    echo "🛍️  Copying Shopify-specific rules..."
    cp "$RULES_DIR/shopify/"*.mdc "$PROJECT_DIR/.cursor/rules/" 2>/dev/null
fi

# Copy template
echo "📝 Copying rule template..."
cp "$RULES_DIR/templates/cursor-rule-template.mdc" "$PROJECT_DIR/.cursor/rules/" 2>/dev/null

# Create global-rules-reference.mdc
cat > "$PROJECT_DIR/.cursor/rules/global-rules-reference.mdc" << 'EOF'
---
description: References to global rules synced for this project
globs: 
  - "**/*"
alwaysApply: false
---
# Global Rules Reference

This project uses global rules synced from ~/.claude/rules/

## Last Sync
EOF

echo "Synced on: $(date)" >> "$PROJECT_DIR/.cursor/rules/global-rules-reference.mdc"

cat >> "$PROJECT_DIR/.cursor/rules/global-rules-reference.mdc" << 'EOF'

## Included Rules

### General Development Standards
- `javascript-standards.mdc` - JavaScript best practices with layout/reflow optimization
- `accessibility.mdc` - WCAG 2.1 AA compliance standards
- `commit-conventions.mdc` - Git commit message conventions
- `tailwindcss.mdc` - Tailwind CSS guidelines

EOF

if [ "$IS_SHOPIFY" = true ]; then
    cat >> "$PROJECT_DIR/.cursor/rules/global-rules-reference.mdc" << 'EOF'
### Shopify Theme Development
- `liquid-syntax.mdc` - Liquid template language syntax
- `liquid-documentation.mdc` - Liquid documentation standards
- `schemas.mdc` - Shopify schema definitions
- `sections.mdc` - Section development guidelines
- `snippets.mdc` - Snippet best practices

EOF
fi

cat >> "$PROJECT_DIR/.cursor/rules/global-rules-reference.mdc" << 'EOF'
## Sync Command

To update these rules from the global repository:
```bash
~/.claude/rules/sync-rules.sh "$(pwd)"
```

## Note
Project-specific rules in this directory will override global rules.
Keep project-specific customizations in separate files to avoid conflicts during sync.
EOF

# Count synced files
GENERAL_COUNT=$(ls -1 "$PROJECT_DIR/.cursor/rules/"*mdc 2>/dev/null | wc -l)

echo ""
echo "✅ Rules synced successfully!"
echo "   📁 Location: $PROJECT_DIR/.cursor/rules/"
echo "   📊 Total rules: $GENERAL_COUNT files"

if [ "$IS_SHOPIFY" = true ]; then
    echo "   🛍️  Shopify rules: Included"
fi

echo ""
echo "💡 Tip: Add project-specific rules to $PROJECT_DIR/.cursor/rules/"
echo "        They will be preserved during future syncs."