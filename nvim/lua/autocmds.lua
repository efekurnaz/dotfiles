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
    -- Set composite filetype for better LSP and syntax support
    vim.bo.filetype = 'javascript.liquid'
  end,
  desc = 'Set JavaScript+Liquid syntax for .js.liquid files'
})

-- TypeScript Liquid files (*.ts.liquid)
-- Used in Shopify themes for TypeScript files with Liquid templating
autocmd({'BufNewFile', 'BufRead'}, {
  pattern = '*.ts.liquid',
  callback = function()
    -- Set composite filetype for better LSP and syntax support
    vim.bo.filetype = 'typescript.liquid'
  end,
  desc = 'Set TypeScript+Liquid syntax for .ts.liquid files'
})

-- CSS Liquid files (*.css.liquid)
-- Used in Shopify themes for CSS files with Liquid templating
autocmd({'BufNewFile', 'BufRead'}, {
  pattern = '*.css.liquid',
  callback = function()
    -- Set composite filetype for better LSP and syntax support
    vim.bo.filetype = 'css.liquid'
  end,
  desc = 'Set CSS+Liquid syntax for .css.liquid files'
})

-- SCSS Liquid files (*.scss.liquid, *.sass.liquid)
-- Used in Shopify themes for SCSS/SASS files with Liquid templating
autocmd({'BufNewFile', 'BufRead'}, {
  pattern = {'*.scss.liquid', '*.sass.liquid'},
  callback = function()
    -- Set composite filetype for better LSP and syntax support
    vim.bo.filetype = 'scss.liquid'
  end,
  desc = 'Set SCSS+Liquid syntax for .scss.liquid and .sass.liquid files'
})

-- JSON Liquid files (*.json.liquid)
-- Used in Shopify themes for JSON config files with Liquid templating
autocmd({'BufNewFile', 'BufRead'}, {
  pattern = '*.json.liquid',
  callback = function()
    -- Set composite filetype for better LSP and syntax support
    vim.bo.filetype = 'json.liquid'
  end,
  desc = 'Set JSON+Liquid syntax for .json.liquid files'
})

-- Plain Liquid template files (*.liquid)
-- Used in Shopify themes for HTML templates with Liquid templating
autocmd({'BufNewFile', 'BufRead'}, {
  pattern = '*.liquid',
  callback = function()
    -- Only set filetype to liquid if it's not already a composite type
    if not vim.bo.filetype:match('%.liquid$') then
      vim.bo.filetype = 'liquid'
    end
  end,
  desc = 'Set Liquid syntax for .liquid template files'
})

