-- Fix macro in register q issue
local M = {}

-- Clear register q immediately
vim.fn.setreg('q', '')

-- Prevent saving register q to shada
vim.opt.shada = "'100,<50,s10,h,rq"  -- rq excludes register q from being saved

-- Clear register q on every startup
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    vim.fn.setreg('q', '')
    -- Also clear uppercase Q
    vim.fn.setreg('Q', '')
  end,
  desc = "Clear register q on startup"
})

-- Prevent recording to register q
vim.api.nvim_create_autocmd("RecordingEnter", {
  callback = function()
    local reg = vim.fn.reg_recording()
    if reg == 'q' or reg == 'Q' then
      -- Stop recording immediately
      vim.cmd('normal! q')
      vim.notify("Cannot record to register q (reserved)", vim.log.levels.WARN)
      -- Start recording to register m instead
      vim.cmd('normal! qm')
    end
  end,
  desc = "Redirect recording from q to m"
})

-- Remap qq to use register m instead
vim.keymap.set('n', 'qq', 'qm', { desc = 'Record macro to register m (not q)' })
vim.keymap.set('n', '@q', '@m', { desc = 'Play macro from register m (not q)' })

-- Ensure C-Q mapping works
vim.keymap.set('n', '<C-q>', ':bdelete!<CR>', { 
  desc = 'Close buffer (fixed)',
  noremap = true,
  silent = true 
})
vim.keymap.set('n', '<C-Q>', ':bdelete!<CR>', { 
  desc = 'Close buffer (fixed)',
  noremap = true,
  silent = true 
})

vim.notify("Register q cleared and protected", vim.log.levels.INFO)

return M