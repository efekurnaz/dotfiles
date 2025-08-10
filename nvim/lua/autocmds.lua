-- =============================================================================
-- AUTOCOMMANDS CONFIGURATION
-- =============================================================================
-- This file contains autocommands that automatically execute specific actions
-- when certain events occur in Neovim. These help automate repetitive tasks
-- and improve the editing experience.
--
-- Autocommands are event-driven: they trigger when specific events happen
-- such as opening files, saving files, changing file types, etc.

-- =============================================================================
-- SETUP
-- =============================================================================
local autocmd = vim.api.nvim_create_autocmd

-- =============================================================================
-- FILE TYPE DETECTION AND CONFIGURATION
-- =============================================================================
-- Configure how Neovim handles specific file types and extensions

-- SHOPIFY LIQUID TEMPLATE FILES
-- Liquid is a templating language used by Shopify and Jekyll
-- These autocommands ensure proper syntax highlighting for liquid files
-- that contain embedded JavaScript, CSS, or SCSS

-- JavaScript Liquid files (*.js.liquid)
-- Used in Shopify themes for JavaScript files with Liquid templating
autocmd({'BufNewFile', 'BufRead'}, {
  pattern = '*.js.liquid',
  callback = function()
    -- Set filetype to JavaScript for proper syntax highlighting and indentation
    vim.bo.filetype = 'javascript'
    vim.bo.syntax = 'javascript'
  end,
  desc = 'Set JavaScript syntax for .js.liquid files'
})

-- CSS Liquid files (*.css.liquid)
-- Used in Shopify themes for CSS files with Liquid templating
autocmd({'BufNewFile', 'BufRead'}, {
  pattern = '*.css.liquid',
  callback = function()
    -- Set filetype to CSS for proper syntax highlighting and indentation
    vim.bo.filetype = 'css'
    vim.bo.syntax = 'css'
  end,
  desc = 'Set CSS syntax for .css.liquid files'
})

-- SCSS Liquid files (*.scss.liquid)
-- Used in Shopify themes for SCSS files with Liquid templating
autocmd({'BufNewFile', 'BufRead'}, {
  pattern = '*.scss.liquid',
  callback = function()
    -- Set filetype to SCSS for proper syntax highlighting and indentation
    vim.bo.filetype = 'scss'
    vim.bo.syntax = 'scss'
  end,
  desc = 'Set SCSS syntax for .scss.liquid files'
})

-- =============================================================================
-- CODE QUALITY AND FORMATTING
-- =============================================================================
-- Automatically clean up files when saving

