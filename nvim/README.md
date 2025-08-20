# 🧛‍♂️ Dracula Pro Neovim Configuration

A modern, feature-rich Neovim configuration powered by **lazy.nvim** with **Dracula Pro** theme integration. This setup transforms Neovim into a full-fledged IDE with LSP support, auto-completion, modern file exploration, and much more.

## 📸 Screenshots

The configuration uses the **Dracula Pro** colorscheme across all tools:
- **Neovim**: Dracula Pro with Airline statusline and modern plugins
- **LSP Integration**: Full language server support with diagnostics
- **Neo-tree**: Modern file explorer with git integration
- **Dashboard**: Beautiful startup screen with session management

## ✨ Features

### 🎨 **Theme & UI**
- **Dracula Pro** colorscheme with custom theme integration
- Modern **statusline** with vim-airline and powerline fonts
- **Alpha dashboard** with session management
- **Which-key** popup for command discovery
- Custom **Liquid template** syntax highlighting

### 🧠 **LSP & Intelligence**
- **Language Server Protocol** support via `nvim-lspconfig`
- **Mason** for automatic LSP server management
- **Auto-completion** with `nvim-cmp` and multiple sources
- **Diagnostics** panel with Trouble.nvim
- **Code actions**, hover info, go-to-definition, and more

### 📁 **File Management**
- **Neo-tree** modern file explorer with git integration
- **FZF** fuzzy finding for files and text search
- **Session persistence** for project restoration
- **Git integration** with gitsigns and fugitive

### 🔧 **Code Quality**
- **Formatting** with conform.nvim (Prettier, stylua, etc.)
- **Linting** with nvim-lint (ESLint, etc.)
- **Treesitter** syntax highlighting
- **Auto-formatting** on save

### ⚡ **Performance**
- **Lazy loading** of all plugins
- Optimized startup time
- Efficient buffer management
- Smart autocommands

## 📦 Requirements

- **Neovim >= 0.9.0**: Required for modern Lua features
- **Git**: For plugin management
- **Node.js**: For some plugins (Prettier, etc.)
- **ripgrep**: For fast text searching with FZF
- **FZF**: Fuzzy file finder
- **Nerd Fonts**: For powerline symbols and icons

### macOS Installation
```bash
# Install Neovim
brew install neovim

# Install dependencies
brew install git nodejs ripgrep fzf

# Install a Nerd Font (recommended: JetBrains Mono)
brew tap homebrew/cask-fonts
brew install --cask font-jetbrains-mono-nerd-font
```

## 🚀 Installation

### 1. Backup Existing Configuration
```bash
# Backup your current nvim config
mv ~/.config/nvim ~/.config/nvim.backup.$(date +%Y%m%d)
mv ~/.local/share/nvim ~/.local/share/nvim.backup.$(date +%Y%m%d)
```

### 2. Install This Configuration
```bash
# Clone or copy the configuration files to ~/.config/nvim/
# The directory structure should look like:
# ~/.config/nvim/
# ├── init.lua
# ├── lua/
# │   ├── options.lua
# │   ├── mappings.lua
# │   ├── plugins.lua
# │   └── autocmds.lua
# └── README.md
```

### 3. Install Dracula Pro Theme Files
The Dracula Pro theme files should already be in place:
```
~/.config/nvim/colors/
├── dracula_pro.vim
└── dracula_pro_base.vim

~/.config/nvim/autoload/
├── dracula_pro.vim
└── airline/
    └── themes/
        └── dracula_pro.vim
```

### 4. First Launch
```bash
# Launch Neovim
nvim

# lazy.nvim will automatically:
# 1. Install itself
# 2. Install all plugins
# 3. Set up the configuration

# Check plugin status
:Lazy
```

## 📁 Configuration Structure

```
~/.config/nvim/
├── init.lua              # Main entry point - loads all modules
├── lua/
│   ├── options.lua       # Vim settings and options
│   ├── mappings.lua      # Key mappings and shortcuts  
│   ├── plugins.lua       # Plugin management with lazy.nvim
│   └── autocmds.lua      # Autocommands and file associations
├── colors/               # Dracula Pro colorscheme files
├── autoload/            # Vim autoload functions and airline theme
└── README.md            # This file
```

