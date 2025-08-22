-- Simple statusline override for Claude Code
local M = {}

function M.setup()
  vim.api.nvim_create_autocmd({"BufEnter", "TermOpen", "WinEnter", "BufWinEnter"}, {
    pattern = "*",
    callback = function()
      local bufname = vim.api.nvim_buf_get_name(0)
      local buftype = vim.bo.buftype
      
      if bufname:lower():match("claude") and buftype == "terminal" then
        -- Completely override statusline with a simple one
        vim.opt_local.statusline = '%#DraculaGreen# Claude Code %#Normal#%='
      end
    end,
    desc = "Simple statusline for Claude"
  })
end

return M