-- TRAILING WHITESPACE REMOVAL
-- Automatically remove trailing whitespace from specific file types when saving
-- This prevents unnecessary git diffs and keeps code clean
autocmd('BufWritePre', {
  pattern = {
    '*.css',        -- CSS files
    '*.js',         -- JavaScript files  
    '*.javascript', -- JavaScript files (alternative extension)
    '*.html',       -- HTML files
    '*.liquid',     -- Liquid template files
    '*.json'        -- JSON files
  },
  callback = function()
    -- Save the current cursor position
    -- This ensures the cursor returns to the same place after cleanup
    local save_cursor = vim.fn.getpos('.')
    
    -- Remove trailing whitespace using a substitution command
    -- %s/\s\+$//e breakdown:
    -- % = entire file
    -- s = substitute
    -- \s\+ = one or more whitespace characters
    -- $ = end of line
    -- // = replace with nothing (delete)
    -- e = don't show error if no matches found
    vim.cmd([[%s/\s\+$//e]])
    
    -- Restore the cursor to its original position
    vim.fn.setpos('.', save_cursor)
  end,
  desc = 'Remove trailing whitespace before saving'
})

-- =============================================================================
-- EXTERNAL TOOL INTEGRATION
-- =============================================================================
-- Integrate with external applications and tools

-- KITTY TERMINAL CONFIGURATION RELOAD
-- Automatically reload Kitty terminal configuration when kitty.conf is saved
-- This allows you to see configuration changes immediately without restarting Kitty
autocmd('BufWritePost', {
  -- Use vim.fn.expand to resolve the ~ to the actual home directory path
  pattern = vim.fn.expand('~/.config/kitty/kitty.conf'),
  
  -- Send SIGUSR1 signal to all kitty processes to reload configuration
  -- This is Kitty's built-in mechanism for live config reloading
  command = 'silent !kill -SIGUSR1 $(pgrep kitty)',
  
  desc = 'Reload Kitty terminal configuration when kitty.conf is saved'
})

-- =============================================================================
-- ADDITIONAL AUTOCOMMAND IDEAS
-- =============================================================================
--[[
You can add more autocommands here for additional functionality:

-- Auto-format on save:
autocmd('BufWritePre', {
  pattern = '*.lua',
  callback = function()
    vim.lsp.buf.format({ async = false })
  end,
})

-- Highlight yanked text:
autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank({ higroup = 'IncSearch', timeout = 300 })
  end,
})

-- Auto-create parent directories when saving:
autocmd('BufWritePre', {
  callback = function()
    local dir = vim.fn.expand('<afile>:p:h')
    if vim.fn.isdirectory(dir) == 0 then
      vim.fn.mkdir(dir, 'p')
    end
  end,
})

-- Set specific options for certain file types:
autocmd('FileType', {
  pattern = 'markdown',
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})

-- JSON SYNTAX HIGHLIGHTING FIX
-- Fix JSON colors to use proper Dracula Pro colors
autocmd('FileType', {
  pattern = 'json',
  callback = function()
    -- Wait a moment for colorscheme to load, then apply JSON colors
    vim.defer_fn(function()
      -- Use the correct treesitter highlight groups for JSON
      -- Keys/properties in cyan (light blue as requested)
      vim.cmd('hi @property.json guifg=#80FFEA')
      vim.cmd('hi @string.special.key.json guifg=#80FFEA')
      
      -- Strings in yellow
      vim.cmd('hi @string.json guifg=#FFFF80')
      
      -- Numbers in purple
      vim.cmd('hi @number.json guifg=#9580FF')
      
      -- Booleans and null in purple
      vim.cmd('hi @boolean.json guifg=#9580FF')
      vim.cmd('hi @constant.builtin.json guifg=#9580FF')
      
      -- Braces, brackets, and punctuation in orange/pink
      vim.cmd('hi @punctuation.bracket.json guifg=#FFB86C')
      vim.cmd('hi @punctuation.delimiter.json guifg=#FF79C6')
      
      -- Fallback to standard JSON highlight groups if treesitter groups don't work
      vim.cmd('hi jsonKeyword guifg=#80FFEA')
      vim.cmd('hi jsonString guifg=#FFFF80')
      vim.cmd('hi jsonNumber guifg=#9580FF')
      vim.cmd('hi jsonBoolean guifg=#9580FF')
      vim.cmd('hi jsonNull guifg=#9580FF')
      vim.cmd('hi jsonBraces guifg=#FFB86C')
      vim.cmd('hi jsonBrackets guifg=#FFB86C')
      vim.cmd('hi jsonQuote guifg=#FF79C6')
      vim.cmd('hi jsonNoise guifg=#FF79C6')
    end, 200)
  end,
  desc = 'Set proper Dracula Pro colors for JSON files'
})

-- =============================================================================
-- AUTOCOMMAND EVENTS REFERENCE
-- =============================================================================
--[[
Common autocommand events you can use:

BufNewFile     - Starting to edit a file that doesn't exist
BufRead        - Starting to edit a new buffer
BufReadPost    - After reading a buffer
BufWrite       - Starting to write the whole buffer to a file
BufWritePre    - Before writing the whole buffer to a file  
BufWritePost   - After writing the whole buffer to a file
FileType       - When the 'filetype' option has been set
VimEnter       - After doing all the startup stuff
VimLeave       - Before exiting Vim
WinEnter       - After entering another window
WinLeave       - Before leaving a window
InsertEnter    - Just after entering Insert mode
InsertLeave    - Just after leaving Insert mode
TextYankPost   - After yanking text
ColorScheme    - After loading a color scheme
--]]