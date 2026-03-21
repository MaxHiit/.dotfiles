-- ================================================================================================
-- TITLE : init.lua
-- ABOUT : Entry point — load order matters here
--         options must load first to set mapleader before lazy.nvim
-- ================================================================================================

-- Core -- 
require("config.options")   -- mapleader + all vim options (must be first)
require("config.autocmds")  -- autocommands
require("config.keymaps")   -- global keymaps (non-plugin)

-- Plugins --
require("config.lazy")      -- bootstrap lazy.nvim + load all plugins
