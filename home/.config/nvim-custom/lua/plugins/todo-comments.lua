-- ================================================================================================
-- TITLE : todo-comments.nvim
-- ABOUT : Highlight and search TODO, FIXME, HACK, NOTE, BUG comments in code
-- LINKS :
--   > github : https://github.com/folke/todo-comments.nvim
-- ================================================================================================

return {
	{
		"folke/todo-comments.nvim",
		cmd = { "TodoTrouble", "TodoTelescope" },
		event = { "BufReadPost", "BufNewFile" },
		opts = {},
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
