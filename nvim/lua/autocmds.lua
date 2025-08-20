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

-- Plain Liquid template files (*.liquid)
-- Used in Shopify themes for HTML templates with Liquid templating
autocmd({'BufNewFile', 'BufRead'}, {
  pattern = '*.liquid',
  callback = function()
    -- Only set filetype to liquid if it's not already set to a specific type
    -- This prevents overriding .js.liquid, .css.liquid, etc.
    if vim.bo.filetype == '' then
      vim.bo.filetype = 'liquid'
      vim.bo.syntax = 'liquid'
    end
  end,
  desc = 'Set Liquid syntax for .liquid template files'
})

-- =============================================================================
-- LIQUID TEMPLATE SYNTAX HIGHLIGHTING
-- =============================================================================
-- Configure custom syntax highlighting for Liquid template files
-- This ensures HTML tags appear in pink while maintaining Liquid syntax highlighting

-- Liquid files (*.liquid)
-- Used in Shopify themes for HTML templates with Liquid templating
autocmd('FileType', {
  pattern = 'liquid',
  callback = function()
    -- Wait a moment for treesitter to load, then apply custom Liquid colors
    vim.defer_fn(function()
      -- HTML tags in pink (using Dracula Pro pink color)
      vim.cmd('hi @tag.liquid guifg=#FF79C6')
      vim.cmd('hi @tag.delimiter.liquid guifg=#FF79C6')
      vim.cmd('hi @tag.attribute.liquid guifg=#80FFEA')
      
      -- HTML tag names in bright pink
      vim.cmd('hi @tag.name.liquid guifg=#FF79C6')
      
      -- HTML attributes in cyan
      vim.cmd('hi @attribute.liquid guifg=#80FFEA')
      
      -- HTML strings in yellow
      vim.cmd('hi @string.liquid guifg=#FFFF80')
      
      -- Liquid syntax in purple
      vim.cmd('hi @variable.liquid guifg=#9580FF')
      vim.cmd('hi @keyword.liquid guifg=#9580FF')
      vim.cmd('hi @function.liquid guifg=#9580FF')
      
      -- Fallback to standard HTML highlight groups if treesitter groups don't work
      vim.cmd('hi htmlTag guifg=#FF79C6')
      vim.cmd('hi htmlTagName guifg=#FF79C6')
      vim.cmd('hi htmlArg guifg=#80FFEA')
      vim.cmd('hi htmlString guifg=#FFFF80')
      vim.cmd('hi htmlSpecialChar guifg=#FF79C6')
      
      -- Liquid-specific highlighting
      vim.cmd('hi liquidTag guifg=#9580FF')
      vim.cmd('hi liquidVariable guifg=#9580FF')
      vim.cmd('hi liquidFilter guifg=#9580FF')
      
      -- Additional HTML highlighting for better tag visibility
      vim.cmd('hi htmlEndTag guifg=#FF79C6')
      vim.cmd('hi htmlSpecialTagName guifg=#FF79C6')
      vim.cmd('hi htmlTitle guifg=#FFFF80')
      vim.cmd('hi htmlH1 guifg=#FFFF80')
      vim.cmd('hi htmlH2 guifg=#FFFF80')
      vim.cmd('hi htmlH3 guifg=#FFFF80')
      vim.cmd('hi htmlH4 guifg=#FFFF80')
      vim.cmd('hi htmlH5 guifg=#FFFF80')
      vim.cmd('hi htmlH6 guifg=#FFFF80')
      
      -- Ensure Liquid delimiters are visible
      vim.cmd('hi liquidDelimiter guifg=#9580FF')
      vim.cmd('hi liquidOperator guifg=#9580FF')
    end, 200)
  end,
  desc = 'Set custom Dracula Pro colors for Liquid template files with pink HTML tags'
})

-- #9580ff
-- #ffff80
-- #ff79C6
-- #80FFEA


-- =============================================================================
-- BUFFER AUTO-RELOAD AND EXTERNAL FILE CHANGE DETECTION
-- =============================================================================
-- Automatically reload buffers when files change externally
-- This prevents issues where files are modified outside of Neovim but buffers don't update
-- Common scenarios: Git operations, file sync tools, multiple editors, build processes

-- GLOBAL AUTO-RELOAD SETTING
-- Enable auto-reload globally (can be disabled with :set noautoread)
-- This is the foundation for all external file change detection
vim.opt.autoread = true