### File Descriptions

| File | Purpose | Equivalent VimScript |
|------|---------|---------------------|
| `init.lua` | Main configuration entry point | `init.vim` |
| `lua/options.lua` | Vim options and settings | Options in `init.vim` |
| `lua/mappings.lua` | Key mappings and shortcuts | `mappings.vim` |
| `lua/plugins.lua` | Plugin management and configuration | `plugins.vim` |
| `lua/autocmds.lua` | Autocommands and file type settings | `functions.vim` |

## 🔧 Key Features Explained

### Plugin Management (lazy.nvim)

This configuration uses **lazy.nvim** instead of vim-plug for several advantages:

- **Lazy Loading**: Plugins load only when needed
- **Better Performance**: Faster startup times
- **Modern UI**: Beautiful plugin management interface
- **Dependency Management**: Automatic handling of plugin dependencies

### Dracula Pro Integration

The configuration includes full Dracula Pro integration:

1. **Neovim Colorscheme**: `colorscheme dracula_pro`
2. **Airline Theme**: Matching statusline colors
3. **Kitty Terminal**: Coordinated terminal colors
4. **Tmux**: Custom theme integration

### Smart Lazy Loading

Plugins are configured to load only when needed:

```lua
-- Only loads when using these key bindings
{ "junegunn/fzf.vim", keys = { "<C-P>", "<C-E>" } }

-- Only loads for specific file types
{ "dag/vim-fish", ft = "fish" }

-- Only loads when using specific commands
{ "junegunn/goyo.vim", cmd = "Goyo" }
```

## ⌨️ Key Bindings

### Essential Shortcuts

| Key | Mode | Action | Description |
|-----|------|--------|-------------|
| `Space` | Normal | `:` | Enter command mode |
| `Ctrl+P` | Normal | `:GFiles` | Find files in git repo |
| `Ctrl+E` | Normal | `:Rg` | Search text in files |
| `Ctrl+K` | Normal | `:bnext` | Next buffer |
| `Ctrl+J` | Normal | `:bprev` | Previous buffer |
| `Ctrl+Q` | Normal | `:bd` | Close buffer |
| `Esc` | Normal | `:noh` | Clear search highlight |

### Text Editing

| Key | Mode | Action | Description |
|-----|------|--------|-------------|
| `c` | Normal | `"_c` | Change without yanking |
| `<leader>d` | Visual | `"_d` | Delete without yanking |
| `<leader>p` | Visual | `"_dP` | Paste without yanking |

### Navigation

| Key | Mode | Action | Description |
|-----|------|--------|-------------|
| `j/k` | Normal | `gj/gk` | Move by display lines |
| `n/N` | Normal | `nzzzv/Nzzzv` | Center search results |
| `Ctrl+d/u` | Normal | `<C-d>zz/<C-u>zz` | Center half-page scroll |

### Search & Replace

| Key | Mode | Action | Description |
|-----|------|--------|-------------|
| `<leader>r` | Normal | `:%s///g` | Replace word under cursor |
| `<leader>rc` | Normal | `:%s///gc` | Replace with confirmation |
| `<leader>r` | Visual | `:s///g` | Replace selected text |

## 🔌 Plugins Overview

### Core Functionality
- **lazy.nvim**: Modern plugin manager with lazy loading
- **dracula/vim**: Dracula colorscheme
- **vim-airline**: Statusline with Dracula Pro theme
- **nvim-treesitter**: Advanced syntax highlighting

### File Navigation
- **fzf + fzf.vim**: Fuzzy file finding and text search
- **vim-fugitive**: Git integration

### Text Editing
- **vim-surround**: Surround text with brackets/quotes
- **vim-commentary**: Comment/uncomment lines
- **auto-pairs**: Auto-close brackets and quotes
- **vim-visual-multi**: Multi-cursor editing

### Language Support
- **JavaScript/TypeScript**: Full syntax and JSX support  
- **HTML/CSS**: Enhanced highlighting and emmet
- **Liquid**: Shopify template support
- **Markdown**: Improved syntax highlighting
- **Fish/Tmux**: Shell configuration support

