# Neovim Configuration

A modern, well-documented Neovim configuration using Lua with the Dracula Pro colorscheme. This configuration is converted from VimScript to Lua for better performance, maintainability, and modern plugin management.

## 📸 Screenshots

The configuration uses the **Dracula Pro** colorscheme across all tools:
- **Neovim**: Dracula Pro with Airline statusline
- **Kitty Terminal**: Dracula Pro colors
- **Tmux**: Custom Dracula Pro theme

## ✨ Features

- **Modern Lua Configuration**: Fast, clean, and maintainable
- **Lazy Loading**: Plugins load only when needed for faster startup
- **Dracula Pro Theme**: Consistent colors across all tools
- **Smart Keybindings**: Intuitive shortcuts for common operations
- **Developer-Friendly**: Great support for web development (JS, TS, HTML, CSS, Liquid)
- **Well Documented**: Every setting and plugin explained

## 📦 Requirements

- **Neovim >= 0.8**: Required for Lua configuration
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

For questions or issues, please refer to the troubleshooting section or check the plugin documentation.