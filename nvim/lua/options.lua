-- =============================================================================
-- NEOVIM OPTIONS CONFIGURATION
-- =============================================================================
-- This file contains all the vim options and settings that control how Neovim
-- behaves. It's organized into logical sections for easy navigation and
-- modification.
--
-- Converted from VimScript to Lua for better performance and readability.

-- =============================================================================
-- LOCAL VARIABLES
-- =============================================================================
local opt = vim.opt  -- Global options
local g = vim.g      -- Global variables

-- =============================================================================
-- INDENTATION AND FORMATTING
-- =============================================================================
-- Configure how Neovim handles indentation and code formatting

opt.autoindent = true          -- New lines inherit the indentation of previous lines
opt.tabstop = 2                -- Number of spaces that a <Tab> character displays as
opt.shiftwidth = 2             -- Number of spaces to use for each step of autoindent
opt.smarttab = true            -- Insert 'tabstop' number of spaces when <Tab> is pressed
opt.expandtab = true           -- Convert tabs to spaces (essential for consistent formatting)
opt.shiftround = true          -- Round indentation to nearest multiple of 'shiftwidth'

-- Enable file-type specific indentation rules
-- This allows different languages to have their own indentation behavior
vim.cmd('filetype indent on')

-- HTML-specific indentation settings for embedded content
g.html_indent_script1 = 'inc'  -- Indent content inside <script> tags
g.html_indent_style1 = 'inc'   -- Indent content inside <style> tags

-- =============================================================================
-- SEARCH CONFIGURATION
-- =============================================================================
-- Configure search behavior for finding text in files

opt.incsearch = true           -- Show search results as you type (incremental search)
opt.ignorecase = true          -- Ignore case when searching (case-insensitive by default)
opt.smartcase = true           -- Override ignorecase if search contains uppercase letters

-- =============================================================================
-- PERFORMANCE OPTIMIZATION
-- =============================================================================
-- Settings to improve Neovim's performance

opt.lazyredraw = true          -- Don't redraw screen during macros (faster execution)
opt.updatetime = 300           -- Time in milliseconds for CursorHold events and swap file writing

-- =============================================================================
-- TEXT RENDERING AND DISPLAY
-- =============================================================================
-- Configure how text is displayed and rendered in the editor

opt.display:append('lastline') -- Show as much as possible of the last line (instead of @@@)
opt.encoding = 'utf-8'         -- Use UTF-8 encoding for proper unicode support
opt.linebreak = true           -- Break lines at word boundaries, not in the middle of words
opt.scrolloff = 1              -- Keep 1 line visible above/below cursor when scrolling
opt.sidescrolloff = 5          -- Keep 5 columns visible left/right of cursor when scrolling
opt.wrap = true                -- Enable line wrapping for long lines
opt.showbreak = '>\\ \\ \\ '   -- String to show at the beginning of wrapped lines

-- Enable syntax highlighting for all file types
vim.cmd('syntax enable')

-- =============================================================================
-- CURSOR CONFIGURATION
-- =============================================================================
-- Configure cursor appearance in different modes
-- Format: mode-list:cursor-shape,blink-settings
opt.guicursor = 'n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50,a:blinkwait100-blinkoff100-blinkon100-Cursor/lCursor,sm:block-blinkwait175-blinkoff150-blinkon175'
--[[
Breakdown:
- n-v-c:block           - Normal, visual, command modes: block cursor
- i-ci-ve:ver25         - Insert modes: vertical cursor (25% width)
- r-cr:hor20            - Replace modes: horizontal cursor (20% height)
- o:hor50               - Operator pending: horizontal cursor (50% height)
- a:blink...            - All modes: blinking configuration
--]]

-- =============================================================================
-- USER INTERFACE OPTIONS
-- =============================================================================
-- Configure the overall appearance and behavior of the Neovim interface

opt.laststatus = 2             -- Always show the status line (0=never, 1=if multiple windows, 2=always)
opt.ruler = true               -- Show cursor position in status line
opt.wildmenu = true            -- Enhanced command-line completion with popup menu
opt.wildmode = 'list:longest'  -- Complete longest common string, then list alternatives
opt.tabpagemax = 50            -- Maximum number of tab pages that can be opened

-- Line and column highlighting
opt.cursorline = true          -- Highlight the line containing the cursor
opt.cursorcolumn = false       -- Don't highlight the column containing the cursor (can be distracting)

