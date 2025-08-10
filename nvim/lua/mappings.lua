-- =============================================================================
-- KEYMAPPINGS CONFIGURATION
-- =============================================================================
-- This file contains all custom keybindings and shortcuts for Neovim.
-- The mappings are organized by functionality and include detailed explanations.
--
-- Key notation:
-- <C-x>    = Ctrl + x
-- <leader> = \ (backslash) by default
-- <CR>     = Enter/Return
-- <esc>    = Escape key
--
-- Mode abbreviations:
-- 'n'      = Normal mode
-- 'i'      = Insert mode
-- 'v'      = Visual mode
-- 'x'      = Visual mode (excludes select mode)
-- 'c'      = Command mode

-- =============================================================================
-- SETUP AND HELPER FUNCTIONS
-- =============================================================================
local keymap = vim.keymap.set

-- Helper function for creating keymaps with consistent default options
-- This ensures all our keymaps are non-recursive and silent by default
local function map(mode, lhs, rhs, opts)
  local options = { 
    noremap = true,  -- Non-recursive mapping (prevents infinite loops)
    silent = true    -- Don't echo the command in command line
  }
  
  -- Merge any additional options passed to the function
  if opts then
    options = vim.tbl_extend('force', options, opts)
  end
  
  keymap(mode, lhs, rhs, options)
end

-- =============================================================================
-- COMMAND MODE SHORTCUTS
-- =============================================================================
-- Make it easier to enter command mode

-- Press spacebar to type : in command mode (faster than reaching for :)
-- This is a huge productivity boost for frequent command users
map('n', '<space>', ':')

-- =============================================================================
-- FILE NAVIGATION AND FUZZY FINDING
-- =============================================================================
-- These mappings use FZF (Fuzzy Finder) for quick file and text searching

-- Find ALL files (including uncommitted) but respects .gitignore
-- Shows all files in project directory in a fuzzy searchable list
map('n', '<C-P>', ':Files<CR>')

-- Find filename in git files with status (shows modified, staged, etc.)
-- Useful for seeing which files have changes
map('n', '<C-[>', ':GFiles?<CR>')

-- Find text content in git files using ripgrep
-- Searches through file contents, not just filenames
map('n', '<C-E>', ':Rg<CR>')

-- File explorer with Ctrl+O (since Ctrl+P now does fuzzy file search)
map('n', '<C-O>', ':Ex<CR>')               -- Built-in file explorer (shorter command)

-- =============================================================================
-- BUFFER NAVIGATION
-- =============================================================================
-- Navigate between open files (buffers) efficiently

-- Move to next buffer (like browser tabs)
map('n', '<C-K>', ':bnext<CR>')

-- Move to previous buffer
map('n', '<C-J>', ':bprev<CR>')

-- Close current buffer (similar to closing a tab)
map('n', '<C-Q>', ':bd<CR>')

-- =============================================================================
-- SEARCH AND HIGHLIGHTING
-- =============================================================================
-- Improve search experience and visibility

-- Remove search highlighting when pressing escape
-- Clears the yellow highlighting after you're done searching
map('n', '<esc>', ':noh<return><esc>', { silent = false })

-- =============================================================================
-- TEXT EDITING ENHANCEMENTS
-- =============================================================================
-- Improve common editing operations

-- Change text without copying it to clipboard (using black hole register "_)
-- Normally 'c' copies the deleted text, this prevents that
map('n', 'c', '"_c')

-- Delete without yanking in visual mode
-- When you select text and delete it, it won't go to clipboard
map('x', '<leader>d', '"_d')

-- Paste without yanking in visual mode
-- When you paste over selected text, the selected text won't replace your clipboard
map('x', '<leader>p', '"_dP')

-- =============================================================================
-- MOVEMENT IMPROVEMENTS
-- =============================================================================
-- Make cursor movement more intuitive and useful

-- Make j/k move by visual lines instead of actual lines (useful for wrapped text)
-- Arrow keys work the same way for consistency
map('n', '<Up>', 'gk')    -- Move up by display line
map('n', '<Down>', 'gj')  -- Move down by display line
map('n', 'j', 'gj')       -- j moves by display line
map('n', 'k', 'gk')       -- k moves by display line

-- =============================================================================
-- SEARCH NAVIGATION
-- =============================================================================
-- Center search results on screen for better visibility

-- When jumping to next search result, center it on screen and open folds
-- 'zz' centers the line, 'zv' opens folds if the result is folded
map('n', 'n', 'nzzzv')  -- Next search result
map('n', 'N', 'Nzzzv')  -- Previous search result

-- =============================================================================
-- SCROLL IMPROVEMENTS
-- =============================================================================
-- Center screen when scrolling half-page up/down

-- Half-page down, then center the cursor line
map('n', '<C-d>', '<C-d>zz')

-- Half-page up, then center the cursor line
map('n', '<C-u>', '<C-u>zz')

-- =============================================================================
-- SEARCH AND REPLACE SHORTCUTS
-- =============================================================================
-- Quick search and replace operations

-- NORMAL MODE: Search and replace word under cursor
-- Place cursor on a word, press <leader>r, then type replacement text
-- Uses <cword> to automatically grab the word under cursor
map('n', '<leader>r', ':%s/<C-r><C-w>//g<Left><Left>')

-- Same as above but with confirmation for each replacement
-- 'c' flag asks for confirmation before each replacement
map('n', '<leader>rc', ':%s/<C-r><C-w>//gc<Left><Left><Left>')

-- VISUAL MODE: Search and replace selected text
-- Select text visually, press <leader>r, then type replacement
-- :s/// - search and replace in selection only
map('x', '<leader>r', ':s///g<Left><Left>')

-- Same as above but with confirmation
map('x', '<leader>rc', ':s///gc<Left><Left><Left>')

-- =============================================================================
-- EASYMOTION MAPPINGS
-- =============================================================================
-- Fast navigation with EasyMotion plugin

-- Quick 2-character search with <leader>f
map('n', '<leader>f', '<Plug>(easymotion-overwin-f2)')

-- Jump to line with <leader><leader>j and <leader><leader>k
map('n', '<leader><leader>j', '<Plug>(easymotion-overwin-line)')
map('n', '<leader><leader>k', '<Plug>(easymotion-overwin-line)')

-- Repeat last EasyMotion with <leader><leader>.
map('n', '<leader><leader>.', '<Plug>(easymotion-repeat)')

-- =============================================================================
-- USAGE TIPS
-- =============================================================================
--[[
Common workflow examples:

1. File Navigation:
   - <C-P> to find and open files quickly
   - <C-E> to search for text across files
   - <C-K>/<C-J> to switch between open files
   - <C-Q> to close current file

2. Search and Replace:
   - Place cursor on word → <leader>r → type replacement → Enter
   - Select text → <leader>r → type replacement → Enter
   - Use <leader>rc for confirmation prompts

3. Movement:
   - Use j/k for moving through wrapped lines naturally
   - Use n/N to jump between search results (auto-centered)
   - Use <C-d>/<C-u> for fast scrolling (auto-centered)

4. Editing:
   - Use c to change text without affecting clipboard
   - Use <leader>p to paste over text without losing clipboard
   - Press <esc> to clear search highlighting
--]]