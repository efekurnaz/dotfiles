-- Force airline to show clean statusline for Claude Code
local M = {}

function M.setup()
  -- Create a function to check and update airline for Claude buffers
  local function update_claude_airline()
    local bufname = vim.api.nvim_buf_get_name(0)
    local buftype = vim.bo.buftype
    
    if bufname:lower():match("claude") and buftype == "terminal" then
      -- Disable all airline extensions for this buffer
      vim.b.airline_disable_statusline = 0
      
      -- Override the entire statusline
      vim.wo.statusline = '%#airline_a_bold# Claude Code %#airline_to_airline_b#%#airline_b#%#airline_to_airline_c#%#airline_c#%='
      
      -- Alternative: try to override airline's internal variables
      vim.b["airline_section_a"] = "Claude Code"
      vim.b["airline_section_b"] = " "
      vim.b["airline_section_c"] = " "
      vim.b["airline_section_x"] = " "
      vim.b["airline_section_y"] = " "
      vim.b["airline_section_z"] = " "
      vim.b["airline_section_error"] = " "
      vim.b["airline_section_warning"] = " "
      
      -- Try global airline variables for this buffer
      local bufnr = vim.api.nvim_get_current_buf()
      vim.g["airline_section_a_buf" .. bufnr] = "Claude Code"
      vim.g["airline_section_b_buf" .. bufnr] = ""
      vim.g["airline_section_c_buf" .. bufnr] = ""
      
      -- Print debug info
      print("Claude airline override applied to buffer: " .. bufnr)
    end
  end
  
  -- Set up autocmds
  vim.api.nvim_create_autocmd({"BufEnter", "TermOpen", "WinEnter"}, {
    pattern = "*",
    callback = update_claude_airline,
    desc = "Update airline for Claude buffers"
  })
  
  -- Also create a command to manually trigger it
  vim.api.nvim_create_user_command('ClaudeAirline', update_claude_airline, {
    desc = 'Manually update airline for Claude buffer'
  })
end

return M