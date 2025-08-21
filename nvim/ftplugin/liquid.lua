-- =============================================================================
-- LIQUID FILETYPE PLUGIN
-- =============================================================================
-- This file contains settings specific to Liquid template files
-- It loads automatically when a Liquid file is opened

-- Load JSON syntax for schema blocks
vim.cmd('runtime! syntax/json.vim')

-- Force load our custom syntax overrides
vim.cmd('runtime! after/syntax/liquid.vim')

-- =============================================================================
-- INDENTATION AND FORMATTING
-- =============================================================================
-- Set appropriate indentation for HTML/Liquid templates
vim.bo.shiftwidth = 2
vim.bo.tabstop = 2
vim.bo.softtabstop = 2
vim.bo.expandtab = true

-- Enable automatic indentation
vim.bo.autoindent = true
vim.bo.smartindent = true

-- =============================================================================
-- TEXT WIDTH AND WRAPPING
-- =============================================================================
-- Disable text wrapping for better template editing
vim.wo.wrap = false
vim.wo.linebreak = false

-- =============================================================================
-- MATCHING AND NAVIGATION
-- =============================================================================
-- Enable matchit plugin for % navigation between Liquid tags
vim.b.match_words = table.concat({
  '{% if %}:{% elsif %}:{% else %}:{% endif %}',
  '{% for %}:{% else %}:{% endfor %}',
  '{% case %}:{% when %}:{% else %}:{% endcase %}',
  '{% unless %}:{% else %}:{% endunless %}',
  '{% capture %}:{% endcapture %}',
  '{% comment %}:{% endcomment %}',
  '{% raw %}:{% endraw %}',
  '{% block %}:{% endblock %}',
  '{% tablerow %}:{% endtablerow %}',
  '{% paginate %}:{% endpaginate %}',
  '{% form %}:{% endform %}',
  '{% doc %}:{% enddoc %}',  -- Liquid documentation blocks
  '<:>',  -- HTML tags
}, ',')

-- =============================================================================
-- FOLDING
-- =============================================================================
-- Enable folding for Liquid blocks
vim.wo.foldmethod = 'expr'
vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
vim.wo.foldlevel = 99  -- Start with all folds open

-- =============================================================================
-- COMMENTS
-- =============================================================================
-- Set comment string for Liquid
vim.bo.commentstring = '{% comment %} %s {% endcomment %}'

-- For single-line comments in Liquid (using vim-commentary)
vim.b.commentary_format = '{% comment %} %s {% endcomment %}'

-- =============================================================================
-- COMPLETION
-- =============================================================================
-- Enable omni-completion for Liquid
vim.bo.omnifunc = 'v:lua.vim.lsp.omnifunc'

-- Add Liquid-specific keywords to completion
vim.bo.iskeyword = vim.bo.iskeyword .. ',-'  -- Include hyphen in keywords

-- Configure completion behavior for Liquid files
vim.opt_local.completeopt = 'menu,menuone,noselect'

-- Set up automatic completion triggers for Liquid
vim.api.nvim_create_autocmd("InsertCharPre", {
  buffer = 0,
  callback = function()
    local char = vim.v.char
    local line = vim.api.nvim_get_current_line()
    local col = vim.api.nvim_win_get_cursor(0)[2]
    
    -- Trigger completion after specific Liquid patterns
    if char == ' ' then
      local before_cursor = line:sub(1, col)
      -- Trigger after '{{', '{%', or filter pipe '|'
      if before_cursor:match('{{%s*$') or 
         before_cursor:match('{%%%s*$') or
         before_cursor:match('|%s*$') then
        vim.defer_fn(function()
          -- Check if cmp is available
          local ok, cmp = pcall(require, 'cmp')
          if ok then
            cmp.complete()
          else
            -- Fallback to built-in completion
            vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<C-x><C-o>', true, false, true), 'n', false)
          end
        end, 100)
      end
    elseif char == '|' then
      -- Trigger completion when typing filter pipe
      vim.defer_fn(function()
        local ok, cmp = pcall(require, 'cmp')
        if ok then
          cmp.complete()
        end
      end, 100)
    end
  end,
  desc = "Auto-trigger completion for Liquid patterns"
})

-- =============================================================================
-- SNIPPETS AND ABBREVIATIONS
-- =============================================================================
-- Define common Liquid snippets as abbreviations
local liquid_abbrevs = {
  ['lif'] = '{% if %} {% endif %}',
  ['lfor'] = '{% for item in collection %} {% endfor %}',
  ['lcase'] = '{% case variable %} {% when value %} {% endcase %}',
  ['lassign'] = '{% assign variable = value %}',
  ['lcapture'] = '{% capture variable %} {% endcapture %}',
  ['lcomment'] = '{% comment %} {% endcomment %}',
  ['lraw'] = '{% raw %} {% endraw %}',
  ['linclude'] = "{% include 'snippet-name' %}",
  ['lrender'] = "{% render 'snippet-name' %}",
  ['lsection'] = "{% section 'section-name' %}",
  ['lschema'] = '{% schema %} { } {% endschema %}',
  ['lpaginate'] = '{% paginate collection.products by 12 %} {% endpaginate %}',
  ['lform'] = "{% form 'form-type' %} {% endform %}",
  ['ltrans'] = "{{ 'translation.key' <Bar> t }}",
  ['lfilter'] = '{{ variable <Bar> filter }}',
  ['llink'] = "{{ 'text' <Bar> link_to: url }}",
  ['limg'] = "{{ image <Bar> img_url: 'master' <Bar> img_tag }}",
  ['lasset'] = "{{ 'asset.css' <Bar> asset_url <Bar> stylesheet_tag }}",
  ['lscript'] = "{{ 'script.js' <Bar> asset_url <Bar> script_tag }}",
  ['ldoc'] = '{% doc %} @param {type} name - description {% enddoc %}',
}

