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
    "--filter=blob:none",                              -- Faster clone (no file history)
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",                                 -- Use stable release branch
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
  { "tpope/vim-fugitive", event = "VeryLazy" },

  -- ==========================================================================
  -- COLORSCHEME AND APPEARANCE
  -- ==========================================================================
  
  {
    "dracula/vim",
    name = "dracula",
    priority = 1000,  -- Load early since it's our colorscheme
    config = function()
      -- Use the Dracula Pro colorscheme we installed
      vim.cmd("colorscheme dracula_pro")
    end,
  },

  -- ==========================================================================
  -- STATUSLINE AND UI
  -- ==========================================================================

  {
    "vim-airline/vim-airline",
    lazy = false,  -- Load immediately, not lazily
    priority = 1000,  -- Load early
    dependencies = {
      "vim-airline/vim-airline-themes",  -- Provides color themes for airline
      "powerline/powerline-fonts",       -- Special fonts with icons
      "ryanoasis/vim-devicons",          -- File type icons
    },
    init = function()
      -- Set variables before plugin loads
      vim.g.airline_powerline_fonts = 1
      
      -- Enable buffer/tab line at the top
      vim.g["airline#extensions#tabline#enabled"] = 1
      vim.g["airline#extensions#tabline#fnamemod"] = ':t'
      vim.g["airline#extensions#tabline#formatter"] = 'unique_tail_improved'
      
      -- Enable git branch extension
      vim.g["airline#extensions#branch#enabled"] = 1
      vim.g["airline#extensions#hunks#enabled"] = 1
      
      -- Disable tmuxline integration
      vim.g["airline#extensions#tmuxline#enabled"] = 1
    end,
    config = function()
      -- Configure after plugin loads
      vim.defer_fn(function()
        -- Set theme after plugin loads to avoid conflicts
        vim.g.airline_theme = 'dracula_pro'
        
        -- Initialize airline symbols table
        if not vim.g.airline_symbols then
          vim.g.airline_symbols = {}
        end
        
        -- Configure powerline symbols
        vim.g.airline_left_sep                     = ''
        vim.g.airline_left_alt_sep                 = ''
        vim.g.airline_right_sep                    = ''
        vim.g.airline_right_alt_sep                = ''
        vim.g.airline_symbols.branch               = ''
        vim.g.airline_symbols.readonly             = ''
        vim.g.airline_symbols.linenr               = ''
        vim.g.airline_symbols.whitespace           = 'Ξ'
        
        -- Tab separators - using the angled separators you want
        vim.g["airline#extensions#tabline#left_sep"] = ''
        vim.g["airline#extensions#tabline#left_alt_sep"] = ''
        vim.g["airline#extensions#tabline#right_sep"] = ''
        vim.g["airline#extensions#tabline#right_alt_sep"] = ''
        
        -- Refresh airline to apply changes
        vim.cmd('AirlineRefresh')
      end, 100)
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
      -- Custom Rg command that excludes filenames from search results
      -- This makes text search cleaner by showing only file content matches
      vim.cmd([[
        command! -bang -nargs=* Rg call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case ".shellescape(<q-args>), 1, {'options': '--delimiter : --nth 4..'}, <bang>0)
        command! -bang -nargs=? -complete=dir Files call fzf#vim#files(<q-args>, fzf#vim#with_preview({'options': ['--layout=reverse', '--info=inline']}), <bang>0)
      ]])
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
    build = ":TSUpdate",  -- Update parsers after installation
    config = function()
      require("nvim-treesitter.configs").setup({
        -- Languages to install parsers for
        ensure_installed = { 
          "javascript", "typescript", "html", "css", "lua", 
          "vim", "json", "markdown", "bash", "liquid"
        },
        -- Additional parser configurations
        liquid = {
          install_info = {
            url = "https://github.com/Shopify/tree-sitter-liquid",
            files = { "src/parser.c" },
            branch = "main",
          },
        },
        highlight = { 
          enable = true,    -- Enable treesitter highlighting
          additional_vim_regex_highlighting = { "json" },  -- Use additional highlighting for JSON
        },
        indent = { enable = true },  -- Enable treesitter-based indentation
      })
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
    ft = { "javascript", "typescript", "css", "html", "json", "liquid" },
    keys = {
      { "<leader>p", ":Prettier<CR>", desc = "Format document with Prettier" }
    }
  },

  -- ==========================================================================
  -- LANGUAGE-SPECIFIC SYNTAX HIGHLIGHTING
  -- ==========================================================================

  -- Show colors inline for CSS hex codes (#ff0000 shows as red background)
  { "ap/vim-css-color", ft = { "css", "scss", "sass", "html" } },

  -- Shopify Liquid templating language
  { 
    "tpope/vim-liquid", 
    ft = "liquid",
    config = function()
      -- Ensure Liquid syntax highlighting works optimally
      vim.g.liquid_highlight_all = 1
      -- Set Liquid filetype for .liquid files
      vim.g.liquid_default_subtype = 'html'
    end
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

  -- Show indentation guides
  { "Yggdroot/indentLine", event = "BufRead" },

  -- Auto-close brackets, quotes, etc.
  { "jiangmiao/auto-pairs", event = "InsertEnter" },

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

  -- File type icons for various plugins
  { "kyazdani42/nvim-web-devicons", lazy = true },

}, {
  -- ==========================================================================
  -- LAZY.NVIM CONFIGURATION
  -- ==========================================================================
  ui = {
    border = "rounded",  -- Use rounded borders for plugin manager UI
    size = {
      width = 0.8,       -- 80% of screen width
      height = 0.8,      -- 80% of screen height
    },
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
vim.g.closetag_filenames = '*.html,*.xhtml,*.phtml,*.liquid'

-- AUTO-PAIRS CONFIGURATION
-- Disable fly mode (auto-completion while typing)
vim.g.AutoPairsFlyMode = 0
-- Set shortcut for jumping back to previous auto-pair
vim.g.AutoPairsShortcutBackInsert = '<M-b>'

-- JSON AND MARKDOWN DISPLAY
-- Disable concealing of JSON syntax (show actual quotes, brackets)
vim.g.vim_json_conceal = 0
-- Disable concealing of Markdown syntax (show actual asterisks, etc.)
vim.g.markdown_syntax_conceal = 0

-- INDENTLINE CONFIGURATION
-- Use different characters for different indentation levels
vim.g.indentLine_char_list = {'|', '¦', '┆', '┊'}

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
