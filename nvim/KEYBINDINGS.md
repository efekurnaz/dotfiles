# Neovim Keybindings Cheat Sheet

## File Navigation & Search
| Key Combination | Action | Description |
|---|---|---|
| `Ctrl + P` | Find Files | Open fuzzy file finder (all files, respects .gitignore) |
| `Ctrl + E` | Search Text | Search text content across all files (ripgrep) |
| `Ctrl + [` | Git Files | Find git files with status (modified, staged, etc.) |
| `Ctrl + O` | File Explorer | Open built-in file explorer |
| `Space` | Command Mode | Quick access to command mode (instead of typing `:`) |

## Buffer Management (Tabs)
| Key Combination | Action | Description |
|---|---|---|
| `Ctrl + K` | Next Buffer | Switch to next open file/buffer |
| `Ctrl + J` | Previous Buffer | Switch to previous open file/buffer |
| `Ctrl + Q` | Close Buffer | Close current file/buffer |

## Movement & Navigation
| Key Combination | Action | Description |
|---|---|---|
| `j` / `k` | Visual Lines | Move up/down by display lines (wrapped text) |
| `↑` / `↓` | Visual Lines | Same as j/k for wrapped text |
| `n` / `N` | Search Results | Jump to next/previous search result (auto-centered) |
| `Ctrl + D` | Scroll Down | Half-page down + center screen |
| `Ctrl + U` | Scroll Up | Half-page up + center screen |

## EasyMotion (Fast Navigation)
| Key Combination | Action | Description |
|---|---|---|
| `\f` | 2-Char Jump | Type 2 characters, jump to any occurrence on screen |
| `\\j` | Line Jump | Jump to any line |
| `\\k` | Line Jump | Jump to any line |
| `\\.` | Repeat Motion | Repeat last EasyMotion jump |

## Search & Replace
| Key Combination | Action | Description |
|---|---|---|
| `\r` | Replace All | Auto-selects word under cursor, replace in whole file |
| `\rc` | Replace Confirm | Auto-selects word under cursor, replace with confirmation |
| `Esc` | Clear Highlight | Remove search result highlighting |

### In Visual Mode:
| Key Combination | Action | Description |
|---|---|---|
| `\r` | Replace Selection | Replace selected text |
| `\rc` | Replace Confirm | Replace selected text with confirmation |

## Text Editing
| Key Combination | Action | Description |
|---|---|---|
| `c` | Change (No Copy) | Change text without copying to clipboard |
| `\p` | Format Document | Format with Prettier (JS/CSS/HTML/JSON files) |

### In Visual Mode:
| Key Combination | Action | Description |
|---|---|---|
| `\d` | Delete (No Copy) | Delete selected text without copying |
| `\p` | Paste Over | Paste over selected text without losing clipboard |

## Plugin-Specific Commands

### FZF (File Finder)
- **Files open in preview** - see file contents before opening
- **Respects .gitignore** - won't show node_modules, etc.
- **Type to filter** - fuzzy matching as you type

### Visual Multi (Multi-cursor)
| Key Combination | Action | Description |
|---|---|---|
| `Ctrl + N` | Add Cursor | Add cursor at next occurrence of word |
| `Ctrl + ↓` | Add Cursor Down | Add cursor below |
| `Ctrl + ↑` | Add Cursor Up | Add cursor above |

### Commentary (Comments)
| Key Combination | Action | Description |
|---|---|---|
| `gcc` | Toggle Line | Comment/uncomment current line |
| `gc` + motion | Toggle Block | Comment/uncomment selection |
| `\c + Space` | NerdCommenter | Alternative commenting (more features) |

### Surround (Brackets/Quotes)
| Key Combination | Action | Description |
|---|---|---|
| `cs"'` | Change Surround | Change "hello" to 'hello' |
| `cs'<q>` | Change to Tag | Change 'hello' to \<q>hello\</q> |
| `ds"` | Delete Surround | Remove surrounding quotes |
| `ysiw]` | Add Surround | Surround word with [ ] |

### Fugitive (Git)
| Command | Action | Description |
|---|---|---|
| `:Git status` | Git Status | Show git status |
| `:Git commit` | Git Commit | Commit changes |
| `:Git push` | Git Push | Push to remote |
| `:Gdiff` | Git Diff | Show diff in split |

## Utility Commands
| Command | Action | Description |
|---|---|---|
| `:TagbarToggle` | Code Outline | Show/hide code structure |
| `:Goyo` | Focus Mode | Distraction-free writing |
| `:VimBeGood` | Vim Practice | Vim skill practice game |
| `:Lazy` | Plugin Manager | Manage plugins |

## File Types with Auto-completion
- **HTML/CSS**: Emmet expansion (e.g., `html:5` + `Ctrl+Y+,`)
- **Markdown**: Auto bullets and formatting
- **Liquid**: Shopify template syntax
- **JSON**: Auto-formatting and syntax
- **JavaScript/TypeScript**: JSX support and formatting

## Tips
- **Leader key** is `\` (backslash)
- **Fuzzy search** works in file finder - type partial matches
- **Visual mode** selections work with most commands
- **Undo** with `u`, **Redo** with `Ctrl + R`
- **Auto-save** removes trailing whitespace on supported files
