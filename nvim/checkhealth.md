
==============================================================================
lazy:                                                                       ✅

lazy.nvim ~
- {lazy.nvim} version `11.17.1`
- ✅ OK {git} `version 2.51.0`
- ✅ OK no existing packages found by other package managers
- ✅ OK packer_compiled.lua not found

luarocks ~
- ✅ OK luarocks disabled

==============================================================================
luasnip:                                                                    ✅

luasnip ~
- ✅ OK jsregexp is installed

==============================================================================
neo-tree:                                                                   ✅

Neo-tree ~
- ✅ OK nvim-web-devicons is installed
- ✅ OK plenary.nvim is installed
- ✅ OK nui.nvim is installed
- ✅ OK Configuration conforms to the neotree.Config.Base schema

==============================================================================
vim.deprecated:                                                             ✅

- ✅ OK No deprecated functions detected

==============================================================================
vim.health:                                                               1 ⚠️

Configuration ~
- ✅ OK no issues found

Runtime ~
- ✅ OK $VIMRUNTIME: /opt/homebrew/Cellar/neovim/0.11.3/share/nvim/runtime

Performance ~
- ✅ OK Build type: Release

Remote Plugins ~
- ✅ OK Up to date

terminal ~
- key_backspace (kbs) terminfo entry: `key_backspace=^H`
- key_dc (kdch1) terminfo entry: `key_dc=\E[3~`
- $TERM_PROGRAM="tmux"
- $COLORTERM="truecolor"

tmux ~
- ✅ OK escape-time: 10
- ⚠️ WARNING `focus-events` is not enabled. |'autoread'| may not work.
  - ADVICE:
    - (tmux 1.9+ only) Set `focus-events` in ~/.tmux.conf:
      set-option -g focus-events on
- $TERM: screen-256color

External Tools ~
- ✅ OK ripgrep 14.1.1 (/opt/homebrew/bin/rg)

==============================================================================
vim.lsp:                                                                    ✅

- LSP log level : WARN
- Log path: /Users/efe/.local/state/nvim/lsp.log
- Log size: 93138 KB

vim.lsp: Active Clients ~
- No active clients

vim.lsp: Enabled Configurations ~

vim.lsp: File Watcher ~
- file watching "(workspace/didChangeWatchedFiles)" disabled on all clients

vim.lsp: Position Encodings ~
- No active clients

==============================================================================
vim.provider:                                                       3 ⚠️  1 ❌

Clipboard (optional) ~
- ✅ OK Clipboard tool found: pbcopy

Node.js provider (optional) ~
- Node.js: v24.6.0

- Nvim node.js host: /opt/homebrew/Cellar/node/24.6.0/lib/node_modules/neovim/bin/cli.js

Perl provider (optional) ~
- ⚠️ WARNING "Neovim::Ext" cpan module is not installed
  - ADVICE:
    - See :help |provider-perl| for more information.
    - You can disable this provider (and warning) by adding `let g:loaded_perl_provider = 0` to your init.vim
- ⚠️ WARNING No usable perl executable found

Python 3 provider (optional) ~
- pyenv: Path: /opt/homebrew/Cellar/pyenv/2.6.7/libexec/pyenv
- pyenv: Root: /Users/efe/.pyenv
- `g:python3_host_prog` is not set. Searching for python3.11 in the environment.
- ⚠️ WARNING pyenv is not set up optimally.
  - ADVICE:
    - Create a virtualenv specifically for Nvim using pyenv, and set `g:python3_host_prog`.  This will avoid the need to install the pynvim module in each version/virtualenv.
- Executable: /Users/efe/.pyenv/versions/3.11.0/bin/python3.11
- ❌ ERROR Failed to run healthcheck for "vim.provider" plugin. Exception:
  ...im/0.11.3/share/nvim/runtime/lua/vim/provider/health.lua:93: Command error (job=13, exit code 1): '/Users/efe/.pyenv/versions/3.11.0/bin/python3.11' -c 'import sys; sys.path = [p for p in sys.path if p != ""]; import neovim; print(neovim.__file__)' (in /Users/efe/dev/12_agency/BeMe)


==============================================================================
vim.treesitter:                                                             ✅

Treesitter features ~
- Treesitter ABI support: min 13, max 15
- WASM parser support: false

Treesitter parsers ~
- ✅ OK Parser: c                    ABI: 15, path: /opt/homebrew/Cellar/neovim/0.11.3/lib/nvim/parser/c.so
- ✅ OK Parser: lua                  ABI: 15, path: /opt/homebrew/Cellar/neovim/0.11.3/lib/nvim/parser/lua.so
- ✅ OK Parser: markdown             ABI: 15, path: /opt/homebrew/Cellar/neovim/0.11.3/lib/nvim/parser/markdown.so
- ✅ OK Parser: markdown_inline      ABI: 15, path: /opt/homebrew/Cellar/neovim/0.11.3/lib/nvim/parser/markdown_inline.so
- ✅ OK Parser: query                ABI: 15, path: /opt/homebrew/Cellar/neovim/0.11.3/lib/nvim/parser/query.so
- ✅ OK Parser: vim                  ABI: 15, path: /opt/homebrew/Cellar/neovim/0.11.3/lib/nvim/parser/vim.so
- ✅ OK Parser: vimdoc               ABI: 15, path: /opt/homebrew/Cellar/neovim/0.11.3/lib/nvim/parser/vimdoc.so

==============================================================================
which-key:                                                                6 ⚠️

- ✅ OK Most of these checks are for informational purposes only.
  WARNINGS should be treated as a warning, and don't necessarily indicate a problem with your config.
  Please |DON'T| report these warnings as an issue.

Checking your config ~
- ⚠️ WARNING |mini.icons| is not installed
- ✅ OK |nvim-web-devicons| is installed

Checking for issues with your mappings ~
- ✅ OK No issues reported

checking for overlapping keymaps ~
- ⚠️ WARNING In mode `n`, <<Space>> overlaps with <<Space>f>, <<Space><Space>>, <<Space><Space>.>, <<Space><Space>k>, <<Space><Space>j>, <<Space>c>, <<Space>r>, <<Space>rc>:

- ⚠️ WARNING In mode `n`, <gc> overlaps with <gcc>:

- ⚠️ WARNING In mode `x`, <<Space>r> overlaps with <<Space>rc>:

- ⚠️ WARNING In mode `n`, <<Space>r> overlaps with <<Space>rc>:

- ⚠️ WARNING In mode `n`, <<Space><Space>> overlaps with <<Space><Space>.>, <<Space><Space>k>, <<Space><Space>j>:

- ✅ OK Overlapping keymaps are only reported for informational purposes.
  This doesn't necessarily mean there is a problem with your config.

Checking for duplicate mappings ~
- ✅ OK No duplicate mappings found