### Utilities
- **easymotion**: Fast navigation
- **indentLine**: Visual indentation guides
- **prettier**: Code formatting
- **goyo**: Distraction-free writing

## 🎨 Customization

### Adding New Plugins

Add plugins to `lua/plugins.lua`:

```lua
-- Simple plugin
"author/plugin-name",

-- Plugin with configuration
{
  "author/plugin-name",
  config = function()
    -- Plugin setup code
  end,
}

-- Plugin with lazy loading
{
  "author/plugin-name", 
  ft = "filetype",           -- Load for specific file types
  keys = { "<leader>x" },    -- Load when key is pressed
  cmd = "CommandName",       -- Load when command is used
}
```

### Modifying Key Bindings

Edit key bindings in `lua/mappings.lua`:

```lua
-- Add new mapping
map('n', '<leader>x', ':YourCommand<CR>')

-- Modify existing mapping
map('n', '<C-P>', ':YourNewCommand<CR>')
```

### Changing Options

Modify settings in `lua/options.lua`:

```lua
-- Change tab width
opt.tabstop = 4
opt.shiftwidth = 4

-- Enable line wrapping
opt.wrap = true
```

### Adding Autocommands

Add autocommands in `lua/autocmds.lua`:

```lua
autocmd('BufWritePre', {
  pattern = '*.py',
  callback = function()
    -- Python-specific actions before save
  end,
})
```

## 🚨 Troubleshooting

### Plugin Issues

```bash
# Check plugin status
:Lazy

# Reinstall all plugins
:Lazy sync

# Check for plugin health issues
:checkhealth lazy
```

### Colorscheme Issues

```bash
# Verify Dracula Pro files exist
:colorscheme dracula_pro

# Check if files are in correct location
:echo $VIMRUNTIME
```

### Performance Issues

```bash
# Profile startup time
:Lazy profile

# Check treesitter status
:checkhealth nvim-treesitter
```

### Common Solutions

1. **Plugins not loading**: Run `:Lazy sync`
2. **Colors not working**: Check terminal supports 24-bit color
3. **Icons missing**: Install a Nerd Font and configure terminal
4. **FZF not working**: Install `ripgrep` and `fzf` via package manager

## 🔄 Migration from VimScript

This configuration replaces the old VimScript setup:

| Old File | New File | Changes |
|----------|----------|---------|
| `init.vim` | `init.lua` + `lua/options.lua` | Split into modules |
| `mappings.vim` | `lua/mappings.lua` | Converted to Lua |
| `plugins.vim` | `lua/plugins.lua` | Modern plugin manager |
| `functions.vim` | `lua/autocmds.lua` | Better autocommand API |

### Key Improvements

1. **Performance**: Faster startup with lazy loading
2. **Maintainability**: Modular, well-documented structure
3. **Modern Features**: Latest Neovim Lua APIs
4. **Plugin Management**: Better dependency handling
5. **Documentation**: Every setting explained

## 📚 Learning Resources