-- Detect Shopify theme structure for better project context
autocmd({'BufNewFile', 'BufRead'}, {
  pattern = {'*/templates/*.json', '*/sections/*.json', '*/config/*.json', '*/locales/*.json'},
  callback = function()
    -- Enable JSON with comments for Shopify theme JSON files
    vim.bo.filetype = 'jsonc'
  end,
  desc = 'Set JSONC filetype for Shopify theme JSON files'
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
      
      -- HTML strings in yellow - preserve vim-css-color backgrounds
      vim.cmd('hi @string.liquid guifg=#FFFF80 guibg=NONE')
      
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
    if vim.bo.buftype == '' and not vim.bo.modified then
      pcall(vim.cmd, 'checktime')
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

-- SMART QUIT COMMAND
-- Create custom quit command that handles window focus properly
vim.api.nvim_create_user_command('Q', function(opts)
  local current_win = vim.api.nvim_get_current_win()
  local current_buf = vim.api.nvim_win_get_buf(current_win)
  local current_ft = vim.api.nvim_buf_get_option(current_buf, 'filetype')
  
  -- If we're closing Neo-tree itself, just close it normally
  if current_ft == 'neo-tree' then
    vim.api.nvim_win_close(current_win, opts.bang)
    return
  end
  
  -- Store the current window to close it later
  local win_to_close = current_win
  
  -- Get all windows and categorize them
  local windows = vim.api.nvim_list_wins()
  local file_wins = {}
  local neotree_win = nil
  
  for _, win in ipairs(windows) do
    if win ~= current_win then
      local buf = vim.api.nvim_win_get_buf(win)
      local ft = vim.api.nvim_buf_get_option(buf, 'filetype')
      local bt = vim.api.nvim_buf_get_option(buf, 'buftype')
      
      if ft == 'neo-tree' then
        neotree_win = win
      elseif bt == '' then  -- Regular file buffer
        table.insert(file_wins, win)
      end
    end
  end
  
  -- If there are other file windows, switch to the most recent one
  if #file_wins > 0 then
    -- Try to find the window that was accessed most recently
    -- For now, just use the first one that's not Neo-tree
    vim.api.nvim_set_current_win(file_wins[1])
  elseif #windows == 2 and neotree_win then
    -- Only Neo-tree and current window left, close both
    vim.cmd('qa' .. (opts.bang and '!' or ''))
    return
  end
  
  -- Now close the original window
  pcall(vim.api.nvim_win_close, win_to_close, opts.bang)
  
  -- Ensure Neo-tree doesn't steal focus
  vim.defer_fn(function()
    local cur_win = vim.api.nvim_get_current_win()
    local cur_buf = vim.api.nvim_win_get_buf(cur_win)
    local cur_ft = vim.api.nvim_buf_get_option(cur_buf, 'filetype')
    
    -- If we ended up in Neo-tree, try to switch away
    if cur_ft == 'neo-tree' then
      for _, win in ipairs(vim.api.nvim_list_wins()) do
        local buf = vim.api.nvim_win_get_buf(win)
        local ft = vim.api.nvim_buf_get_option(buf, 'filetype')
        local bt = vim.api.nvim_buf_get_option(buf, 'buftype')
        
        if ft ~= 'neo-tree' and bt == '' then
          vim.api.nvim_set_current_win(win)
          break
        end
      end
    end
    
    -- Fix Neo-tree width
    if neotree_win and vim.api.nvim_win_is_valid(neotree_win) then
      pcall(vim.api.nvim_win_set_width, neotree_win, 40)
    end
  end, 10)
end, { bang = true, desc = 'Smart quit that focuses file windows' })

-- Abbreviate :q to use our custom :Q command
vim.cmd('cabbrev q Q')
vim.cmd('cabbrev q! Q!')
vim.cmd('cabbrev wq w<bar>Q')
vim.cmd('cabbrev wq! w<bar>Q!')

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
-- MODERN PLUGIN THEME COMPATIBILITY
-- =============================================================================
-- Ensure new plugins work well with Dracula Pro theme

-- LSP and completion menu colors
autocmd('ColorScheme', {
  callback = function()
    vim.defer_fn(function()
      -- LSP diagnostic signs
      vim.cmd('hi DiagnosticSignError guifg=#FF5555')
      vim.cmd('hi DiagnosticSignWarn guifg=#FFB86C')
      vim.cmd('hi DiagnosticSignInfo guifg=#8BE9FD')
      vim.cmd('hi DiagnosticSignHint guifg=#50FA7B')
      
      -- Completion menu
      vim.cmd('hi CmpPmenu guibg=#282a36')
      vim.cmd('hi CmpSel guibg=#44475a guifg=#f8f8f2')
      vim.cmd('hi CmpDocumentation guibg=#282a36')
      vim.cmd('hi CmpDocumentationBorder guifg=#6272a4')
      
      -- Which-key popup
      vim.cmd('hi WhichKey guifg=#8be9fd')
      vim.cmd('hi WhichKeyGroup guifg=#50fa7b')
      vim.cmd('hi WhichKeyDesc guifg=#f8f8f2')
      vim.cmd('hi WhichKeyFloat guibg=#282a36')
      vim.cmd('hi WhichKeyBorder guifg=#6272a4')
      
      -- Trouble.nvim
      vim.cmd('hi TroubleText guifg=#f8f8f2')
      vim.cmd('hi TroubleCount guifg=#6272a4')
      vim.cmd('hi TroubleNormal guibg=#282a36')
      
      -- Alpha dashboard
      vim.cmd('hi AlphaShortcut guifg=#bd93f9')
      vim.cmd('hi AlphaHeader guifg=#ff79c6')
      vim.cmd('hi AlphaHeaderLabel guifg=#8be9fd')
      vim.cmd('hi AlphaButtons guifg=#f8f8f2')
      vim.cmd('hi AlphaFooter guifg=#6272a4')
      
      -- Neo-tree specific highlights
      vim.cmd('hi NeoTreeDirectoryIcon guifg=#8be9fd')
      vim.cmd('hi NeoTreeDirectoryName guifg=#8be9fd')
      vim.cmd('hi NeoTreeFileName guifg=#f8f8f2')
      vim.cmd('hi NeoTreeFileIcon guifg=#f8f8f2')
      vim.cmd('hi NeoTreeModified guifg=#ffb86c')
      vim.cmd('hi NeoTreeGitAdded guifg=#50fa7b')
      vim.cmd('hi NeoTreeGitDeleted guifg=#ff5555')
      vim.cmd('hi NeoTreeGitModified guifg=#ffb86c')
      vim.cmd('hi NeoTreeGitConflict guifg=#ff79c6')
      vim.cmd('hi NeoTreeGitUntracked guifg=#6272a4')
      
      -- Gitsigns
      vim.cmd('hi GitSignsAdd guifg=#50fa7b')
      vim.cmd('hi GitSignsChange guifg=#ffb86c')
      vim.cmd('hi GitSignsDelete guifg=#ff5555')
      vim.cmd('hi GitSignsCurrentLineBlame guifg=#6272a4')
    end, 100)
  end,
  desc = 'Apply Dracula Pro colors to modern plugins'
})

-- =============================================================================
-- ADDITIONAL AUTOCOMMAND IDEAS
-- =============================================================================
-- You can add more autocommands here for additional functionality:

-- Auto-format on save is handled by conform.nvim's format_on_save option
-- Removed duplicate BufWritePre autocmd to avoid conflicts

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

-- VIM-CSS-COLOR FIX
-- Ensure vim-css-color works after colorscheme loads
autocmd('ColorScheme', {
  callback = function()
    vim.defer_fn(function()
      -- Force reload vim-css-color highlighting
      if vim.fn.exists(':call') == 2 then
        vim.cmd('silent! call css_color#reload()')
      end
    end, 100)
  end,
  desc = 'Reload vim-css-color after colorscheme changes'
})

-- JSON SYNTAX HIGHLIGHTING FIX
-- Fix JSON colors to use proper Dracula Pro colors
autocmd('FileType', {
  pattern = 'json',
  callback = function()
    -- Wait a moment for colorscheme to load, then apply JSON colors
    vim.defer_fn(function()
      -- Use the correct treesitter highlight groups for JSON
      -- Keys/properties in cyan (light blue as requested) - preserve vim-css-color backgrounds
      vim.cmd('hi @property.json guifg=#80FFEA guibg=NONE')
      vim.cmd('hi @string.special.key.json guifg=#80FFEA guibg=NONE')

      -- Strings in yellow - preserve vim-css-color backgrounds
      vim.cmd('hi @string.json guifg=#FFFF80 guibg=NONE')

      -- Numbers in purple - preserve vim-css-color backgrounds
      vim.cmd('hi @number.json guifg=#9580FF guibg=NONE')

      -- Booleans and null in purple
      vim.cmd('hi @boolean.json guifg=#9580FF')
      vim.cmd('hi @constant.builtin.json guifg=#9580FF')

      -- Braces, brackets, and punctuation in orange/pink
      vim.cmd('hi @punctuation.bracket.json guifg=#FFB86C')
      vim.cmd('hi @punctuation.delimiter.json guifg=#FF79C6')

      -- Fallback to standard JSON highlight groups if treesitter groups don't work
      vim.cmd('hi jsonKeyword guifg=#80FFEA guibg=NONE')
      vim.cmd('hi jsonString guifg=#FFFF80 guibg=NONE')
      vim.cmd('hi jsonNumber guifg=#9580FF guibg=NONE')
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
