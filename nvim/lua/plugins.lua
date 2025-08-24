-- =============================================================================
-- PLUGIN CONFIGURATION WITH LAZY.NVIM
-- =============================================================================
-- This file manages all Neovim plugins using lazy.nvim, a modern plugin manager
-- that provides lazy loading, better performance, and cleaner configuration.
--
-- lazy.nvim features:
-- - Lazy loading by default (plugins load only when needed)
-- - Automatic plugin dependency management
-- - Built-in plugin updating and health checks
-- - Better startup performance
-- - Clean, declarative configuration syntax

-- =============================================================================
-- LAZY.NVIM BOOTSTRAP
-- =============================================================================
-- Automatically install lazy.nvim if it's not already installed
-- This ensures the configuration works on a fresh Neovim installation

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

-- Check if lazy.nvim is already installed
if not vim.loop.fs_stat(lazypath) then
	-- If not installed, clone it from GitHub
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none", -- Faster clone (no file history)
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- Use stable release branch
		lazypath,
	})
end

-- Add lazy.nvim to the runtime path so we can require it
vim.opt.rtp:prepend(lazypath)

-- =============================================================================
-- PLUGIN SETUP AND CONFIGURATION
-- =============================================================================
-- Configure lazy.nvim and define all plugins with their settings

require("lazy").setup({

	-- ==========================================================================
	-- GIT INTEGRATION
	-- ==========================================================================

	-- Git commands within Vim (:Git status, :Git commit, etc.)
	{ "tpope/vim-fugitive", lazy = false },

	-- ==========================================================================
	-- COLORSCHEME AND APPEARANCE
	-- ==========================================================================

	{
		"dracula/vim",
		name = "dracula",
		priority = 1000, -- Load early since it's our colorscheme
		config = function()
			-- Use the Dracula Pro colorscheme we installed
			vim.cmd("colorscheme dracula_pro")
		end,
	},

	-- show colors inline for CSS hex codes (#ff0000 shows as red background)
	{
		"NvChad/nvim-colorizer.lua",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("colorizer").setup({
				filetypes = { "*" },
				user_default_options = {
					RGB = true, -- #RGB hex codes
					RRGGBB = true, -- #RRGGBB hex codes
					names = false, -- "Name" codes like Blue or red
					RRGGBBAA = true, -- #RRGGBBAA hex codes
					AARRGGBB = true, -- 0xAARRGGBB hex codes
					rgb_fn = true, -- CSS rgb() and rgba() functions
					hsl_fn = true, -- CSS hsl() and hsla() functions
					css = true, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
					css_fn = true, -- Enable all CSS *functions*: rgb_fn, hsl_fn
					mode = "background", -- Set the display mode.
					tailwind = true,
					virtualtext = "■",
					always_update = false,
				},
			})
			-- Attach to current buffer
			vim.cmd("ColorizerAttachToBuffer")
		end,
	},

	-- ==========================================================================
	-- STATUSLINE AND UI
	-- ==========================================================================

	{
		"vim-airline/vim-airline",
		lazy = false, -- Load immediately, not lazily
		priority = 1000, -- Load early
		dependencies = {
			"vim-airline/vim-airline-themes", -- Provides color themes for airline
			"powerline/powerline-fonts", -- Special fonts with icons
			"ryanoasis/vim-devicons", -- File type icons
		},
		init = function()
			-- Set variables before plugin loads
			vim.g.airline_powerline_fonts = 1

			-- Enable buffer/tab line at the top
			vim.g["airline#extensions#tabline#enabled"] = 1
			vim.g["airline#extensions#tabline#fnamemod"] = ":t"
			vim.g["airline#extensions#tabline#formatter"] = "unique_tail_improved"

			-- Enable git branch extension
			vim.g["airline#extensions#branch#enabled"] = 1
			vim.g["airline#extensions#branch#format"] = 2
			vim.g["airline#extensions#branch#displayed_head_limit"] = 10
			vim.g["airline#extensions#hunks#enabled"] = 1
			vim.g["airline#extensions#branch#sha1_len"] = 8
			
			-- Configure hunks display format
			vim.g["airline#extensions#hunks#coc_git"] = 0
			vim.g["airline#extensions#hunks#non_zero_only"] = 0

			-- Disable tmuxline integration
			vim.g["airline#extensions#tmuxline#enabled"] = 1

			-- Disable airline for terminal buffers completely
			vim.g["airline#extensions#term#enabled"] = 0
			vim.g.airline_disable_statusline = 0

			-- Exclude terminal buffers from airline
			vim.g.airline_exclude_filetypes = { "terminal" }
			vim.g.airline_exclude_preview = 1
		end,
		config = function()
			-- Configure after plugin loads
			vim.defer_fn(function()
				-- Set theme after plugin loads to avoid conflicts
				vim.g.airline_theme = "dracula_pro"
				
				-- Force airline to detect git branch
				vim.g["airline#extensions#branch#vcs_priority"] = {"git", "mercurial"}
				vim.g["airline#extensions#branch#use_vcscommand"] = 0

				-- Initialize airline symbols table
				if not vim.g.airline_symbols then
					vim.g.airline_symbols = {}
				end

				-- Configure powerline symbols
				vim.g.airline_left_sep = ""
				vim.g.airline_left_alt_sep = ""
				vim.g.airline_right_sep = ""
				vim.g.airline_right_alt_sep = ""
				vim.g.airline_symbols.branch = ""
				vim.g.airline_symbols.readonly = ""
				vim.g.airline_symbols.linenr = ""
				vim.g.airline_symbols.whitespace = "Ξ"
				
				-- Configure git status symbols
				vim.g.airline_symbols.dirty = " ●"
				vim.g.airline_symbols.clean = ""
				
				-- Configure git hunks symbols (detailed git status)
				vim.g["airline#extensions#hunks#hunk_symbols"] = {"+", "~", "-"}
				vim.g["airline#extensions#hunks#non_zero_only"] = 1

				-- Tab separators - using the angled separators you want
				vim.g["airline#extensions#tabline#left_sep"] = ""
				vim.g["airline#extensions#tabline#left_alt_sep"] = ""
				vim.g["airline#extensions#tabline#right_sep"] = ""
				vim.g["airline#extensions#tabline#right_alt_sep"] = ""

				-- Refresh airline to apply changes
				vim.cmd("AirlineRefresh")
				
				-- Force airline to refresh branch detection safely
				pcall(function()
					if vim.g.airline_extensions == nil then
						vim.g.airline_extensions = {}
					end
					vim.cmd("call airline#extensions#branch#init(g:airline_extensions)")
				end)
			end, 100)
		end,
	},

	-- ==========================================================================
	-- LSP AND LANGUAGE SUPPORT
	-- ==========================================================================

	-- Mason: Package manager for LSP servers, formatters, linters, and DAP servers
	{
		"williamboman/mason.nvim",
		cmd = "Mason",
		keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
		build = ":MasonUpdate",
		opts = {
			ensure_installed = {
				"typescript-language-server",
				"html-lsp",
				"css-lsp",
				"lua-language-server",
				"json-lsp",
				"bash-language-server",
				"prettier",
				"eslint_d",
				"stylua",
			},
		},
		config = function(_, opts)
			require("mason").setup(opts)
			local mr = require("mason-registry")
			mr:on("package:install:success", function()
				vim.defer_fn(function()
					-- trigger FileType event to possibly load this newly installed LSP server
					require("lazy.core.handler.event").trigger({
						event = "FileType",
						buf = vim.api.nvim_get_current_buf(),
					})
				end, 100)
			end)
			local function ensure_installed()
				for _, tool in ipairs(opts.ensure_installed) do
					local p = mr.get_package(tool)
					if not p:is_installed() then
						p:install()
					end
				end
			end
			if mr.refresh then
				mr.refresh(ensure_installed)
			else
				ensure_installed()
			end
		end,
	},

	-- LSP Configuration
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"mason.nvim",
			"williamboman/mason-lspconfig.nvim",
		},
		config = function()
			-- Configure LSP servers
			local lspconfig = require("lspconfig")
			local mason_lspconfig = require("mason-lspconfig")

			-- Setup mason-lspconfig
			mason_lspconfig.setup({
				ensure_installed = {
					"ts_ls", -- TypeScript/JavaScript
					"html",
					"cssls",
					"lua_ls",
					"jsonls",
					"bashls", -- Bash language server
				},
				automatic_installation = true,
			})

			-- Configure diagnostics appearance to work well with Dracula Pro
			vim.diagnostic.config({
				virtual_text = {
					prefix = "●", -- Could be '■', '▎', 'x'
					source = "if_many",
				},
				signs = {
					text = {
						[vim.diagnostic.severity.ERROR] = "",
						[vim.diagnostic.severity.WARN] = "",
						[vim.diagnostic.severity.HINT] = "",
						[vim.diagnostic.severity.INFO] = "",
					},
				},
				underline = true,
				update_in_insert = false,
				severity_sort = true,
				float = {
					border = "rounded",
					source = "always",
					header = "",
					prefix = "",
				},
			})

			-- Common LSP keybindings function
			local function on_attach(client, bufnr)
				local opts = { buffer = bufnr, silent = true }

				-- LSP keybindings
				vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
				vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
				vim.keymap.set("n", "gI", vim.lsp.buf.implementation, opts)
				vim.keymap.set("n", "gy", vim.lsp.buf.type_definition, opts)
				vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
				vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
				vim.keymap.set("n", "gK", vim.lsp.buf.signature_help, opts)
				vim.keymap.set("i", "<c-k>", vim.lsp.buf.signature_help, opts)
				vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
				vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, opts)
				vim.keymap.set("n", "<leader>cR", vim.lsp.buf.rename, opts)
				vim.keymap.set("n", "<leader>cf", function()
					vim.lsp.buf.format({ async = true })
				end, opts)
			end

			-- Common capabilities for all LSP servers
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities.textDocument.completion.completionItem.snippetSupport = true

			-- Setup LSP servers
			local servers = {
				ts_ls = {
					settings = {
						typescript = {
							inlayHints = {
								includeInlayParameterNameHints = "all",
								includeInlayParameterNameHintsWhenArgumentMatchesName = false,
								includeInlayFunctionParameterTypeHints = true,
								includeInlayVariableTypeHints = true,
								includeInlayPropertyDeclarationTypeHints = true,
								includeInlayFunctionLikeReturnTypeHints = true,
								includeInlayEnumMemberValueHints = true,
							},
						},
						javascript = {
							inlayHints = {
								includeInlayParameterNameHints = "all",
								includeInlayParameterNameHintsWhenArgumentMatchesName = false,
								includeInlayFunctionParameterTypeHints = true,
								includeInlayVariableTypeHints = true,
								includeInlayPropertyDeclarationTypeHints = true,
								includeInlayFunctionLikeReturnTypeHints = true,
								includeInlayEnumMemberValueHints = true,
							},
						},
					},
				},
				html = {},
				cssls = {
					init_options = {
						provideFormatter = true,
					},
					settings = {
						css = {
							validate = false, -- Disable CSS validation completely for Tailwind v4
						},
						scss = {
							validate = false,
						},
						less = {
							validate = false,
						},
					},
				},
				jsonls = {
					settings = {
						json = {
							schemas = require("schemastore").json.schemas(),
							validate = { enable = true },
						},
					},
				},
				bashls = {},
				lua_ls = {
					settings = {
						Lua = {
							runtime = {
								version = "LuaJIT",
							},
							diagnostics = {
								globals = { "vim" },
							},
							workspace = {
								library = vim.api.nvim_get_runtime_file("", true),
								checkThirdParty = false,
							},
							telemetry = {
								enable = false,
							},
						},
					},
				},
			}

			-- Setup each server
			for server, config in pairs(servers) do
				config.on_attach = on_attach
				config.capabilities = capabilities
				lspconfig[server].setup(config)
			end

			-- Setup Tailwind v4 support
			require("config.tailwind-v4").setup()

			-- Setup Shopify Liquid LSP support
			require("config.liquid-lsp").setup()
		end,
	},

	-- JSON schemas for better JSON editing
	{ "b0o/schemastore.nvim", lazy = true },

	-- Mason-lspconfig bridge
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = { "mason.nvim" },
		lazy = true,
	},

	-- ==========================================================================
	-- AUTO-COMPLETION
	-- ==========================================================================

	-- Main completion engine
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp", -- LSP completions
			"hrsh7th/cmp-buffer", -- Buffer completions
			"hrsh7th/cmp-path", -- Path completions
			"hrsh7th/cmp-cmdline", -- Command line completions
			"L3MON4D3/LuaSnip", -- Snippet engine
			"saadparwaiz1/cmp_luasnip", -- Snippet completions
			"rafamadriz/friendly-snippets", -- Collection of snippets
		},
		config = function()
			local cmp = require("cmp")
			local luasnip = require("luasnip")

			-- Load friendly snippets
			require("luasnip.loaders.from_vscode").lazy_load()

			cmp.setup({
				enabled = function()
					-- Enable completions only for Liquid files
					local buftype = vim.api.nvim_buf_get_option(0, "filetype")
					return buftype == "liquid" or buftype:match("%.liquid$")
				end,
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				window = {
					completion = {
						border = "rounded",
						winhighlight = "Normal:CmpPmenu,CursorLine:CmpSel,Search:None",
					},
					documentation = {
						border = "rounded",
					},
				},
				mapping = cmp.mapping.preset.insert({
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(), -- Manual trigger
					["<C-e>"] = cmp.mapping.abort(),
					["<CR>"] = cmp.mapping.confirm({ select = true }),
					-- For Liquid files, use arrow keys for completion navigation
					["<Down>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						else
							fallback()
						end
					end, { "i", "s" }),
					["<Up>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						else
							fallback()
						end
					end, { "i", "s" }),
					-- Tab is for Supermaven
					["<Tab>"] = cmp.mapping(function(fallback)
						-- Let Supermaven handle Tab
						fallback()
					end, { "i", "s" }),
					["<S-Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						elseif luasnip.jumpable(-1) then
							luasnip.jump(-1)
						else
							fallback()
						end
					end, { "i", "s" }),
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
				}, {
					{ name = "buffer" },
					{ name = "path" },
				}),
				formatting = {
					format = function(entry, vim_item)
						-- Define completion item kind icons
						local icons = {
							Text = "",
							Method = "󰆧",
							Function = "󰊕",
							Constructor = "",
							Field = "󰇽",
							Variable = "󰂡",
							Class = "󰠱",
							Interface = "",
							Module = "",
							Property = "󰜢",
							Unit = "",
							Value = "󰎠",
							Enum = "",
							Keyword = "󰌋",
							Snippet = "",
							Color = "󰏘",
							File = "󰈙",
							Reference = "",
							Folder = "󰉋",
							EnumMember = "",
							Constant = "󰏿",
							Struct = "",
							Event = "",
							Operator = "󰆕",
							TypeParameter = "󰅲",
						}

						vim_item.kind = string.format("%s %s", icons[vim_item.kind], vim_item.kind)
						vim_item.menu = ({
							nvim_lsp = "[LSP]",
							luasnip = "[Snippet]",
							buffer = "[Buffer]",
							path = "[Path]",
						})[entry.source.name]

						return vim_item
					end,
				},
			})

			-- Setup cmdline completion
			cmp.setup.cmdline("/", {
				mapping = cmp.mapping.preset.cmdline(),
				sources = {
					{ name = "buffer" },
				},
			})

			cmp.setup.cmdline(":", {
				mapping = cmp.mapping.preset.cmdline(),
				sources = cmp.config.sources({
					{ name = "path" },
				}, {
					{ name = "cmdline" },
				}),
			})
		end,
	},

	-- Snippet dependencies for nvim-cmp
	{
		"L3MON4D3/LuaSnip",
		build = "make install_jsregexp",
		dependencies = {
			"rafamadriz/friendly-snippets",
		},
	},

	-- ==========================================================================
	-- TEXT MANIPULATION AND EDITING
	-- ==========================================================================

	-- AI-powered code completion
	{
		"supermaven-inc/supermaven-nvim",
		config = function()
			require("supermaven-nvim").setup({
				keymaps = {
					accept_suggestion = "<Tab>",
					clear_suggestion = "<C-]>",
					accept_word = "<C-j>",
				},
				ignore_filetypes = {},
				color = {
					suggestion_color = "#808080",
					cterm = 244,
				},
				disable_inline_completion = false, -- Keep inline completion enabled
				disable_keymaps = false, -- Use our custom keymaps
			})
		end,
	},
	-- ==========================================================================
	-- FILE EXPLORER AND NAVIGATION
	-- ==========================================================================

	-- Modern file explorer with git integration
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		cmd = "Neotree",
		keys = {
			{
				"<leader>fe",
				"<cmd>Neotree toggle<cr>",
				desc = "Explorer NeoTree (root dir)",
			},
			{
				"<leader>fE",
				"<cmd>Neotree toggle float<cr>",
				desc = "Explorer NeoTree (float)",
			},
			{
				"<leader>h",
				function()
					-- Check if current buffer is Neo-tree
					if vim.bo.filetype == "neo-tree" then
						vim.cmd("Neotree close")
					else
						vim.cmd("Neotree focus")
					end
				end,
				desc = "Toggle/Focus NeoTree",
			},
		},
		deactivate = function()
			vim.cmd([[Neotree close]])
		end,
		-- Remove init function to prevent auto-opening on startup
		-- init = function()
		-- 	if vim.fn.argc(-1) == 1 then
		-- 		local stat = vim.loop.fs_stat(vim.fn.argv(0))
		-- 		if stat and stat.type == "directory" then
		-- 			require("neo-tree")
		-- 		end
		-- 	end
		-- end,
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
		},
		config = function()
			-- Configure Neo-tree to work well with Dracula Pro
			require("neo-tree").setup({
				close_if_last_window = false,
				popup_border_style = "rounded",
				enable_git_status = true,
				enable_diagnostics = true,
				open_files_do_not_replace_types = { "terminal", "trouble", "qf" },
				sort_case_insensitive = false,
				retain_hidden_root_indent = false,
				resize_timer_interval = 500, -- Delay between window resizes
				auto_clean_after_session_restore = true,
				-- Removed problematic event_handlers that were preventing focus
				default_component_configs = {
					container = {
						enable_character_fade = true,
					},
					indent = {
						indent_size = 2,
						padding = 1,
						with_markers = true,
						indent_marker = "│",
						last_indent_marker = "└",
						highlight = "NeoTreeIndentMarker",
						with_expanders = nil,
						expander_collapsed = "",
						expander_expanded = "",
						expander_highlight = "NeoTreeExpander",
					},
					icon = {
						folder_closed = "",
						folder_open = "",
						folder_empty = "",
						default = "*",
						highlight = "NeoTreeFileIcon",
					},
					modified = {
						symbol = "[+]",
						highlight = "NeoTreeModified",
					},
					name = {
						trailing_slash = false,
						use_git_status_colors = true,
						highlight = "NeoTreeFileName",
					},
					git_status = {
						symbols = {
							added = "",
							modified = "",
							deleted = "✖",
							renamed = "",
							untracked = "",
							ignored = "",
							unstaged = "",
							staged = "",
							conflict = "",
						},
					},
				},
				window = {
					position = "left",
					width = 40,
					auto_expand_width = false, -- Don't auto-expand width
					mapping_options = {
						noremap = true,
						nowait = true,
					},
					mappings = {
						["<space>"] = {
							"toggle_node",
							nowait = false,
						},
						["<2-LeftMouse>"] = {
							"open",
							nowait = false,
						},
						["<cr>"] = {
							"open",
							nowait = false,
						},
						["<esc>"] = "revert_preview",
						["P"] = { "toggle_preview", config = { use_float = true } },
						-- Arrow key navigation - simplified and reliable
						["<Right>"] = {
							"toggle_node",
							nowait = false,
						},
						["<Left>"] = "close_node",
						["h"] = "close_node",
						["l"] = {
							"toggle_node",
							nowait = false,
						},
						["S"] = "open_split",
						["s"] = "open_vsplit",
						["t"] = "open_tabnew",
						["w"] = "open_with_window_picker",
						["C"] = "close_node",
						["z"] = "close_all_nodes",
						["a"] = {
							"add",
							config = {
								show_path = "none",
							},
						},
						["A"] = "add_directory",
						["d"] = "delete",
						["r"] = "rename",
						["y"] = "copy_to_clipboard",
						["x"] = "cut_to_clipboard",
						["p"] = "paste_from_clipboard",
						["c"] = "copy",
						["m"] = "move",
						["q"] = "close_window",
						["R"] = "refresh",
						["?"] = "show_help",
						["<"] = "prev_source",
						[">"] = "next_source",
					},
				},
				filesystem = {
					filtered_items = {
						visible = false,
						hide_dotfiles = true,
						hide_gitignored = true,
						hide_hidden = true,
						hide_by_name = {
							"node_modules",
						},
						hide_by_pattern = {
							"*.meta",
							"*/src/*/tsconfig.json",
						},
						always_show = {
							".gitignored",
						},
						never_show = {
							".DS_Store",
							"thumbs.db",
						},
					},
					follow_current_file = {
						enabled = false,
						leave_dirs_open = false,
					},
					group_empty_dirs = false,
					hijack_netrw_behavior = "open_default",
					use_libuv_file_watcher = false,
				},
				buffers = {
					follow_current_file = {
						enabled = true,
						leave_dirs_open = false,
					},
					group_empty_dirs = true,
					show_unloaded = true,
				},
				git_status = {
					window = {
						position = "float",
						mappings = {
							["A"] = "git_add_all",
							["gu"] = "git_unstage_file",
							["ga"] = "git_add_file",
							["gr"] = "git_revert_file",
							["gc"] = "git_commit",
							["gp"] = "git_push",
							["gg"] = "git_commit_and_push",
						},
					},
				},
			})

			-- Custom highlight groups for Dracula Pro compatibility
			vim.cmd([[
        hi NeoTreeNormal guibg=#282a36
        hi NeoTreeNormalNC guibg=#282a36
        hi NeoTreeVertSplit guifg=#44475a guibg=#282a36
        hi NeoTreeWinSeparator guifg=#44475a guibg=#282a36
        hi NeoTreeEndOfBuffer guibg=#282a36
      ]])

			-- Fix window sizing issues when files are opened/closed
			local function fix_neotree_width()
				local neotree_win = nil
				for _, win in ipairs(vim.api.nvim_list_wins()) do
					local buf = vim.api.nvim_win_get_buf(win)
					local ft = vim.api.nvim_buf_get_option(buf, "filetype")
					if ft == "neo-tree" then
						neotree_win = win
						break
					end
				end

				if neotree_win then
					vim.api.nvim_win_set_width(neotree_win, 40)
				end
			end

			-- Auto-resize Neo-tree and manage window focus
			vim.api.nvim_create_autocmd({ "BufEnter", "WinEnter" }, {
				callback = function()
					-- Small delay to ensure window layout is stable
					vim.defer_fn(function()
						pcall(fix_neotree_width) -- Use pcall to prevent errors
					end, 50)
				end,
				desc = "Fix Neo-tree width after opening files",
			})

			-- Smart window management to prevent Neo-tree from taking focus
			vim.api.nvim_create_autocmd("WinClosed", {
				callback = function(args)
					local winnr = tonumber(args.match)
					if not winnr then
						return
					end

					vim.schedule(function()
						-- Get all windows
						local windows = vim.api.nvim_list_wins()
						local neotree_win = nil
						local file_wins = {}

						for _, win in ipairs(windows) do
							local buf = vim.api.nvim_win_get_buf(win)
							local ft = vim.api.nvim_buf_get_option(buf, "filetype")
							local bt = vim.api.nvim_buf_get_option(buf, "buftype")

							if ft == "neo-tree" then
								neotree_win = win
							elseif bt == "" then -- Regular file buffer
								table.insert(file_wins, win)
							end
						end

						-- If Neo-tree is focused but there are file windows, switch focus
						if neotree_win and vim.api.nvim_get_current_win() == neotree_win and #file_wins > 0 then
							vim.api.nvim_set_current_win(file_wins[1])
						end

						-- Always fix Neo-tree width
						if neotree_win then
							vim.api.nvim_win_set_width(neotree_win, 40)
						end
					end)
				end,
				desc = "Prevent Neo-tree from taking focus when closing windows",
			})
		end,
	},

	-- Window picker for Neo-tree
	{
		"s1n7ax/nvim-window-picker",
		name = "window-picker",
		event = "VeryLazy",
		version = "2.*",
		config = function()
			require("window-picker").setup({
				autoselect_one = true,
				include_current = false,
				filter_rules = {
					bo = {
						filetype = { "neo-tree", "neo-tree-popup", "notify" },
						buftype = { "terminal", "quickfix" },
					},
				},
				other_win_hl_color = "#e06c75",
			})
		end,
	},

	-- ==========================================================================
	-- FUZZY FINDING AND FILE NAVIGATION
	-- ==========================================================================

	{
		"junegunn/fzf",
		build = function()
			-- Install/update the fzf binary
			vim.fn["fzf#install"]()
		end,
	},
	{
		"junegunn/fzf.vim",
		dependencies = { "junegunn/fzf" },
		keys = {
			-- Only load when these keys are pressed (lazy loading)
			{ "<C-P>", ":Files<CR>", desc = "Find all files (respects .gitignore)" },
			{ "<C-[>", ":GFiles?<CR>", desc = "Find files in git with status" },
			{ "<C-E>", ":Rg<CR>", desc = "Search text in files" },
		},
		config = function()
			-- Minimal FZF configuration to avoid conflicts
			vim.g.fzf_layout = { down = "~40%" }
			-- Don't override any default commands, use FZF defaults
		end,
	},

	-- ==========================================================================
	-- TEXT MANIPULATION AND EDITING
	-- ==========================================================================

	-- Surround text with brackets, quotes, etc. (e.g., cs"' to change "hello" to 'hello')
	{ "tpope/vim-surround", event = "BufRead" },

	-- Comment/uncomment lines with gc (e.g., gcc for line, gc3j for 3 lines)
	{ "tpope/vim-commentary", keys = { "gc", "gcc" } },

	-- Alternative commenting plugin with more features
	{ "scrooloose/nerdcommenter", keys = { "<leader>c" } },

	-- ==========================================================================
	-- SYNTAX HIGHLIGHTING AND PARSING
	-- ==========================================================================

	{
		"nvim-treesitter/nvim-treesitter",
		event = "BufRead",
		build = ":TSUpdate", -- Update parsers after installation
		config = function()
			require("nvim-treesitter.configs").setup({
				-- Languages to install parsers for
				ensure_installed = {
					"javascript",
					"typescript",
					"html",
					"css",
					"lua",
					"vim",
					"json",
					"markdown",
					"bash",
					"liquid",
				},
				-- Additional parser configurations
				liquid = {
					install_info = {
						url = "https://github.com/hankthetank27/tree-sitter-liquid",
						files = { "src/parser.c" },
						branch = "main",
					},
				},
				highlight = {
					enable = true, -- Enable treesitter highlighting
					additional_vim_regex_highlighting = { "json" }, -- Use additional highlighting for JSON
				},
				indent = { enable = true }, -- Enable treesitter-based indentation
			})
		end,
	},

	-- Sticky context bar showing current function/class/tag context
	{
		"nvim-treesitter/nvim-treesitter-context",
		event = "BufRead",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		config = function()
			require("treesitter-context").setup({
				enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
				max_lines = 3, -- How many lines the window should span. Values <= 0 mean no limit.
				min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
				line_numbers = true,
				multiline_threshold = 20, -- Maximum number of lines to show for a single context
				trim_scope = "outer", -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
				mode = "cursor", -- Line used to calculate context. Choices: 'cursor', 'topline'
				-- Separator between context and content. Should be a single character string, like '-'.
				-- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
				separator = nil,
				zindex = 20, -- The Z-index of the context window
				on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
			})

			-- Keymaps for context navigation
			vim.keymap.set("n", "[c", function()
				require("treesitter-context").go_to_context(vim.v.count1)
			end, { silent = true, desc = "Jump to context (upwards)" })

			-- Style the context bar to match Dracula theme
			vim.cmd([[
				hi TreesitterContext guibg=#454158 gui=italic
				hi TreesitterContextLineNumber guifg=#7970a9 guibg=#454158
				"hi TreesitterContextBottom gui=underline guisp=#454158
			]])
		end,
	},

	-- ==========================================================================
	-- ADVANCED EDITING FEATURES
	-- ==========================================================================

	-- Multi-cursor editing (Ctrl+N to select next occurrence)
	{ "mg979/vim-visual-multi", keys = { "<C-n>", "<C-Down>", "<C-Up>" } },

	-- Code outline and navigation
	{ "preservim/tagbar", cmd = "TagbarToggle" },

	-- JavaScript/CSS/HTML formatting
	{
		"prettier/vim-prettier",
		ft = { "javascript", "typescript", "css", "html", "json" },
		keys = {
			{ "<leader>p", ":Prettier<CR>", desc = "Format document with Prettier" },
		},
	},

	-- ==========================================================================
	-- LANGUAGE-SPECIFIC SYNTAX HIGHLIGHTING
	-- ==========================================================================

	-- Shopify Liquid templating language
	{
		"tpope/vim-liquid",
		ft = { "liquid", "html.liquid", "css.liquid", "javascript.liquid", "json.liquid" },
		config = function()
			-- Ensure Liquid syntax highlighting works optimally
			vim.g.liquid_highlight_all = 1
			-- Set Liquid filetype for .liquid files
			vim.g.liquid_default_subtype = "html"

			-- Configure Liquid-specific settings
			vim.api.nvim_create_autocmd("FileType", {
				pattern = { "liquid", "*.liquid" },
				callback = function()
					-- Enable matchit for % navigation between Liquid tags
					vim.b.match_words = "{% if %}:{% elsif %}:{% else %}:{% endif %},"
						.. "{% for %}:{% endfor %},"
						.. "{% case %}:{% when %}:{% else %}:{% endcase %},"
						.. "{% unless %}:{% endunless %},"
						.. "{% capture %}:{% endcapture %},"
						.. "{% comment %}:{% endcomment %},"
						.. "{% raw %}:{% endraw %},"
						.. "{% block %}:{% endblock %}"
				end,
			})
		end,
	},

	-- JavaScript and JSX support
	{ "mxw/vim-jsx", ft = { "javascript", "javascriptreact" } },
	{ "yuezk/vim-js", ft = "javascript" },
	{ "maxmellon/vim-jsx-pretty", ft = { "javascript", "javascriptreact" } },

	-- TypeScript support
	{ "leafgarland/typescript-vim", ft = "typescript" },

	-- Markdown with better syntax highlighting
	{ "plasticboy/vim-markdown", ft = "markdown" },

	-- Fish shell syntax
	{ "dag/vim-fish", ft = "fish" },

	-- Kitty terminal config syntax
	{ "fladson/vim-kitty", ft = "kitty" },

	-- Mustache/Handlebars templating
	{ "mustache/vim-mustache-handlebars", ft = { "mustache", "handlebars" } },

	-- ==========================================================================
	-- TMUX INTEGRATION
	-- ==========================================================================

	-- Share clipboard between tmux and vim
	"roxma/vim-tmux-clipboard",

	-- Syntax highlighting for tmux config files
	{ "tmux-plugins/vim-tmux", ft = "tmux" },

	-- ==========================================================================
	-- KEY DISCOVERY AND HELP
	-- ==========================================================================

	-- Which-key: Shows available keybindings in popup
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		config = function()
			-- Set timeout options before setup
			vim.o.timeout = true
			vim.o.timeoutlen = 300

			local wk = require("which-key")

			-- Setup with some basic styling
			wk.setup({
				win = {
					border = "rounded",
				},
			})

			-- Register leader groups
			wk.add({
				{ "<leader>", group = "Leader" },
				{ "<leader>f", group = "File/Find" },
				{ "<leader>c", group = "Code" },
				{ "<leader>g", group = "Git" },
				{ "<leader>x", group = "Diagnostics" },
				{ "<leader>s", group = "Search" },
				{ "<leader>b", group = "Buffer" },
				{ "<leader>q", group = "Session" },
				{ "<leader>t", group = "Terminal" },
			})

			-- Register window commands
			wk.add({
				{ "<C-w>", group = "Window" },
				{ "<C-w>h", desc = "Go left" },
				{ "<C-w>j", desc = "Go down" },
				{ "<C-w>k", desc = "Go up" },
				{ "<C-w>l", desc = "Go right" },
				{ "<C-w>s", desc = "Split horizontal" },
				{ "<C-w>v", desc = "Split vertical" },
				{ "<C-w>c", desc = "Close window" },
				{ "<C-w>o", desc = "Close others" },
				{ "<C-w>=", desc = "Equal size" },
				{ "<C-w>>", desc = "Width +5" },
				{ "<C-w><", desc = "Width -5" },
				{ "<C-w>+", desc = "Height +5" },
				{ "<C-w>-", desc = "Height -5" },
			})
		end,
	},

	-- ==========================================================================
	-- GIT INTEGRATION ENHANCEMENTS
	-- ==========================================================================

	-- Git signs in the gutter
	{
		"lewis6991/gitsigns.nvim",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("gitsigns").setup({
				signs = {
					add = { text = "│" },
					change = { text = "│" },
					delete = { text = "_" },
					topdelete = { text = "‾" },
					changedelete = { text = "~" },
					untracked = { text = "┆" },
				},
				signcolumn = true,
				numhl = false,
				linehl = false,
				word_diff = false,
				watch_gitdir = {
					interval = 1000,
					follow_files = true,
				},
				attach_to_untracked = true,
				current_line_blame = false,
				current_line_blame_opts = {
					virt_text = true,
					virt_text_pos = "eol",
					delay = 1000,
					ignore_whitespace = false,
				},
				sign_priority = 6,
				update_debounce = 100,
				status_formatter = nil,
				max_file_length = 40000,
				preview_config = {
					border = "single",
					style = "minimal",
					relative = "cursor",
					row = 0,
					col = 1,
				},
				on_attach = function(bufnr)
					local gs = package.loaded.gitsigns

					local function map(mode, l, r, opts)
						opts = opts or {}
						opts.buffer = bufnr
						vim.keymap.set(mode, l, r, opts)
					end

					-- Navigation
					map("n", "]c", function()
						if vim.wo.diff then
							return "]c"
						end
						vim.schedule(function()
							gs.next_hunk()
						end)
						return "<Ignore>"
					end, { expr = true })

					map("n", "[c", function()
						if vim.wo.diff then
							return "[c"
						end
						vim.schedule(function()
							gs.prev_hunk()
						end)
						return "<Ignore>"
					end, { expr = true })

					-- Actions
					map("n", "<leader>gs", gs.stage_hunk, { desc = "Stage hunk" })
					map("n", "<leader>gr", gs.reset_hunk, { desc = "Reset hunk" })
					map("v", "<leader>gs", function()
						gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
					end, { desc = "Stage hunk" })
					map("v", "<leader>gr", function()
						gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
					end, { desc = "Reset hunk" })
					map("n", "<leader>gS", gs.stage_buffer, { desc = "Stage buffer" })
					map("n", "<leader>gu", gs.undo_stage_hunk, { desc = "Undo stage hunk" })
					map("n", "<leader>gR", gs.reset_buffer, { desc = "Reset buffer" })
					map("n", "<leader>gp", gs.preview_hunk, { desc = "Preview hunk" })
					map("n", "<leader>gb", function()
						gs.blame_line({ full = true })
					end, { desc = "Blame line" })
					map("n", "<leader>gtb", gs.toggle_current_line_blame, { desc = "Toggle line blame" })
					map("n", "<leader>gd", gs.diffthis, { desc = "Diff this" })
					map("n", "<leader>gD", function()
						gs.diffthis("~")
					end, { desc = "Diff this ~" })
					map("n", "<leader>gtd", gs.toggle_deleted, { desc = "Toggle deleted" })

					-- Text object
					map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", { desc = "Select hunk" })
				end,
			})
		end,
	},

	-- ==========================================================================
	-- FORMATTING AND LINTING
	-- ==========================================================================

	-- Modern formatter
	{
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		keys = {
			{
				"<leader>cf",
				function()
					require("conform").format({ async = true, lsp_fallback = true })
				end,
				mode = "",
				desc = "Format buffer",
			},
		},
		opts = {
			formatters_by_ft = {
				lua = { "stylua" },
				fish = { "fish_indent" },
				sh = { "shfmt" },
				javascript = { "prettierd", "prettier", stop_after_first = true },
				typescript = { "prettierd", "prettier", stop_after_first = true },
				javascriptreact = { "prettierd", "prettier", stop_after_first = true },
				typescriptreact = { "prettierd", "prettier", stop_after_first = true },
				vue = { "prettierd", "prettier", stop_after_first = true },
				css = { "prettierd", "prettier", stop_after_first = true },
				scss = { "prettierd", "prettier", stop_after_first = true },
				less = { "prettierd", "prettier", stop_after_first = true },
				html = { "prettierd", "prettier", stop_after_first = true },
				json = { "prettierd", "prettier", stop_after_first = true },
				jsonc = { "prettierd", "prettier", stop_after_first = true },
				yaml = { "prettierd", "prettier", stop_after_first = true },
				markdown = { "prettierd", "prettier", stop_after_first = true },
				graphql = { "prettierd", "prettier", stop_after_first = true },
				handlebars = { "prettier" },
				liquid = { "prettier" }, -- Add Liquid formatting support
			},
			format_on_save = {
				timeout_ms = 500,
				lsp_fallback = true,
			},
			formatters = {
				shfmt = {
					prepend_args = { "-i", "2" },
				},
				prettier = {
					prepend_args = function(self, ctx)
						local args = {}

						-- Add Liquid plugin for .liquid files
						if vim.bo[ctx.buf].filetype == "liquid" then
							table.insert(args, "--plugin")
							table.insert(args, "@shopify/prettier-plugin-liquid")
							table.insert(args, "--parser")
							table.insert(args, "liquid-html")
						end

						return args
					end,
				},
			},
		},
		init = function()
			vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
		end,
	},

	-- Linting
	{
		"mfussenegger/nvim-lint",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			local lint = require("lint")

			lint.linters_by_ft = {
				-- Disabled eslint_d due to parsing errors - using LSP diagnostics instead
				-- javascript = { "eslint_d" },
				-- typescript = { "eslint_d" },
				-- javascriptreact = { "eslint_d" },
				-- typescriptreact = { "eslint_d" },
				-- svelte = { "eslint_d" },
				python = { "pylint" },
				-- Note: CSS linting disabled to avoid conflicts with Tailwind CSS v4 at-rules
				-- css = {},  -- Explicitly empty to disable CSS linting
			}

			local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

			vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
				group = lint_augroup,
				callback = function()
					lint.try_lint()
				end,
			})

			vim.keymap.set("n", "<leader>cl", function()
				lint.try_lint()
			end, { desc = "Trigger linting for current file" })
		end,
	},

	-- ==========================================================================
	-- DIAGNOSTICS AND TROUBLE SHOOTING
	-- ==========================================================================

	-- Better diagnostics list
	{
		"folke/trouble.nvim",
		cmd = { "TroubleToggle", "Trouble" },
		keys = {
			{ "<leader>xx", "<cmd>TroubleToggle<cr>", desc = "Toggle Trouble" },
			{ "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>", desc = "Workspace Diagnostics" },
			{ "<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>", desc = "Document Diagnostics" },
			{ "<leader>xl", "<cmd>TroubleToggle loclist<cr>", desc = "Location List" },
			{ "<leader>xq", "<cmd>TroubleToggle quickfix<cr>", desc = "Quickfix List" },
			{ "gR", "<cmd>TroubleToggle lsp_references<cr>", desc = "LSP References" },
		},
		config = function()
			require("trouble").setup({
				position = "bottom",
				height = 10,
				width = 50,
				icons = true,
				mode = "workspace_diagnostics",
				fold_open = "",
				fold_closed = "",
				group = true,
				padding = true,
				action_keys = {
					close = "q",
					cancel = "<esc>",
					refresh = "r",
					jump = { "<cr>", "<tab>" },
					open_split = { "<c-x>" },
					open_vsplit = { "<c-v>" },
					open_tab = { "<c-t>" },
					jump_close = { "o" },
					toggle_mode = "m",
					toggle_preview = "P",
					hover = "K",
					preview = "p",
					close_folds = { "zM", "zm" },
					open_folds = { "zR", "zr" },
					toggle_fold = { "zA", "za" },
					previous = "k",
					next = "j",
				},
				indent_lines = true,
				auto_open = false,
				auto_close = false,
				auto_preview = true,
				auto_fold = false,
				auto_jump = { "lsp_definitions" },
				signs = {
					error = "",
					warning = "",
					hint = "",
					information = "",
					other = "﫠",
				},
				use_diagnostic_signs = false,
			})
		end,
	},

	-- ==========================================================================
	-- DASHBOARD AND SESSION MANAGEMENT
	-- ==========================================================================

	-- Startup dashboard
	{
		"goolord/alpha-nvim",
		event = "VimEnter",
		config = function()
			local alpha = require("alpha")
			local dashboard = require("alpha.themes.dashboard")

			-- Set header
			dashboard.section.header.val = {
				"                                                     ",
				"  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
				"  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
				"  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ",
				"  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
				"  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
				"  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
				"                                                     ",
				"        🧛‍♂️ Dracula Pro Edition 🧛‍♂️                    ",
				"                                                     ",
			}

			-- Set menu
			dashboard.section.buttons.val = {
				dashboard.button("f", "  Find file", ":Telescope find_files <CR>"),
				dashboard.button("e", "  New file", ":ene <BAR> startinsert <CR>"),
				dashboard.button("r", "  Recently used files", ":Telescope oldfiles <CR>"),
				dashboard.button("t", "  Find text", ":Telescope live_grep <CR>"),
				dashboard.button("c", "  Configuration", ":e ~/.config/nvim/init.lua <CR>"),
				dashboard.button("q", "  Quit Neovim", ":qa<CR>"),
			}

			-- Set footer
			local function footer()
				local total_plugins = #vim.tbl_keys(packer_plugins or {})
				local datetime = os.date(" %d-%m-%Y   %H:%M:%S")
				local version = vim.version()
				local nvim_version_info = "   v" .. version.major .. "." .. version.minor .. "." .. version.patch

				return datetime .. "   " .. total_plugins .. " plugins" .. nvim_version_info
			end

			dashboard.section.footer.val = footer()

			dashboard.section.footer.opts.hl = "Type"
			dashboard.section.header.opts.hl = "Include"
			dashboard.section.buttons.opts.hl = "Keyword"

			dashboard.opts.opts.noautocmd = true
			alpha.setup(dashboard.opts)
		end,
	},

	-- Session persistence
	{
		"folke/persistence.nvim",
		event = "BufReadPre",
		keys = {
			{
				"<leader>qs",
				function()
					require("persistence").load()
				end,
				desc = "Restore Session",
			},
			{
				"<leader>ql",
				function()
					require("persistence").load({ last = true })
				end,
				desc = "Restore Last Session",
			},
			{
				"<leader>qd",
				function()
					require("persistence").stop()
				end,
				desc = "Don't Save Current Session",
			},
		},
		config = function()
			require("persistence").setup({
				dir = vim.fn.expand(vim.fn.stdpath("state") .. "/sessions/"),
				options = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp" },
				pre_save = nil,
			})
		end,
	},

	-- ==========================================================================
	-- CLAUDE CODE INTEGRATION
	-- ==========================================================================

	-- Claude Code Neovim integration
	{
		"greggh/claude-code.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		keys = {
			{
				"<leader>l",
				function()
					-- Check if current buffer is Claude Code terminal
					local bufname = vim.api.nvim_buf_get_name(0)
					if bufname:match("term://.*claude") then
						-- We're in Claude, close it by going to previous window and closing Claude
						vim.cmd("wincmd p")
						vim.cmd("ClaudeCode")
					else
						vim.cmd("ClaudeCode")
					end
				end,
				desc = "Toggle Claude Code",
			},
			{ "<leader>cc", "<cmd>ClaudeCodeContinue<cr>", desc = "Continue Claude conversation" },
			{ "<leader>cr", "<cmd>ClaudeCodeResume<cr>", desc = "Resume Claude conversation" },
		},
		config = function()
			require("claude-code").setup({
				window = {
					position = "vertical",
					width = 80,
				},
			})

			-- Exclude Claude Code terminal from buffer list and airline tabline
			vim.api.nvim_create_autocmd({ "TermOpen", "BufEnter", "WinEnter" }, {
				pattern = "*",
				callback = function()
					local bufname = vim.api.nvim_buf_get_name(0)
					local buftype = vim.bo.buftype

					-- More flexible matching for any buffer with "claude" in the name
					if bufname:lower():match("claude") and buftype == "terminal" then
						vim.bo.buflisted = false
						vim.bo.bufhidden = "hide"

						-- Add keybindings specifically for Claude Code terminal
						local opts = { buffer = true, silent = true }
						-- Use <C-q> to quickly return to previous window
						vim.keymap.set("t", "<C-q>", [[<C-\><C-n><C-w>p]], opts)

						-- Override airline completely for this buffer
						vim.defer_fn(function()
							-- Clear all sections
							vim.b.airline_section_a = "Claude Code"
							vim.b.airline_section_b = ""
							vim.b.airline_section_c = ""
							vim.b.airline_section_x = ""
							vim.b.airline_section_y = ""
							vim.b.airline_section_z = ""
							vim.b.airline_section_warning = ""
							vim.b.airline_section_error = ""

							-- Force airline to refresh
							if vim.fn.exists(":AirlineRefresh") == 2 then
								vim.cmd("AirlineRefresh!")
							end
						end, 200)
					end
				end,
			})

			-- Also configure airline to exclude Claude Code terminals
			vim.g["airline#extensions#tabline#ignore_bufadd_pat"] = "term://.*claude\\|Claude\\sCode"
		end,
	},

	-- ==========================================================================
	-- TERMINAL INTEGRATION
	-- ==========================================================================

	-- Better terminal integration
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		keys = {
			{ "<c-\\>", "<cmd>ToggleTerm<cr>", desc = "Toggle terminal" },
		},
		config = function()
			require("toggleterm").setup({
				size = function(term)
					if term.direction == "horizontal" then
						return 15
					elseif term.direction == "vertical" then
						return vim.o.columns * 0.4
					end
				end,
				open_mapping = [[<c-\>]],
				hide_numbers = true,
				shade_filetypes = {},
				shade_terminals = true,
				shading_factor = 2,
				start_in_insert = true,
				insert_mappings = true,
				persist_size = true,
				direction = "vertical",
				close_on_exit = true,
				shell = vim.o.shell,
				float_opts = {
					border = "curved",
					winblend = 0,
					highlights = {
						border = "Normal",
						background = "Normal",
					},
				},
			})

			-- Set terminal keymaps
			function _G.set_terminal_keymaps()
				local opts = { buffer = 0 }
				vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
				vim.keymap.set("t", "jk", [[<C-\><C-n>]], opts)
				vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
				vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
				vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
				vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts)
			end

			vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")
		end,
	},

	-- ==========================================================================
	-- UTILITY PLUGINS
	-- ==========================================================================

	-- Automatic bullet points and numbering in lists
	{ "dkarter/bullets.vim", ft = { "markdown", "text" } },

	-- Better search highlighting (automatically clears search highlighting)
	{ "haya14busa/is.vim", keys = { "/", "?" } },

	-- Search for selected text with * in visual mode
	{ "nelstrom/vim-visual-star-search", keys = { "*", "#" } },

	-- Auto-close HTML/XML tags
	{ "alvan/vim-closetag", ft = { "html", "xml", "liquid" } },

	-- Show indentation guides (modern alternative that doesn't use conceal)
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		event = "BufRead",
		config = function()
			require("ibl").setup({
				indent = {
					char = "│",
					tab_char = "│",
				},
				scope = {
					enabled = true,
					show_start = false,
					show_end = false,
					highlight = { "Function", "Label" },
				},
				exclude = {
					filetypes = {
						"help",
						"alpha",
						"dashboard",
						"neo-tree",
						"Trouble",
						"lazy",
						"mason",
						"notify",
						"toggleterm",
					},
				},
			})
		end,
	},

	-- Modern auto-pairs plugin (better than the old auto-pairs)
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = function()
			require("nvim-autopairs").setup({
				check_ts = true,
				ts_config = {
					lua = { "string", "source" },
					javascript = { "string", "template_string" },
					java = false,
				},
				disable_filetype = { "TelescopePrompt", "spectre_panel" },
				fast_wrap = {
					map = "<M-e>",
					chars = { "{", "[", "(", '"', "'" },
					pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], "%s+", ""),
					offset = 0,
					end_key = "$",
					keys = "qwertyuiopzxcvbnmasdfghjkl",
					check_comma = true,
					highlight = "PmenuSel",
					highlight_grey = "LineNr",
				},
			})

			-- Add support for Liquid files
			local Rule = require("nvim-autopairs.rule")
			local npairs = require("nvim-autopairs")
			local cond = require("nvim-autopairs.conds")

			-- Add Liquid tag pairs
			npairs.add_rules({
				Rule("{%", "%}", "liquid"),
				Rule("{{", "}}", "liquid"),
				Rule("{%-", "-%}", "liquid"),
				Rule("{{-", "-}}", "liquid"),
			})

			-- Also add these rules for HTML files that might contain Liquid
			npairs.add_rules({
				Rule("{%", "%}", "html"),
				Rule("{{", "}}", "html"),
				Rule("{%-", "-%}", "html"),
				Rule("{{-", "-}}", "html"),
			})
		end,
	},

	-- Align text (e.g., align = signs in multiple lines)
	{ "godlygeek/tabular", cmd = "Tabularize" },

	-- Fast navigation with <leader><leader>w, <leader><leader>f, etc.
	{ "easymotion/vim-easymotion", keys = { "<leader><leader>" } },

	-- Distraction-free writing mode
	{ "junegunn/goyo.vim", cmd = "Goyo" },

	-- HTML/CSS snippet expansion (e.g., html:5<C-y>, expands to HTML5 template)
	{ "mattn/emmet-vim", ft = { "html", "css", "xml" } },

	-- Vim practice game
	{ "ThePrimeagen/vim-be-good", cmd = "VimBeGood" },

	-- ==========================================================================
	-- ICONS AND UI ENHANCEMENTS
	-- ==========================================================================

	-- File type icons for various plugins (updated package)
	{ "nvim-tree/nvim-web-devicons", lazy = true },

	-- Plenary: Required by many plugins
	{ "nvim-lua/plenary.nvim", lazy = true },

	-- UI components library
	{ "MunifTanjim/nui.nvim", lazy = true },
}, {
	-- ==========================================================================
	-- LAZY.NVIM CONFIGURATION
	-- ==========================================================================
	ui = {
		border = "rounded", -- Use rounded borders for plugin manager UI
		size = {
			width = 0.8, -- 80% of screen width
			height = 0.8, -- 80% of screen height
		},
	},
	rocks = {
		enabled = false, -- Disable luarocks support (no plugins need it)
	},
	performance = {
		rtp = {
			-- Disable some built-in plugins we don't need for better performance
			disabled_plugins = {
				"gzip",
				"matchit",
				"matchparen",
				-- "netrwPlugin",  -- Re-enable for file explorer
				"tarPlugin",
				"tohtml",
				"tutor",
				"zipPlugin",
			},
		},
	},
})

