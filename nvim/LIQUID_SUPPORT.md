# Shopify Liquid Support for Neovim

This Neovim configuration now includes comprehensive support for Shopify Liquid templates, similar to the VSCode extension you were using.

## Features

### 1. **Language Server Protocol (LSP) Support**
- Full IntelliSense for Liquid tags, filters, and objects
- Auto-completion for Shopify theme objects
- Hover documentation
- Go to definition
- Find references
- Diagnostics and error checking

### 2. **Syntax Highlighting**
- Proper highlighting for Liquid tags `{% %}` and objects `{{ }}`
- Support for embedded languages (JavaScript, CSS, SCSS in `.liquid` files)
- Composite filetype support (e.g., `javascript.liquid`, `css.liquid`)

### 3. **Formatting**
- Prettier integration with Shopify Liquid plugin
- Format on save
- Manual formatting with `<leader>cf`

### 4. **Theme Check Integration**
- Run theme checks: `<leader>tc` or `:ThemeCheck`
- Find dead code: `<leader>td` or `:ThemeCheckDeadCode`
- Restart language server: `<leader>tr`

### 5. **Auto-pairs and Snippets**
- Automatic closing of Liquid tags: `{%` → `{% %}`
- Automatic closing of Liquid objects: `{{` → `{{ }}`
- Liquid snippet abbreviations (type in insert mode):
  - `lif` → `{% if %} {% endif %}`
  - `lfor` → `{% for item in collection %} {% endfor %}`
  - `lassign` → `{% assign variable = value %}`
  - `lcapture` → `{% capture variable %} {% endcapture %}`
  - `lcomment` → `{% comment %} {% endcomment %}`
  - `lraw` → `{% raw %} {% endraw %}`
  - And many more...

### 6. **Navigation**
- Use `%` to jump between matching Liquid tags (if/endif, for/endfor, etc.)
- `]]` / `[[` to navigate between Liquid blocks
- `][` / `[]` to navigate between block endings

### 7. **Visual Mode Features**
Select text in visual mode and use:
- `<leader>li` - Wrap selection in if block
- `<leader>lf` - Wrap selection in for block
- `<leader>lc` - Wrap selection in comment block
- `<leader>lr` - Wrap selection in raw block
- `<leader>lp` - Wrap selection in capture block

## File Types Supported

- `.liquid` - HTML templates with Liquid
- `.js.liquid` - JavaScript with Liquid
- `.ts.liquid` - TypeScript with Liquid
- `.css.liquid` - CSS with Liquid
- `.scss.liquid` / `.sass.liquid` - SCSS/SASS with Liquid
- `.json.liquid` - JSON with Liquid
- Shopify theme JSON files (sections, templates, config, locales)

## Key Bindings

### LSP Commands
- `gd` - Go to definition
- `gr` - Find references
- `K` - Show hover documentation
- `<leader>ca` - Code actions
- `<leader>cr` - Rename symbol
- `<leader>cf` - Format file

### Theme Check Commands
- `<leader>tc` - Run theme checks
- `<leader>td` - Find dead code
- `<leader>tr` - Restart language server

### Liquid-specific
- In insert mode: `{{` / `{%` - Auto-close tags
- In visual mode: `<leader>l[i/f/c/r/p]` - Wrap in Liquid blocks

## Testing the Configuration

1. Open the test file:
   ```
   nvim ~/.config/nvim/test-liquid-example.liquid
   ```

2. Test auto-completion:
   - Type `{{` and see if it auto-closes
   - Type `{% if` and check for suggestions

3. Test LSP features:
   - Hover over Liquid objects/filters with `K`
   - Try formatting with `<leader>cf`

4. Test Theme Check:
   - Run `<leader>tc` to check for theme issues
   - Run `<leader>td` to find dead code

## Troubleshooting

If the language server doesn't start:
1. Check if it's installed: `which theme-language-server`
2. Restart Neovim
3. Check LSP status: `:LspInfo`
4. Manually restart: `:LspRestart theme_check`

If formatting doesn't work:
1. Ensure Prettier is installed: `which prettier`
2. Check if the Liquid plugin is installed: `npm list -g @shopify/prettier-plugin-liquid`
3. Try manual format: `:lua vim.lsp.buf.format()`

## Requirements

The following npm packages are required (already installed):
- `@shopify/theme-language-server-node`
- `@shopify/prettier-plugin-liquid`

## Project Structure Detection

The LSP will automatically detect Shopify theme projects by looking for:
- `.theme-check.yml` or `.theme-check.yaml`
- `theme.toml`
- `config.yml`
- Theme directories: `templates/`, `sections/`, `snippets/`, `layout/`

Place your Liquid files in a Shopify theme structure for best results.