### Neovim Lua
- [Neovim Lua Guide](https://neovim.io/doc/user/lua-guide.html)
- [Lua for Vim Users](https://github.com/nanotee/nvim-lua-guide)

### Plugin Management
- [lazy.nvim Documentation](https://github.com/folke/lazy.nvim)
- [Plugin Specifications](https://github.com/folke/lazy.nvim#-plugin-spec)

### Vim Fundamentals
- [Vim Adventures](https://vim-adventures.com/) - Learn Vim through games
- [Practical Vim](https://pragprog.com/titles/dnvim2/practical-vim-second-edition/) - Book

## 🤝 Contributing

Feel free to:
- Report issues or bugs
- Suggest improvements
- Add new plugins or features
- Improve documentation

## 📄 License

This configuration is free to use and modify. The Dracula Pro theme has its own licensing terms.

---

**Author**: Efe Kurnaz  
**Last Updated**: 2024  
**Neovim Version**: 0.8+  

## 📋 Complete Plugin List

### 🔧 **Core Infrastructure**
- **lazy.nvim** - Modern plugin manager with lazy loading
- **plenary.nvim** - Common utilities library  
- **nui.nvim** - UI components library

### 🎨 **Theme & Appearance**
- **dracula/vim** - Dracula Pro colorscheme
- **vim-airline** - Statusline with themes
- **nvim-colorizer.lua** - Hex color visualization
- **nvim-web-devicons** - File type icons
- **alpha-nvim** - Dashboard with ASCII art

### 🧠 **LSP & Completion**
- **nvim-lspconfig** - LSP client configuration
- **mason.nvim** - LSP server package manager
- **mason-lspconfig.nvim** - Bridge between Mason and LSP
- **nvim-cmp** - Autocompletion engine
- **LuaSnip** - Snippet engine
- **friendly-snippets** - Snippet collection
- **schemastore.nvim** - JSON schemas

### 📁 **File Management**
- **neo-tree.nvim** - Modern file explorer
- **fzf.vim** - Fuzzy finder
- **nvim-window-picker** - Window selection

### 🌊 **Git Integration**
- **vim-fugitive** - Git commands in Vim
- **gitsigns.nvim** - Git signs in gutter

### 🔍 **Search & Navigation**
- **trouble.nvim** - Diagnostics panel
- **which-key.nvim** - Key binding help
- **easymotion/vim-easymotion** - Fast navigation

### 🔧 **Code Quality**
- **conform.nvim** - Modern formatter
- **nvim-lint** - Linter integration
- **nvim-treesitter** - Syntax highlighting

### 🛠️ **Editing Enhancement**
- **vim-surround** - Surround text objects
- **vim-commentary** - Comment/uncomment
- **vim-visual-multi** - Multiple cursors
- **auto-pairs** - Auto-close brackets
- **supermaven-nvim** - AI code completion

### 💾 **Session & Persistence**
- **persistence.nvim** - Session management

## ⌨️ Key Mappings

> **Leader Key**: `<Space>` (Spacebar)

### 🗂️ **File Operations**
| Key | Action | Description |
|-----|--------|-------------|
| `<Space>` | `:` | Enter command mode |
| `<C-P>` | `:Files` | Find files |
| `<C-E>` | `:Rg` | Search text in files |
| `<C-[>` | `:GFiles?` | Git files with status |
| `<leader>e` | Neo-tree focus | Focus file explorer |
| `<leader>fe` | Neo-tree toggle | Toggle file explorer |
| `<leader>fE` | Neo-tree float | Floating file explorer |

### 🔄 **Buffer Management**
| Key | Action | Description |
|-----|--------|-------------|
| `<C-K>` | `:bnext` | Next buffer |
| `<C-J>` | `:bprev` | Previous buffer |
| `<C-Q>` | `:bd` | Close buffer |

### 🧠 **LSP Operations**
| Key | Action | Description |
|-----|--------|-------------|
| `gd` | Go to definition | Jump to symbol definition |
| `gr` | Show references | List all references |
| `gI` | Go to implementation | Jump to implementation |
| `gy` | Go to type definition | Jump to type definition |
| `K` | Hover info | Show documentation |
| `<leader>ca` | Code actions | Show available actions |
| `<leader>cr` | Rename | Rename symbol |
| `<leader>cf` | Format | Format document |

### 🔍 **Diagnostics**
| Key | Action | Description |
|-----|--------|-------------|
| `<leader>xx` | Toggle Trouble | Show/hide diagnostics panel |
| `<leader>xw` | Workspace diagnostics | Show workspace issues |
| `<leader>xd` | Document diagnostics | Show current file issues |
| `<leader>xl` | Location list | Show location list |
| `<leader>xq` | Quickfix | Show quickfix list |

### 🌊 **Git Operations**
| Key | Action | Description |
|-----|--------|-------------|
| `]c` | Next hunk | Next git change |
| `[c` | Previous hunk | Previous git change |
| `<leader>gs` | Stage hunk | Stage git hunk |
| `<leader>gr` | Reset hunk | Reset git hunk |
| `<leader>gp` | Preview hunk | Preview git change |
| `<leader>gb` | Blame line | Show git blame |
| `<leader>gd` | Diff this | Show git diff |

### 💾 **Session Management**
| Key | Action | Description |
|-----|--------|-------------|
| `<leader>qs` | Restore session | Restore saved session |
| `<leader>ql` | Last session | Restore last session |
| `<leader>qd` | Don't save | Skip session saving |

### 🤖 **Claude Integration**
| Key | Action | Description |
|-----|--------|-------------|
| `<leader>i` | Toggle Claude | Hide/show Claude terminal (preserves conversation) |
| `<leader>I` | Close Claude | Completely end Claude session |
| `<Esc>` (in terminal) | Exit insert | Exit terminal insert mode |

### 🗂️ **Neo-tree Navigation** (within file explorer)
| Key | Action | Description |
|-----|--------|-------------|
| `←` / `h` | Collapse folder | Close/collapse current folder |
| `→` / `l` | Expand folder | Open/expand current folder |
| `<Space>` | Toggle node | Expand/collapse folder |
| `<Enter>` | Open file | Open selected file |
| `q` | Close Neo-tree | Close the file explorer |

## 🎨 Theme Customization

This configuration includes extensive **Dracula Pro** theme integration:

### Color Palette
- **Background**: `#282a36`
- **Foreground**: `#f8f8f2`
- **Pink**: `#ff79c6`
- **Purple**: `#bd93f9`
- **Cyan**: `#8be9fd`
- **Green**: `#50fa7b`
- **Orange**: `#ffb86c`
- **Red**: `#ff5555`
- **Yellow**: `#f1fa8c`

### Custom Highlights
The configuration includes custom highlighting for:
- **LSP diagnostics** with appropriate colors
- **Completion menus** with Dracula Pro styling
- **Git signs** in the gutter
- **Neo-tree** file explorer
- **Liquid templates** with HTML tag highlighting
- **JSON files** with proper syntax coloring

## 🚀 Language Support

### Automatic LSP Setup
The following language servers are automatically installed:

- **TypeScript/JavaScript** - `ts_ls`
- **HTML** - `html`
- **CSS** - `cssls`
- **JSON** - `jsonls`
- **Lua** - `lua_ls`
- **Bash** - `bashls`

### Formatters & Linters
Automatically configured:

- **Prettier** - JS/TS/CSS/HTML/JSON
- **ESLint** - JavaScript/TypeScript linting
- **stylua** - Lua formatting
- **shfmt** - Shell script formatting

## 🔄 Updating

### Update Plugins
```bash
:Lazy sync
```

### Update LSP Servers
```bash
:Mason
```

### Update Configuration
```bash
cd ~/.config/nvim
git pull
:Lazy sync
```

## 🐛 Troubleshooting

### Common Issues

#### LSP Not Working
1. Check if Mason installed servers: `:Mason`
2. Verify LSP status: `:LspInfo`
3. Restart LSP: `:LspRestart`

#### Plugins Not Loading
1. Update lazy.nvim: `:Lazy update`
2. Clear plugin cache: `:Lazy clear`
3. Reinstall: `:Lazy install`

#### Theme Issues
1. Ensure true color support: `:set termguicolors?`
2. Check terminal color support
3. Restart Neovim after theme changes

#### File Explorer Issues
1. Check Neo-tree status: `:Neotree show`
2. Toggle with: `<leader>fe`
3. Reset: `:Neotree close` then `:Neotree show`

### Useful Commands

```bash
:checkhealth          # Check Neovim health
:Lazy                 # Open plugin manager
:Mason                # Open LSP server manager
:LspInfo              # Show LSP information
:ConformInfo          # Show formatter info
:TroubleToggle        # Toggle diagnostics
```

## 🎯 Performance Tips

1. **Lazy Loading**: Most plugins are lazy-loaded for faster startup
2. **LSP Optimization**: Only runs when needed for specific file types
3. **Treesitter**: Incremental parsing for better performance
4. **Session Management**: Restore projects quickly

## 🤝 Contributing

Feel free to submit issues, fork the repository, and create pull requests for any improvements.

## 📝 License

This configuration is open source and available under the [MIT License](LICENSE).

---

### 🧛‍♂️ Dracula Pro Edition
*Beautiful darkness awaits...*

> **Note**: This configuration is optimized for development workflows and includes everything you need for modern coding. The Dracula Pro theme integration ensures a consistent, beautiful experience across all plugins and features.

For questions or issues, please refer to the troubleshooting section or check the plugin documentation.