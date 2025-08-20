-- Tailwind CSS v4 Configuration
-- Disables CSS validation for files containing Tailwind v4 directives

local M = {}

-- Function to check if buffer contains Tailwind v4 directives
local function has_tailwind_v4_directives(bufnr)
  local lines = vim.api.nvim_buf_get_lines(bufnr or 0, 0, 50, false) -- Check first 50 lines
  for _, line in ipairs(lines) do
    if line:match('@utility') or line:match('@config') or line:match('@plugin') or line:match('@theme') then
      return true
    end
  end
  return false
end

-- Disable CSS diagnostics for Tailwind v4 files
function M.setup()
  vim.api.nvim_create_autocmd({"BufEnter", "BufRead"}, {
    pattern = {"*.css", "*.scss", "*.less"},
    callback = function(args)
      if has_tailwind_v4_directives(args.buf) then
        -- Disable diagnostics for this buffer
        vim.diagnostic.disable(args.buf)
        
        -- Also disable LSP diagnostics specifically
        local clients = vim.lsp.get_active_clients({bufnr = args.buf})
        for _, client in pairs(clients) do
          if client.name == "cssls" then
            client.stop()
          end
        end
      end
    end,
    desc = "Disable CSS validation for Tailwind v4 files"
  })
end

return M