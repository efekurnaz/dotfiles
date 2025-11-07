# Tmux to Ghostty Migration Guide

## Installation

1. **Download Ghostty** from https://ghostty.org
2. **Install the app** by dragging to Applications folder
3. **Configuration is ready** at `~/.config/ghostty/config`

## Key Mapping Reference

Your tmux muscle memory will work with these Ghostty equivalents:

| tmux Command | Ghostty Equivalent | Action |
|-------------|-------------------|---------|
| `Ctrl+F, Ctrl+F` | `Ctrl+F, Ctrl+F` | Toggle last tab/window |
| `Ctrl+F, c` | `Ctrl+F, c` | New tab |
| `Ctrl+F, n` | `Ctrl+F, n` | Next tab |
| `Ctrl+F, p` | `Ctrl+F, p` | Previous tab |
| `Ctrl+F, w` | `Ctrl+F, w` | Close tab |
| `Ctrl+F, v` | `Ctrl+F, v` | Split vertically |
| `Ctrl+F, s` | `Ctrl+F, s` | Split horizontally |
| `Ctrl+F, h/j/k/l` | `Ctrl+F, h/j/k/l` | Navigate splits |
| `Ctrl+F, H/J/K/L` | `Ctrl+F, Shift+H/J/K/L` | Resize splits |
| `Ctrl+F, o` | `Ctrl+F, o` | Toggle quick terminal (popup) |
| `Ctrl+F, r` | `Ctrl+F, r` | Reload configuration |
| `Ctrl+F, x` | `Ctrl+F, x` | Close current split |

## Additional Ghostty Features

### Quick Terminal (Drop-down)
- **Global hotkey**: `` Cmd+` `` (backtick)
- Replaces tmux popup functionality
- Accessible from anywhere on macOS

### Command Palette
- **Hotkey**: `Cmd+Shift+P`
- Access all commands without memorizing keybinds
- New in Ghostty 1.2.0

### Direct Tab Access
- `Cmd+1` through `Cmd+9` - Jump to specific tabs
- No prefix needed

## Theme Configuration

Your configuration uses **Dracula Pro** theme to match your Neovim setup:
- Background: `#22212c` (matching nvim)
- Selection: `#454158` (matching nvim)
- Green accent: `#8aff80` (matching active borders)
- Purple accent: `#9580ff` (matching status bar)

## What You Gain with Ghostty

✅ **Native Performance**
- GPU acceleration (Metal on macOS)
- Smoother scrolling and rendering
- Better font rendering with ligatures

✅ **macOS Integration**
- Native tabs and splits
- System theme awareness
- Proper clipboard handling
- Retina display optimization

✅ **Modern Features**
- Background images (new in 1.2.0)
- Custom cursor shaders
- Command palette
- Quick terminal

## When to Still Use tmux

Keep tmux installed for:

🔧 **Remote Sessions**
```bash
ssh server
tmux new -s work
```

🔧 **Session Persistence**
- Long-running processes
- Disconnection protection
- Session sharing

🔧 **Advanced Features**
- Predefined layouts
- Input broadcasting
- Scripted automation

## Quick Start

1. **Launch Ghostty**
2. **Try your tmux keybinds** - they should feel familiar
3. **Use `Ctrl+F, r`** to reload config after any changes
4. **Explore new features** with `Cmd+Shift+P` (command palette)

## Troubleshooting

### Config not loading?
```bash
# Check config syntax
cat ~/.config/ghostty/config | head -20

# Verify theme files
ls ~/.config/ghostty/themes/
```

### Want different keybinds?
Edit `~/.config/ghostty/config` and reload with `Ctrl+F, r`

### Missing a tmux feature?
- Check the [Ghostty docs](https://ghostty.org/docs)
- Consider keeping tmux for that specific use case
- Follow [Ghostty development](https://github.com/ghostty-org/ghostty) for updates

## Your Custom Setup

Your configuration preserves your tmux workflow while adding Ghostty benefits:
- **Same prefix key**: `Ctrl+F`
- **Same split navigation**: Vim-style h/j/k/l
- **Same window management**: c/n/p/w commands
- **Familiar colors**: Dracula Pro theme
- **Enhanced with**: GPU acceleration, native UI, command palette