-- FOCUS-BASED FILE CHANGE DETECTION
-- Check for external file changes when Neovim gains focus
-- This catches changes that happened while Neovim was in the background
autocmd('FocusGained', {
  callback = function()
    -- Check if any buffers have been modified externally
    -- This triggers the FileChangedShellPost event if changes are detected
    vim.cmd('checktime')
  end,
  desc = 'Check for external file changes when Neovim gains focus'
})

-- AUTOMATIC BUFFER RELOADING
-- Auto-reload buffer when file changes externally (if buffer is not modified)
-- This prevents data loss while keeping buffers in sync with disk
autocmd('FileChangedShellPost', {
  callback = function()
    -- Get the current buffer number to check its modification state
    local buf = vim.api.nvim_get_current_buf()
    
    -- Check if the buffer has unsaved changes
    -- If modified, we can't safely reload without user confirmation
    if vim.bo[buf].modified then
      -- If buffer has unsaved changes, show a warning
      -- User must decide whether to save, discard changes, or manually reload
      vim.notify(
        'File changed externally but buffer has unsaved changes. Use :edit to reload.',
        vim.log.levels.WARN,
        { title = 'File Change Detected' }
      )
    else
      -- If no unsaved changes, automatically reload the buffer
      -- This keeps the buffer perfectly in sync with the disk file
      vim.cmd('edit')
      vim.notify(
        'File changed externally. Buffer automatically reloaded.',
        vim.log.levels.INFO,
        { title = 'Auto-Reload' }
      )
    end
  end,
  desc = 'Auto-reload buffer when file changes externally (if no unsaved changes)'
})

-- WINDOW-BASED FILE CHANGE DETECTION
-- Check for external changes when switching between windows
-- This ensures changes are detected during normal navigation
autocmd('WinEnter', {
  callback = function()
    -- Only check if we're in a normal buffer (not terminal, help, etc.)
    -- Normal buffers are the only ones that can have external file changes
    if vim.bo.buftype == '' then
      vim.cmd('checktime')
    end
  end,
  desc = 'Check for external file changes when entering a window'
})

-- BUFFER-BASED FILE CHANGE DETECTION
-- Check for external changes when switching between buffers
-- This catches changes when navigating between different files
autocmd('BufEnter', {
  callback = function()
    -- Only check if we're in a normal buffer (not terminal, help, etc.)
    -- Prevents unnecessary checks on special buffer types
    if vim.bo.buftype == '' then
      vim.cmd('checktime')
    end
  end,
  desc = 'Check for external file changes when entering a buffer'
})

-- =============================================================================
-- USER COMMANDS FOR MANUAL CONTROL
-- =============================================================================
-- Provide manual commands for users who want explicit control over file reloading
-- These commands give users the ability to force reload or check for changes

-- MANUAL FILE CHANGE DETECTION
-- Check for external file changes in all buffers manually
-- Useful when you suspect files have changed but auto-detection hasn't triggered
vim.api.nvim_create_user_command('CheckTime', 'checktime', {
  desc = 'Check for external file changes in all buffers'
})

-- SAFE BUFFER RELOADING
-- Reload current buffer from disk (if no unsaved changes)
-- This is the safe way to reload when auto-reload hasn't triggered
vim.api.nvim_create_user_command('ReloadBuffer', function()
  -- Get current buffer to check its modification state
  local buf = vim.api.nvim_get_current_buf()
  
  -- Check if buffer has unsaved changes before reloading
  -- This prevents accidental data loss
  if vim.bo[buf].modified then
    -- Show warning if buffer has unsaved changes
    -- User must save first or use ForceReload to discard changes
    vim.notify(
      'Buffer has unsaved changes. Save first or use :edit! to force reload.',
      vim.log.levels.WARN,
      { title = 'Cannot Reload' }
    )
  else
    -- Safe to reload since no unsaved changes exist
    -- This brings the buffer in sync with the disk file
    vim.cmd('edit')
    vim.notify('Buffer reloaded from disk.', vim.log.levels.INFO, { title = 'Reloaded' })
  end
end, {
  desc = 'Reload current buffer from disk (if no unsaved changes)'
})

-- FORCE BUFFER RELOADING
-- Force reload current buffer from disk (discarding unsaved changes)
-- Use with caution - this will lose any unsaved work in the buffer
vim.api.nvim_create_user_command('ForceReload', 'edit!', {
  desc = 'Force reload current buffer from disk (discarding unsaved changes)'
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
-- You can add more autocommands here for additional functionality:

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

-- Set specific options for certain file types
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

      -- Strings in yello
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