-- Register abbreviations
for abbrev, expansion in pairs(liquid_abbrevs) do
  vim.cmd.iabbrev({ args = { '<buffer>', abbrev, expansion } })
end

-- =============================================================================
-- SYNTAX SPECIFIC SETTINGS
-- =============================================================================
-- Enable spell checking in comments and strings
vim.wo.spell = false  -- Can be enabled if desired

-- Highlight matching brackets
vim.o.showmatch = true

-- =============================================================================
-- LOCAL KEYBINDINGS
-- =============================================================================
-- Buffer-local keybindings for Liquid files

-- Quick insert Liquid output tags
vim.keymap.set('i', '{{', '{{ }}<Left><Left><Left>', { buffer = true })
vim.keymap.set('i', '{%', '{% %}<Left><Left><Left>', { buffer = true })
vim.keymap.set('i', '{#', '{# #}<Left><Left><Left>', { buffer = true })  -- For Twig-style comments

-- Navigate between Liquid blocks
vim.keymap.set('n', ']]', '/{% \\(if\\|for\\|case\\|capture\\|unless\\|block\\)<CR>', { buffer = true, silent = true })
vim.keymap.set('n', '[[', '?{% \\(if\\|for\\|case\\|capture\\|unless\\|block\\)<CR>', { buffer = true, silent = true })
vim.keymap.set('n', '][', '/{% end\\(if\\|for\\|case\\|capture\\|unless\\|block\\) %}<CR>', { buffer = true, silent = true })
vim.keymap.set('n', '[]', '?{% end\\(if\\|for\\|case\\|capture\\|unless\\|block\\) %}<CR>', { buffer = true, silent = true })

-- Quick access to theme check commands (defined in liquid-lsp.lua)
-- <leader>tc - Run Theme Checks
-- <leader>td - Find Dead Code
-- <leader>tr - Restart Theme Check Server

-- =============================================================================
-- AUTOMATIC COMMANDS
-- =============================================================================
-- Auto-format on save (if LSP is attached)
vim.api.nvim_create_autocmd('BufWritePre', {
  buffer = 0,
  callback = function()
    -- Only format if LSP client is attached
    local clients = vim.lsp.get_active_clients({ bufnr = 0 })
    for _, client in ipairs(clients) do
      if client.name == 'theme_check' and client.server_capabilities.documentFormattingProvider then
        vim.lsp.buf.format({ async = false, timeout_ms = 2000 })
        break
      end
    end
  end,
  desc = 'Format Liquid file on save if LSP is available'
})

-- =============================================================================
-- LIQUID-SPECIFIC FUNCTIONS
-- =============================================================================
-- Function to wrap selection in Liquid tags
function _G.wrap_in_liquid_tag(tag_type)
  local start_line, start_col = unpack(vim.api.nvim_buf_get_mark(0, '<'))
  local end_line, end_col = unpack(vim.api.nvim_buf_get_mark(0, '>'))
  
  local lines = vim.api.nvim_buf_get_lines(0, start_line - 1, end_line, false)
  
  if tag_type == 'if' then
    table.insert(lines, 1, '{% if condition %}')
    table.insert(lines, '{% endif %}')
  elseif tag_type == 'for' then
    table.insert(lines, 1, '{% for item in collection %}')
    table.insert(lines, '{% endfor %}')
  elseif tag_type == 'comment' then
    table.insert(lines, 1, '{% comment %}')
    table.insert(lines, '{% endcomment %}')
  elseif tag_type == 'capture' then
    table.insert(lines, 1, '{% capture variable %}')
    table.insert(lines, '{% endcapture %}')
  elseif tag_type == 'raw' then
    table.insert(lines, 1, '{% raw %}')
    table.insert(lines, '{% endraw %}')
  elseif tag_type == 'doc' then
    table.insert(lines, 1, '{% doc %}')
    table.insert(lines, '  @param {type} name - description')
    table.insert(lines, '{% enddoc %}')
  end
  
  vim.api.nvim_buf_set_lines(0, start_line - 1, end_line, false, lines)
end

-- Visual mode mappings to wrap selections
vim.keymap.set('v', '<leader>li', ':lua wrap_in_liquid_tag("if")<CR>', { buffer = true, desc = 'Wrap in if block' })
vim.keymap.set('v', '<leader>lf', ':lua wrap_in_liquid_tag("for")<CR>', { buffer = true, desc = 'Wrap in for block' })
vim.keymap.set('v', '<leader>lc', ':lua wrap_in_liquid_tag("comment")<CR>', { buffer = true, desc = 'Wrap in comment block' })
vim.keymap.set('v', '<leader>lr', ':lua wrap_in_liquid_tag("raw")<CR>', { buffer = true, desc = 'Wrap in raw block' })
vim.keymap.set('v', '<leader>lp', ':lua wrap_in_liquid_tag("capture")<CR>', { buffer = true, desc = 'Wrap in capture block' })
vim.keymap.set('v', '<leader>ld', ':lua wrap_in_liquid_tag("doc")<CR>', { buffer = true, desc = 'Wrap in doc block' })

-- =============================================================================
-- STATUS LINE INDICATOR
-- =============================================================================
-- Add Liquid indicator to status line when in Liquid files
vim.b.airline_section_y = 'Liquid'

-- Silent notification that Liquid support is loaded (only show once per session)
if not _G.liquid_loaded_notified then
  _G.liquid_loaded_notified = true
  -- Optionally show a brief notification (commented out to avoid spam)
  -- vim.notify("Liquid LSP ready", vim.log.levels.INFO, { title = "Liquid", timeout = 1000 })
end