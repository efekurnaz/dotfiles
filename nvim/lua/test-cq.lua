-- Test what's actually happening with C-q
local M = {}

function M.test_cq()
  vim.notify("TEST: C-Q function called!", vim.log.levels.ERROR)
  
  -- Check current mode
  local mode = vim.api.nvim_get_mode().mode
  vim.notify("Current mode: " .. mode, vim.log.levels.WARN)
  
  -- Check if we're in the middle of a macro recording
  local recording = vim.fn.reg_recording()
  if recording ~= '' then
    vim.notify("Currently recording to register: " .. recording, vim.log.levels.ERROR)
    return
  end
  
  -- Check register q
  local reg_q = vim.fn.getreg('q')
  if reg_q ~= '' then
    vim.notify("Register q contains: " .. vim.inspect(reg_q), vim.log.levels.ERROR)
    -- Clear it
    vim.fn.setreg('q', '')
    vim.notify("Cleared register q", vim.log.levels.WARN)
  end
  
  -- Try simple buffer delete
  local ok, err = pcall(vim.cmd, 'bdelete!')
  if not ok then
    vim.notify("Error closing buffer: " .. tostring(err), vim.log.levels.ERROR)
  else
    vim.notify("Buffer closed successfully", vim.log.levels.INFO)
  end
end

-- Override C-Q mapping completely
-- Safely try to delete existing mappings
pcall(vim.keymap.del, 'n', '<C-Q>')
pcall(vim.keymap.del, 'n', '<C-q>')

-- Install our test mappings
vim.keymap.set('n', '<C-Q>', M.test_cq, { 
  desc = 'TEST: Close buffer with debug',
  noremap = true,
  silent = false 
})
vim.keymap.set('n', '<C-q>', M.test_cq, { 
  desc = 'TEST: Close buffer with debug',
  noremap = true,
  silent = false 
})

vim.notify("TEST-CQ: Debug mappings installed", vim.log.levels.WARN)

return M