-- Comprehensive C-q diagnostic
local M = {}

-- Clear ALL mappings for C-q
pcall(vim.keymap.del, 'n', '<C-q>')
pcall(vim.keymap.del, 'n', '<C-Q>')
pcall(vim.keymap.del, 'i', '<C-q>')
pcall(vim.keymap.del, 'i', '<C-Q>')
pcall(vim.keymap.del, 'v', '<C-q>')
pcall(vim.keymap.del, 'v', '<C-Q>')
pcall(vim.keymap.del, 't', '<C-q>')
pcall(vim.keymap.del, 't', '<C-Q>')

-- Check all registers
local function check_registers()
  local suspicious = {}
  for i = 97, 122 do  -- a to z
    local char = string.char(i)
    local content = vim.fn.getreg(char)
    if content ~= '' then
      -- Look for patterns that match your description
      if content:match('exit') or content:match('t$') or content:match('j$') then
        table.insert(suspicious, {reg = char, content = content})
      end
    end
  end
  return suspicious
end

-- Install diagnostic mapping
vim.keymap.set('n', '<C-q>', function()
  print("=== C-q Diagnostic ===")
  print("Mode: " .. vim.api.nvim_get_mode().mode)
  
  -- Check register q
  local reg_q = vim.fn.getreg('q')
  if reg_q ~= '' then
    print("Register q contains: " .. vim.inspect(reg_q))
    vim.fn.setreg('q', '')
    print("Cleared register q")
  end
  
  -- Check for suspicious registers
  local suspicious = check_registers()
  if #suspicious > 0 then
    print("Suspicious registers found:")
    for _, r in ipairs(suspicious) do
      print("  Register " .. r.reg .. ": " .. vim.inspect(r.content))
    end
  end
  
  -- Check if any plugin is overriding
  local mappings = vim.api.nvim_get_keymap('n')
  for _, map in ipairs(mappings) do
    if map.lhs == '<C-Q>' or map.lhs == '<C-q>' then
      print("Found mapping: " .. vim.inspect(map))
    end
  end
  
  -- Now actually close buffer
  vim.cmd('bdelete!')
end, { desc = 'Diagnostic C-q', noremap = true, silent = false })

-- Also create a command to show all registers
vim.api.nvim_create_user_command('ShowRegisters', function()
  for i = 97, 122 do
    local char = string.char(i)
    local content = vim.fn.getreg(char)
    if content ~= '' then
      print("Register " .. char .. ": " .. vim.inspect(content))
    end
  end
end, {})

print("Diagnostic loaded. Press C-q to test, or run :ShowRegisters")

return M