-- Line numbers configuration
opt.number = true              -- Show absolute line numbers
opt.relativenumber = true      -- Show relative line numbers (great for vim motions like 5j, 3k)

-- Feedback and notifications
opt.visualbell = true          -- Flash the screen instead of making noise for errors
opt.mouse = 'a'                -- Enable mouse support in all modes (n=normal, v=visual, i=insert, a=all)
opt.title = true               -- Set terminal title to current file name
opt.showmode = false           -- Don't show mode in command line (airline shows it instead)

-- Completion menu configuration
opt.completeopt = {'menu', 'menuone'} -- Show completion menu even for single match, no preview
opt.pumheight = 10             -- Maximum number of items in completion popup menu

-- Window behavior
opt.splitright = true          -- New vertical splits open to the right of current window
opt.termguicolors = true       -- Enable 24-bit RGB colors (essential for modern colorschemes)

-- Word boundaries
opt.iskeyword:remove('_')      -- Treat underscore as word boundary (useful for snake_case navigation)

-- =============================================================================
-- MESSAGE AND STATUS CONFIGURATION
-- =============================================================================
-- Configure how Neovim displays messages and status information

-- Customize shortmess to reduce verbosity
opt.shortmess:append('c')      -- Don't give completion menu messages like "match 1 of 2"
opt.shortmess:append('A')      -- Don't show "ATTENTION" message when swap file exists

-- =============================================================================
-- TERMINAL AND COLOR CONFIGURATION
-- =============================================================================
-- Settings for terminal integration and color support

-- Fix terminal GUI colors for better color scheme support
vim.cmd([[
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
]])

-- Note: t_Co option is not available in modern Neovim (handled automatically)

-- =============================================================================
-- FILE HANDLING AND WILDCARDS
-- =============================================================================
-- Configure how Neovim handles file operations and completions

-- Configure which files to ignore in wildcard expansions and file explorers
opt.wildignore = {
  '*.docx', '*.jpg', '*.png', '*.gif', '*.pdf',  -- Documents and images
  '*.pyc', '*.exe', '*.flv', '*.img', '*.xlsx'   -- Compiled files and media
}

-- =============================================================================
-- VISUAL INDICATORS
-- =============================================================================
-- Configure visual indicators for whitespace and special characters

-- Configure how invisible characters are displayed
opt.listchars = {
  tab = '>\\ ',     -- Show tabs as >   
  trail = '-',      -- Show trailing spaces as -
  extends = '>',    -- Show character when line extends beyond screen
  precedes = '<',   -- Show character when line precedes screen
  nbsp = '+'        -- Show non-breaking spaces as +
}

-- =============================================================================
-- CODE FOLDING
-- =============================================================================
-- Configure code folding behavior for collapsing code blocks

opt.foldmethod = 'indent'      -- Create folds based on indentation levels
opt.foldnestmax = 3            -- Maximum number of nested folds (prevents too deep folding)
opt.foldenable = false         -- Start with all folds open by default

-- =============================================================================
-- EDITING BEHAVIOR
-- =============================================================================
-- Configure general editing behavior and file handling

opt.autoread = true            -- Automatically reload files changed outside of vim
opt.backspace = {'indent', 'eol', 'start'} -- Allow backspacing over everything in insert mode
opt.hidden = true              -- Allow switching between buffers without saving
opt.swapfile = true           -- Disable swap files (can cause issues with file watchers)
opt.showmatch = false          -- Don't jump to matching brackets (can be disorienting)

-- Disable concealing - ALWAYS show actual characters (quotes, etc.)
opt.conceallevel = 0           -- Never hide/conceal any characters
opt.concealcursor = ''         -- Don't conceal even when cursor is on the line

-- Clipboard integration - use system clipboard for all operations
opt.clipboard:prepend({'unnamed', 'unnamedplus'})

-- Allow cursor to wrap to next/previous line
opt.whichwrap:append('<,>,h,l')

-- =============================================================================
-- CUSTOM HIGHLIGHTING
-- =============================================================================
-- Custom color settings that override default colorscheme

-- Make search highlighting more visible
vim.cmd('hi Search cterm=NONE ctermbg=blue')

-- =============================================================================
-- WHITESPACE VISUALIZATION
-- =============================================================================
-- Show invisible characters to help with formatting

opt.list = true                -- Enable list mode to show invisible characters
opt.listchars = {tab = '|\\ '} -- Show tabs as |   (vertical bar followed by spaces)
