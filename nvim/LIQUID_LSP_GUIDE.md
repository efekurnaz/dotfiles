# Liquid LSP & Completion Guide

## How LSP Works with Liquid Files

### Auto-Completion Behavior

**For Liquid files only**, LSP completions are enabled and will automatically trigger when you:

1. **Type `{{ `** - Shows available Liquid objects (product, collection, shop, etc.)
2. **Type `{% `** - Shows available Liquid tags (if, for, assign, etc.)  
3. **Type `|` (pipe)** - Shows available Liquid filters (upcase, downcase, money, etc.)
4. **Type after spaces in Liquid contexts** - Context-aware suggestions

### Key Bindings for Completions

When the completion menu is visible:
- **↓/↑ Arrow Keys** - Navigate through suggestions
- **Enter** - Accept selected completion
- **Ctrl+Space** - Manually trigger completion anywhere
- **Ctrl+e** - Close completion menu
- **Tab** - Reserved for Supermaven (AI suggestions)

### LSP Features Available

All these work in Liquid files:

| Key | Action | Description |
|-----|--------|-------------|
| `K` | Hover | Show documentation for Liquid tags/filters/objects |
| `gd` | Go to Definition | Jump to where something is defined |
| `gr` | Find References | Find all uses of a variable/snippet |
| `<leader>ca` | Code Actions | Quick fixes and refactoring |
| `<leader>cr` | Rename | Rename variables across files |
| `<leader>cf` | Format | Format the file with Prettier |

### Theme Check Commands

| Key | Command | Description |
|-----|---------|-------------|
| `<leader>tc` | `:ThemeCheck` | Run theme checks for errors |
| `<leader>td` | `:ThemeCheckDeadCode` | Find unused templates/snippets |
| `<leader>tr` | Restart LSP | Restart the language server |

### Working with Supermaven

The setup is configured so:
- **Supermaven** uses `Tab` for AI suggestions (works everywhere)
- **LSP completions** use arrow keys in Liquid files
- Both can work together without conflicts

### Example Workflow

1. Start typing a Liquid tag:
   ```liquid
   {% if| 
   ```
   *(completion menu appears automatically)*

2. Use arrow keys to select `if`
   ```liquid
   {% if product.available %}
   ```

3. Type `{{ p` and completions show `product`, `page`, etc.

4. Use `Tab` anytime for Supermaven's AI suggestions

### Checking LSP Status

To verify LSP is working:
1. Open a `.liquid` file
2. Run `:LspInfo`
3. You should see `theme_check` client attached

### Manual Completion

If auto-completion doesn't trigger:
- Press `Ctrl+Space` to manually open completions
- Or use `Ctrl+x Ctrl+o` for omni-completion

### Troubleshooting

If completions aren't working:

1. **Check LSP is running**: `:LspInfo`
2. **Restart LSP**: `<leader>tr` or `:LspRestart`
3. **Check for errors**: `:messages`
4. **Verify in Liquid file**: Completions only work in `.liquid` files

### Tips for Better Completions

1. **Project Structure**: Keep your Liquid files in a Shopify theme structure (templates/, sections/, snippets/)
2. **Theme Check Config**: Add `.theme-check.yml` to your project root
3. **Wait for LSP**: Give it a second to analyze files when first opening
4. **Use filters**: Type `|` after variables for filter suggestions

### Disabling Completions

If you want to disable auto-completions for Liquid:
- Edit `~/.config/nvim/lua/plugins.lua`
- Change the `enabled` function to return `false`

## Summary

- **Liquid files** = LSP completions enabled automatically
- **Other files** = Only Supermaven (Tab)
- **Manual trigger** = Ctrl+Space anywhere
- **Navigation** = Arrow keys when menu is open
- **AI suggestions** = Tab (Supermaven) always available