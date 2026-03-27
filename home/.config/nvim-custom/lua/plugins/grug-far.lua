-- ================================================================================================
-- TITLE : grug-far.nvim
-- ABOUT : Find and replace across project files — modern alternative to spectre
--         Supports regex, file filters, and works in visual selection
-- LINKS :
--   > github : https://github.com/MagicDuck/grug-far.nvim
-- ================================================================================================

return {
	{
		"MagicDuck/grug-far.nvim",
		cmd = { "GrugFar", "GrugFarWithin" },
		opts = {
			headerMaxWidth = 80,
			engines = {
				ripgrep = {
					-- Search hidden files/dirs (dotfiles) by default
					extraArgs = "--hidden",
				},
			},
		},
		keys = {
			{
				"<leader>S",
				function()
					local grug = require("grug-far")
					local ext = vim.bo.buftype == "" and vim.fn.expand("%:e")
					grug.open({
						transient = true,
						prefills = {
							paths = vim.fn.getcwd(),
							filesFilter = ext and ext ~= "" and ("*." .. ext) or nil,
						},
					})
				end,
				mode = { "n", "x" },
				desc = "Search: find and replace",
			},
		},
	},
}
