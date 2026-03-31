-- ================================================================================================
-- TITLE : init.lua
-- ABOUT : Entry point — load order matters here
--         options must load first to set mapleader before lazy.nvim
-- ================================================================================================

-- Core --
require("config.options") -- mapleader + all vim options (must be first)
require("config.autocmds") -- autocommands
require("config.keymaps") -- global keymaps (non-plugin)
require("config.keymaps") -- global keymaps (non-plugin)
require("config.lsp") -- native LSP setup (must load before plugins)

-- Plugins --
require("config.lazy") -- bootstrap lazy.nvim + load all plugins
