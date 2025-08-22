-- Completely disable airline for terminal and neo-tree buffers and use custom statusline
local M = {}

function M.setup()
	-- Define custom highlight groups for statusline
	vim.cmd([[
    hi StatuslinePurple guibg=#9580ff guifg=#282a36 gui=bold
    hi StatuslinePurpleSep guifg=#9580ff guibg=#454158
    hi StatuslineNormal guibg=#454158 guifg=#f8f8f2
  ]])

	-- Disable airline for terminal buffers completely
	vim.api.nvim_create_autocmd({ "TermOpen", "BufEnter", "WinEnter" }, {
		callback = function()
			if vim.bo.buftype == "terminal" then
				-- Disable airline for this window
				vim.w.airline_disabled = 1
				vim.b.airline_disabled = 1

				-- Set our custom statusline with purple background and triangle
				local bufname = vim.api.nvim_buf_get_name(0)
				if bufname:lower():match("claude") then
					vim.wo.statusline = "%#StatuslinePurple# Claude Code %#StatuslinePurpleSep#%#StatuslineNormal#%="
				else
					vim.wo.statusline = "%#StatuslineNormal# Terminal %="
				end
			end
		end,
		desc = "Disable airline and set custom statusline for terminals",
	})

	-- Disable airline for Neo-tree buffers
	vim.api.nvim_create_autocmd({ "FileType", "BufEnter", "WinEnter" }, {
		pattern = "*",
		callback = function()
			if vim.bo.filetype == "neo-tree" then
				-- Disable airline for this window
				vim.w.airline_disabled = 1
				vim.b.airline_disabled = 1

				-- Set custom statusline for Neo-tree with purple background and triangle
				vim.wo.statusline = "%#StatuslinePurple# File Explorer %#StatuslinePurpleSep#%#StatuslineNormal#%="
			end
		end,
		desc = "Disable airline and set custom statusline for Neo-tree",
	})

	-- Command to force refresh statusline for special buffers
	vim.api.nvim_create_user_command("FixStatusline", function()
		if vim.bo.buftype == "terminal" then
			vim.w.airline_disabled = 1
			vim.b.airline_disabled = 1
			local bufname = vim.api.nvim_buf_get_name(0)
			if bufname:lower():match("claude") then
				vim.wo.statusline = "%#StatuslinePurple# Claude Code %#StatuslinePurpleSep#%#StatuslineNormal#%="
			else
				vim.wo.statusline = "%#StatuslineNormal# Terminal %="
			end
		elseif vim.bo.filetype == "neo-tree" then
			vim.w.airline_disabled = 1
			vim.b.airline_disabled = 1
			vim.wo.statusline = "%#StatuslinePurple# File Explorer %#StatuslinePurpleSep#%#StatuslineNormal#%="
		end
	end, { desc = "Fix statusline for special buffers" })
end

return M

