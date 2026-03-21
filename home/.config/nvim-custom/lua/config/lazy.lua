-- ================================================================================================
-- TITLE : lazy.nvim bootstrap
-- ABOUT : Download and initialize lazy.nvim plugin manager
--         All plugins are loaded from lua/plugins/ — one file per plugin
-- LINKS :
--   > github : https://github.com/folke/lazy.nvim
-- ================================================================================================

-- Bootstrap --
-- Clone lazy.nvim if not already installed
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"--branch=stable",
		lazyrepo,
		lazypath,
	})

	-- Exit with error if clone failed
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end

vim.opt.rtp:prepend(lazypath)

-- Setup --
require("lazy").setup({
	spec = {
		-- Load all plugin files from lua/plugins/
		-- Each file in plugins/ is automatically picked up by lazy
		{ import = "plugins" },
	},

	install = {
		-- Colorscheme used while installing plugins on first launch
		-- Prevents white flash before colorscheme loads
		colorscheme = { "habamax" },
	},

	rtp = {
		-- Disable built-in netrw — replaced by oil.nvim
		disabled_plugins = {
			"netrw",
			"netrwPlugin",
		},
	},

	checker = {
		-- Automatically check for plugin updates in the background
		enabled = true,
		notify = false, -- Don't notify on every check — only when updates are available
	},

	change_detection = {
		-- Detect changes in plugin config files and prompt to reload
		enabled = true,
		notify = false, -- Silent detection — no popup on every save
	},
})
