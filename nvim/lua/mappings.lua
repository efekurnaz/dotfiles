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
-- LEADER KEY CONFIGURATION
-- =============================================================================
-- Set leader key to space for better ergonomics
-- This must be set before any leader key mappings
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

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
-- and Neo-tree for modern file exploration

-- Find ALL files (including uncommitted) but respects .gitignore
-- Shows all files in project directory in a fuzzy searchable list
map('n', '<C-P>', ':Files<CR>')

-- Find filename in git files with status (shows modified, staged, etc.)
-- Useful for seeing which files have changes
map('n', '<C-[>', ':GFiles?<CR>')

-- Find text content in git files using ripgrep
-- Searches through file contents, not just filenames
map('n', '<C-E>', ':Rg<CR>')

-- Modern file explorer with Neo-tree
map('n', '<leader>e', ':Neotree focus<CR>', { desc = 'Focus file explorer' })
map('n', '<leader>fe', ':Neotree toggle<CR>', { desc = 'Toggle file explorer' })
map('n', '<leader>fE', ':Neotree toggle float<CR>', { desc = 'Float file explorer' })

-- Legacy file explorer (kept for compatibility)
map('n', '<C-O>', ':Ex<CR>')               -- Built-in file explorer (shorter command)

-- =============================================================================
-- TERMINAL INTEGRATION
-- =============================================================================
-- Quick access to Claude Code terminal

-- Toggle Claude terminal on the right (hide/show)
map('n', '<leader>i', function()
  require('config.claude-terminal').toggle_claude()
end, { desc = 'Toggle Claude terminal' })

-- Completely close Claude terminal (end session)
map('n', '<leader>I', function()
  require('config.claude-terminal').close_claude()
end, { desc = 'Close Claude session' })

-- =============================================================================
-- BUFFER NAVIGATION
-- =============================================================================
-- Navigate between open files (buffers) efficiently

-- Move to next buffer (like browser tabs)
map('n', '<C-K>', ':bnext<CR>')

-- Move to previous buffer
map('n', '<C-J>', ':bprev<CR>')

-- Smart buffer close - ensures focus stays on files, not Neo-tree
map('n', '<C-Q>', function()
  local current_win = vim.api.nvim_get_current_win()
  local current_buf = vim.api.nvim_get_current_buf()
  
  -- Get list of all listed buffers
  local buffers = vim.fn.getbufinfo({buflisted = 1})
  local valid_buffers = {}
  
  -- Find other valid file buffers
  for _, buf_info in ipairs(buffers) do
    if buf_info.bufnr ~= current_buf then
      local ft = vim.api.nvim_buf_get_option(buf_info.bufnr, 'filetype')
      if ft ~= 'neo-tree' and ft ~= 'help' and ft ~= 'qf' then
        table.insert(valid_buffers, buf_info.bufnr)
      end
    end
  end
  
  -- If we have other buffers, switch to one before closing
  if #valid_buffers > 0 then
    -- Try to switch to the next or previous buffer
    vim.cmd('silent! bnext')
    
    -- Check if we're still on the same buffer (might be the last one)
    if vim.api.nvim_get_current_buf() == current_buf then
      vim.cmd('silent! bprevious')
    end
    
    -- If we're STILL on the same buffer, switch to the first valid one
    if vim.api.nvim_get_current_buf() == current_buf and #valid_buffers > 0 then
      vim.api.nvim_win_set_buf(current_win, valid_buffers[1])
    end
  else
    -- No other buffers, create a new empty one
    vim.cmd('enew')
  end
  
  -- Now delete the original buffer
  vim.cmd('silent! bdelete! ' .. current_buf)
  
  -- Post-delete: ensure we're not in Neo-tree
  vim.defer_fn(function()
    local win = vim.api.nvim_get_current_win()
    local buf = vim.api.nvim_win_get_buf(win)
    local ft = vim.api.nvim_buf_get_option(buf, 'filetype')
    
    if ft == 'neo-tree' then
      -- Find any non-Neo-tree window
      for _, w in ipairs(vim.api.nvim_list_wins()) do
        local b = vim.api.nvim_win_get_buf(w)
        local f = vim.api.nvim_buf_get_option(b, 'filetype')
        local bt = vim.api.nvim_buf_get_option(b, 'buftype')
        if f ~= 'neo-tree' and bt == '' then
          vim.api.nvim_set_current_win(w)
          break
        end
      end
    end
    
    -- Fix Neo-tree width
    for _, w in ipairs(vim.api.nvim_list_wins()) do
      local b = vim.api.nvim_win_get_buf(w)
      local f = vim.api.nvim_buf_get_option(b, 'filetype')
      if f == 'neo-tree' then
        pcall(vim.api.nvim_win_set_width, w, 40)
        break
      end
    end
  end, 10)
end, { desc = 'Close buffer and focus next file' })

