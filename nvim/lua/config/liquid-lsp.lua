-- =============================================================================
-- SHOPIFY LIQUID LSP CONFIGURATION
-- =============================================================================
-- This module configures the Shopify Theme Language Server for Liquid files
-- Provides full LSP support including completions, diagnostics, formatting, etc.

local M = {}

function M.setup()
  local lspconfig = require("lspconfig")
  local configs = require("lspconfig.configs")
  
  -- Check if the server is already defined (to avoid redefinition errors)
  if not configs.theme_check then
    -- Define the Shopify Theme Check Language Server
    configs.theme_check = {
      default_config = {
        cmd = { "theme-language-server", "--stdio" },
        filetypes = { "liquid" },
        root_dir = function(fname)
          -- Look for Shopify theme indicators
          return lspconfig.util.root_pattern(
            ".theme-check.yml",
            ".theme-check.yaml",
            "theme.toml",
            "config.yml",
            "templates",
            "sections",
            "snippets",
            "layout",
            ".git"
          )(fname) or vim.fn.getcwd()
        end,
        settings = {
          themeCheck = {
            checkOnOpen = true,
            checkOnChange = true,
            checkOnSave = true,
            preloadOnBoot = true,
            -- Enable stricter type checking
            typeCheck = true,
            docValidation = true,
          },
          liquidFiles = {
            formatOnSave = true,
            enableDocumentationComments = true,
          },
          -- Enable experimental features for better type checking
          experimental = {
            typeChecking = true,
            parameterValidation = true,
          },
        },
        init_options = {
          documentFormatting = true,
          documentRangeFormatting = true,
          completionItems = true,
          diagnostics = true,
          documentHighlight = true,
          documentSymbols = true,
          foldingRanges = true,
          selectionRanges = true,
          hover = true,
          codeActions = true,
        },
      },
    }
  end
  
  -- Common on_attach function for LSP keybindings
  local function on_attach(client, bufnr)
    local opts = { buffer = bufnr, silent = true }
    
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
    
    -- Liquid-specific keybindings
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
    vim.keymap.set("n", "<leader>cf", function()
      vim.lsp.buf.format({ async = true })
    end, opts)
    
    -- Theme Check specific commands
    vim.keymap.set("n", "<leader>tc", function()
      vim.lsp.buf.execute_command({
        command = "themeCheck/runChecks",
      })
    end, { buffer = bufnr, desc = "Run Theme Checks" })
    
    vim.keymap.set("n", "<leader>td", function()
      -- Request dead code analysis
      local params = {
        command = "themeCheck/deadCode",
        arguments = { vim.uri_from_bufnr(bufnr) },
      }
      vim.lsp.buf.execute_command(params)
    end, { buffer = bufnr, desc = "Find Dead Code" })
    
    vim.keymap.set("n", "<leader>tr", function()
      -- Restart the language server
      vim.cmd("LspRestart theme_check")
    end, { buffer = bufnr, desc = "Restart Theme Check Server" })
    
    -- Enable document highlighting if supported
    if client.server_capabilities.documentHighlightProvider then
      vim.api.nvim_create_augroup("lsp_document_highlight", { clear = false })
      vim.api.nvim_clear_autocmds({ buffer = bufnr, group = "lsp_document_highlight" })
      vim.api.nvim_create_autocmd("CursorHold", {
        callback = vim.lsp.buf.document_highlight,
        buffer = bufnr,
        group = "lsp_document_highlight",
        desc = "Document Highlight",
      })
      vim.api.nvim_create_autocmd("CursorMoved", {
        callback = vim.lsp.buf.clear_references,
        buffer = bufnr,
        group = "lsp_document_highlight",
        desc = "Clear All the References",
      })
    end
    
    -- Show diagnostics in a floating window on hover
    vim.api.nvim_create_autocmd("CursorHold", {
      buffer = bufnr,
      callback = function()
        local opts = {
          focusable = false,
          close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
          border = "rounded",
          source = "always",
          prefix = " ",
          scope = "cursor",
        }
        vim.diagnostic.open_float(nil, opts)
      end,
    })
  end
  
  -- Common capabilities
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  
  -- Enable snippet support
  capabilities.textDocument.completion.completionItem.snippetSupport = true
  capabilities.textDocument.completion.completionItem.resolveSupport = {
    properties = {
      "documentation",
      "detail",
      "additionalTextEdits",
    },
  }
  
  -- Add nvim-cmp capabilities if available
  local ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
  if ok then
    capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
  end
  
  -- Setup the Theme Check Language Server
  lspconfig.theme_check.setup({
    on_attach = on_attach,
    capabilities = capabilities,
    flags = {
      debounce_text_changes = 150,
    },
  })
  
  -- Create user commands for Theme Check operations
  vim.api.nvim_create_user_command("ThemeCheck", function()
    vim.lsp.buf.execute_command({
      command = "themeCheck/runChecks",
    })
  end, { desc = "Run Shopify Theme Checks" })
  
  vim.api.nvim_create_user_command("ThemeCheckDeadCode", function()
    local bufnr = vim.api.nvim_get_current_buf()
    vim.lsp.buf.execute_command({
      command = "themeCheck/deadCode",
      arguments = { vim.uri_from_bufnr(bufnr) },
    })
  end, { desc = "Find dead code in theme" })
  
  -- Configure diagnostics display for Liquid files
  vim.api.nvim_create_autocmd("FileType", {
    pattern = "liquid",
    callback = function()
      vim.diagnostic.config({
        virtual_text = {
          prefix = "●",
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
    end,
  })
end

return M