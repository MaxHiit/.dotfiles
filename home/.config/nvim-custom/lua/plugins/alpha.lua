-- ================================================================================================
-- TITLE : alpha.nvim
-- ABOUT : Dashboard shown on startup — quick access to common actions
-- LINKS :
--   > github : https://github.com/goolord/alpha-nvim
-- ================================================================================================

return {
	{
		"goolord/alpha-nvim",
		event = "VimEnter",
		config = function()
			local alpha = require("alpha")
			local dashboard = require("alpha.themes.dashboard")

			-- Header --
			dashboard.section.header.val = {
				"                         .^!^                                           .!~:                        ",
				"                    ^!JPB&B!.                                            !&&BPJ!:                   ",
				"                ^?P#@@@@@G.                   :       :                   !@@@@@&BY!:               ",
				"             ^JB@@@@@@@@@7                   .#~     ?P                   .&@@@@@@@@&G?:            ",
				"          .7G@@@@@@@@@@@@#!                  ?@#^   ~@@^                 .5@@@@@@@@@@@@@G7.         ",
				"        .?#@@@@@@@@@@@@@@@@BY!^.             B@@&BBB&@@Y              :~Y&@@@@@@@@@@@@@@@@#?.       ",
				"       !#@@@@@@@@@@@@@@@@@@@@@@#G5Y?!~^:..  !@@@@@@@@@@#.   ..::^!7J5B&@@@@@@@@@@@@@@@@@@@@@B!     ",
				"     .5@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@&&##B#@@@@@@@@@@@BBBB##&@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@Y     ",
				"    :B@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@5    ",
				"   .B@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@?   ",
				"   5@&#BGGPPPPPGGB&@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@&BGGPP5PPPGBB#&. ",
				"   ^:..           .^!YB@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@&57^.            .:^.",
				"                       ~G@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@Y.                    ",
				"                         P@@@#BGGGGB#@@@@@@@@@@@@@@@@@@@@@@@@@#BP5555PG#@@@P                        ",
				"                         :J!:.      .^!JG&@@@@@@@@@@@@@@@@#57^.        .:!5~                        ",
				"                                         :?G@@@@@@@@@@@@P!.                                         ",
				"                                            ~5@@@@@@@@5^                                            ",
				"                                              ^P@@@@G^                                              ",
				"                                                !#@?                                                ",
				"                                                 :^                                                 ",
			}

			dashboard.section.header.opts = {
				position = "center",
				hl = "GruvboxBg4",
			}

			-- Buttons --
			dashboard.section.buttons.val = {
				dashboard.button("e", "  Open explorer", "<Cmd>Oil<CR>"),
				dashboard.button("f", "  Find file", "<Cmd>Telescope find_files<CR>"),
				dashboard.button("r", "  Recent files", "<Cmd>Telescope oldfiles<CR>"),
				dashboard.button("g", "  Live grep", "<Cmd>Telescope live_grep<CR>"),
				dashboard.button("q", "  Quit", "<Cmd>qa<CR>"),
			}

			dashboard.section.buttons.opts = {
				spacing = 1,
				hl = "GruvboxYellow",
			}

			-- Footer --
			dashboard.section.footer.val = ""

			-- Layout --
			alpha.setup({
				layout = {
					{ type = "padding", val = 4 },
					dashboard.section.header,
					{ type = "padding", val = 3 },
					dashboard.section.buttons,
					{ type = "padding", val = 2 },
					dashboard.section.footer,
				},
				opts = { margin = 5 },
			})

			-- Autocmds --
			local group = vim.api.nvim_create_augroup("CleanDashboard", { clear = true })

			vim.api.nvim_create_autocmd("User", {
				group = group,
				pattern = "AlphaReady",
				callback = function()
					vim.opt.showtabline = 0
					vim.opt.showmode = false
					vim.opt.laststatus = 0
					vim.opt.showcmd = false
					vim.opt.ruler = false
				end,
			})

			vim.api.nvim_create_autocmd("BufUnload", {
				group = group,
				callback = function()
					vim.opt.showtabline = 0
					vim.opt.showmode = true
					vim.opt.laststatus = 3
					vim.opt.showcmd = true
					vim.opt.ruler = true
				end,
			})

			vim.api.nvim_create_autocmd("FileType", {
				group = group,
				pattern = "alpha",
				callback = function()
					vim.opt_local.foldenable = false
				end,
			})
		end,
	},
}
