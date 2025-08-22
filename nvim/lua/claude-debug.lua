-- Debug function to check Claude buffer properties
vim.api.nvim_create_user_command('DebugClaude', function()
  local bufname = vim.api.nvim_buf_get_name(0)
  local buftype = vim.bo.buftype
  local filetype = vim.bo.filetype
  
  print("Buffer name: " .. bufname)
  print("Buffer type: " .. buftype)
  print("File type: " .. filetype)
  print("Contains 'claude': " .. tostring(bufname:lower():match("claude") ~= nil))
  
  -- Try to force airline settings
  vim.b.airline_section_a = 'Claude Code TEST'
  vim.b.airline_section_b = ''
  vim.b.airline_section_c = ''
  vim.b.airline_section_x = ''
  vim.b.airline_section_y = ''
  vim.b.airline_section_z = ''
  
  -- Force refresh
  vim.cmd('AirlineRefresh')
  
  print("Airline settings applied - check if statusline changed")
end, { desc = 'Debug Claude buffer and airline settings' })