-- Additional buffer management
map('n', '<leader>bd', '<C-Q>', { desc = 'Delete buffer (smart)' })
map('n', '<leader>bn', ':bnext<CR>', { desc = 'Next buffer' })
map('n', '<leader>bp', ':bprevious<CR>', { desc = 'Previous buffer' })
map('n', '<leader>bb', ':buffers<CR>', { desc = 'List buffers' })

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
-- LSP AND CODE NAVIGATION
-- =============================================================================
-- LSP keybindings are set up automatically in plugins.lua when LSP attaches
-- Here are the available LSP shortcuts:
--
-- gd           - Go to definition
-- gr           - Show references  
-- gI           - Go to implementation
-- gy           - Go to type definition
-- gD           - Go to declaration
-- K            - Show hover information
-- gK           - Show signature help
-- <leader>ca   - Code actions
-- <leader>cr   - Rename symbol
-- <leader>cf   - Format document

-- =============================================================================
-- DIAGNOSTICS AND TROUBLE
-- =============================================================================
-- Diagnostics navigation and trouble panel
-- These are set up in plugins.lua for Trouble plugin:
--
-- <leader>xx   - Toggle Trouble panel
-- <leader>xw   - Workspace diagnostics
-- <leader>xd   - Document diagnostics
-- <leader>xl   - Location list
-- <leader>xq   - Quickfix list
-- gR           - LSP references in Trouble

-- =============================================================================
-- GIT INTEGRATION
-- =============================================================================
-- Git navigation and operations (configured in gitsigns)
-- These are automatically set up for git hunks:
--
-- ]c           - Next git hunk
-- [c           - Previous git hunk
-- <leader>gs   - Stage hunk
-- <leader>gr   - Reset hunk
-- <leader>gS   - Stage buffer
-- <leader>gR   - Reset buffer
-- <leader>gp   - Preview hunk
-- <leader>gb   - Blame line
-- <leader>gtb  - Toggle line blame
-- <leader>gd   - Diff this
-- <leader>gtd  - Toggle deleted lines

-- =============================================================================
-- SESSION MANAGEMENT
-- =============================================================================
-- Session persistence keybindings (configured in persistence.nvim):
--
-- <leader>qs   - Restore session
-- <leader>ql   - Restore last session
-- <leader>qd   - Don't save current session

-- =============================================================================
-- USAGE TIPS
-- =============================================================================
--[[
Common workflow examples:

1. File Navigation:
   - <C-P> to find and open files quickly
   - <C-E> to search for text across files
   - <leader>e to focus file explorer
   - <leader>fe to toggle file explorer
   - In Neo-tree: ←/→ or h/l to collapse/expand folders
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

4. Code Navigation (LSP):
   - gd to go to definition
   - gr to see all references
   - K to see documentation
   - <leader>ca for code actions
   - <leader>cr to rename symbols
   - <leader>cf to format code

5. Git Workflow:
   - ]c/[c to navigate between changes
   - <leader>gs to stage hunks
   - <leader>gp to preview changes
   - <leader>gb to see git blame

6. Diagnostics:
   - <leader>xx to see all issues
   - <leader>xd for current file issues
   - <leader>xw for workspace issues

7. Editing:
   - Use c to change text without affecting clipboard
   - Use <leader>p to paste over text without losing clipboard
   - Press <esc> to clear search highlighting
   - Tab/Shift+Tab in completion menu
   - <C-Space> to trigger completion

8. Claude Integration:
   - <leader>i to toggle Claude terminal (hide/show, preserves conversation)
   - <leader>I (shift+i) to completely close Claude session
   - Escape or <C-\><C-n> to exit terminal insert mode

9. Which-key Help:
   - Press <leader> and wait to see available commands
   - Shows context-sensitive help for key combinations
--]]