-- ================================================================================================
-- TITLE : todo-comments.nvim
-- ABOUT : Highlight and search TODO, FIXME, HACK, NOTE, BUG comments in code
-- LINKS :
--   > github : https://github.com/folke/todo-comments.nvim
-- ================================================================================================

local icons = require("config.icons")

return {
	{
		"folke/todo-comments.nvim",
		cmd = { "TodoTrouble", "TodoTelescope" },
		event = { "BufReadPost", "BufNewFile" },
		opts = {
			signs = true,
			sign_priority = 8,
			keywords = {
				FIX = { icon = icons.misc.bug, color = "error", alt = { "FIXME", "BUG", "FIXIT", "ISSUE" } },
				TODO = { icon = icons.misc.toolbox, color = "info" },
				HACK = { icon = icons.misc.robot, color = "warning" },
				WARN = { icon = icons.diagnostics.WARN, color = "warning", alt = { "WARNING", "XXX" } },
				NOTE = { icon = icons.misc.palette, color = "hint", alt = { "INFO" } },
				TEST = { icon = icons.misc.search, color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
			},
		},
		keys = {
			{
				"]t",
				function()
					require("todo-comments").jump_next()
				end,
				desc = "Todo: next todo comment",
			},
			{
				"[t",
				function()
					require("todo-comments").jump_prev()
				end,
				desc = "Todo: previous todo comment",
			},
			{ "<leader>st", "<cmd>TodoTelescope<cr>", desc = "Search: Todo" },
			{ "<leader>sT", "<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>", desc = "Search: Todo/Fix/Fixme" },
		},
	},
}
