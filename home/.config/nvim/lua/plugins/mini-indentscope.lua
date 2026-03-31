-- ================================================================================================
-- TITLE : mini.indentscope
-- ABOUT : Animated indent guides — shows current scope with a vertical line
-- LINKS :
--   > github : https://github.com/echasnovski/mini.indentscope
-- ================================================================================================
return {
	{
		"echasnovski/mini.indentscope",
		version = "*",
		event = { "BufReadPost", "BufNewFile" },
		config = function()
			require("mini.indentscope").setup({
				symbol = "│",
				options = { try_as_border = true },
				draw = {
					delay = 100,
					animation = require("mini.indentscope").gen_animation.none(),
				},
			})

			-- Disable in certain filetypes
			vim.api.nvim_create_autocmd("FileType", {
				pattern = {
					"help",
					"lazy",
					"mason",
					"notify",
					"toggleterm",
					"trouble",
					"oil",
				},
				callback = function()
					vim.b.miniindentscope_disable = true
				end,
			})
		end,
	},
}
