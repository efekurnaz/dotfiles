-- =============================================================================
-- CLAUDE TERMINAL INTEGRATION
-- =============================================================================
-- This module provides quick access to Claude Code via a terminal toggle
-- Press <leader>i to summon Claude in a vertical split on the right
-- Press <leader>i again to close Claude and the terminal

local M = {}

-- Terminal instance for Claude
local claude_term = nil

-- Toggle Claude terminal function
function M.toggle_claude()
  local Terminal = require('toggleterm.terminal').Terminal
  
  if claude_term then
    if claude_term:is_open() then
      -- Hide Claude terminal if it's open
      claude_term:toggle()
      vim.notify("Claude hidden 👻", vim.log.levels.INFO, { title = "Claude Terminal" })
    else
      -- Show Claude terminal if it's hidden
      claude_term:toggle()
      vim.cmd("startinsert!")
      vim.notify("Claude summoned! 🧛‍♂️", vim.log.levels.INFO, { title = "Claude Terminal" })
    end
  else
    -- Create Claude terminal for the first time
    claude_term = Terminal:new({
      cmd = "claude",
      dir = vim.fn.getcwd(), -- Use project root directory
      direction = "vertical",
      size = vim.o.columns * 0.4, -- 40% of screen width
      close_on_exit = false, -- Keep terminal open even if claude exits
      hidden = false, -- Start visible
      on_open = function(term)
        -- Focus the terminal when it opens
        vim.cmd("startinsert!")
        vim.notify("Claude summoned! 🧛‍♂️", vim.log.levels.INFO, { title = "Claude Terminal" })
        
        -- Set custom keymaps for this terminal
        vim.keymap.set('t', '<leader>i', function()
          M.toggle_claude()
        end, { buffer = term.bufnr, desc = "Hide Claude Terminal" })
      end,
    })
    
    claude_term:open()
  end
end

-- Get the current Claude terminal (for other integrations)
function M.get_claude_term()
  return claude_term
end

-- Send command to Claude terminal
function M.send_to_claude(command)
  if claude_term and claude_term:is_open() then
    claude_term:send(command)
  else
    vim.notify("Claude terminal is not open", vim.log.levels.WARN, { title = "Claude Terminal" })
  end
end

-- Completely close Claude terminal (end session)
function M.close_claude()
  if claude_term then
    claude_term:close()
    claude_term = nil
    vim.notify("Claude session ended", vim.log.levels.INFO, { title = "Claude Terminal" })
  else
    vim.notify("No Claude session to close", vim.log.levels.WARN, { title = "Claude Terminal" })
  end
end

-- Quick commands for Claude
function M.ask_claude(question)
  M.toggle_claude()
  -- Wait a bit for terminal to open, then send the question
  vim.defer_fn(function()
    if question and question ~= "" then
      M.send_to_claude(question)
    end
  end, 500)
end

return M