-- =============================================================================
-- POST-SETUP PLUGIN CONFIGURATIONS
-- =============================================================================
-- Additional configuration for plugins that need global variables

-- EASYMOTION CONFIGURATION
-- Enable smart case matching (case insensitive unless uppercase is used)
vim.g.EasyMotion_smartcase = 1

-- CLOSETAG CONFIGURATION
-- Define which file types should have auto-closing tags
vim.g.closetag_filenames = "*.html,*.xhtml,*.phtml,*.liquid"

-- AUTO-PAIRS CONFIGURATION - Plugin removed due to conflicts

-- JSON AND MARKDOWN DISPLAY
-- Disable ALL concealing in JSON files (show quotes, brackets, everything)
vim.g.vim_json_syntax_conceal = 0
vim.g.vim_json_conceal = 0
-- Disable concealing of Markdown syntax (show actual asterisks, etc.)
vim.g.vim_markdown_conceal = 0
vim.g.vim_markdown_syntax_conceal = 0
vim.g.markdown_syntax_conceal = 0

-- LIQUID TEMPLATE CONFIGURATION will be handled by the auto-pairs plugin itself
-- when it loads the liquid file type

-- =============================================================================
-- PLUGIN MANAGEMENT COMMANDS
-- =============================================================================
--[[
Useful lazy.nvim commands:
:Lazy                 - Open lazy.nvim UI
:Lazy install         - Install missing plugins
:Lazy update          - Update all plugins
:Lazy sync            - Install missing and update all plugins
:Lazy clean           - Remove unused plugins
:Lazy check           - Check for plugin updates
:Lazy log             - Show plugin update log
:Lazy restore         - Restore plugins to lockfile state
:Lazy profile         - Show startup time breakdown
--]]
