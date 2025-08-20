-- ███╗   ██╗██╗   ██╗██╗███╗   ███╗
-- ████╗  ██║██║   ██║██║████╗ ████║
-- ██╔██╗ ██║██║   ██║██║██╔████╔██║
-- ██║╚██╗██║╚██╗ ██╔╝██║██║╚██╔╝██║
-- ██║ ╚████║ ╚████╔╝ ██║██║ ╚═╝ ██║
-- ╚═╝  ╚═══╝  ╚═══╝  ╚═╝╚═╝     ╚═╝
--
-- Neovim Configuration - Main Entry Point
-- 
-- This is the main configuration file that gets loaded when Neovim starts.
-- It serves as the entry point for the entire configuration and loads
-- all the modular configuration files from the lua/ directory.
--
-- Author: Efe Kurnaz
-- Converted from VimScript to Lua for better performance and maintainability

-- =============================================================================
-- SHELL CONFIGURATION
-- =============================================================================
-- Fix shell compatibility issues with fish shell
-- Fish shell can cause issues with some vim plugins, so we force sh as the shell
-- when fish is detected as the default shell
if vim.o.shell:match('fish$') then
  vim.o.shell = 'sh'
end

-- =============================================================================
-- PROVIDER CONFIGURATION
-- =============================================================================
-- Disable optional providers that we don't use to reduce startup warnings
vim.g.loaded_perl_provider = 0    -- Disable Perl provider
vim.g.loaded_ruby_provider = 0    -- Disable Ruby provider

-- =============================================================================
-- MODULE LOADING
-- =============================================================================
-- Load all configuration modules in the correct order
-- Each module is responsible for a specific aspect of the configuration

-- 1. Load basic vim options and settings (equivalent to the old init.vim settings)
require('options')

-- 2. Load key mappings and shortcuts (equivalent to the old mappings.vim)
require('mappings')

-- 3. Load plugin configuration and management (equivalent to the old plugins.vim)
require('plugins')

-- 4. Load autocommands and file type associations (equivalent to the old functions.vim)
require('autocmds')

-- =============================================================================
-- CONFIGURATION STRUCTURE OVERVIEW
-- =============================================================================
--[[
The configuration is now organized into the following modules:

├── init.lua              (this file - main entry point)
├── lua/
│   ├── options.lua       (vim options, UI settings, editor behavior)
│   ├── mappings.lua      (keybindings and shortcuts)
│   ├── plugins.lua       (plugin management with lazy.nvim)
│   └── autocmds.lua      (autocommands and file type detection)

Benefits of this structure:
- Better organization and maintainability
- Faster startup time with lazy loading
- Native Lua performance
- Easier to debug and modify individual components
- Modern plugin management with lazy.nvim
--]]