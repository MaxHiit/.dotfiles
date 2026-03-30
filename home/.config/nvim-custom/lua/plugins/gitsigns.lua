-- ================================================================================================
-- TITLE : gitsigns.nvim
-- ABOUT : Git signs in the gutter — stage hunks, blame, diff directly from the buffer
-- LINKS :
--   > github : https://github.com/lewis6991/gitsigns.nvim
-- ================================================================================================

local icons = require("config.icons")

return {
	{
		"lewis6991/gitsigns.nvim",
		event = { "BufReadPost", "BufNewFile" },
		opts = {
			-- Signs for unstaged changes
			signs = {
				add = { text = icons.misc.vertical_bar },
				change = { text = icons.misc.vertical_bar },
				delete = { text = icons.misc.vertical_bar },
				topdelete = { text = icons.misc.vertical_bar },
				changedelete = { text = icons.misc.vertical_bar },
				untracked = { text = icons.misc.vertical_bar },
			},

			-- Signs for staged changes — visually distinct from unstaged
			signs_staged = {
				add = { text = icons.misc.dashed_bar },
				change = { text = icons.misc.dashed_bar },
				delete = { text = icons.misc.dashed_bar },
				topdelete = { text = icons.misc.dashed_bar },
				changedelete = { text = icons.misc.dashed_bar },
			},

			on_attach = function(buffer)
				local gs = package.loaded.gitsigns

				local function map(mode, l, r, desc)
					vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc, silent = true })
				end

				-- Navigation --
				-- Diff-aware: use vim native ]c/[c when in diff mode, gitsigns otherwise
				map("n", "]h", function()
					if vim.wo.diff then
						vim.cmd.normal({ "]c", bang = true })
					else
						gs.nav_hunk("next")
					end
				end, "Git: next hunk")

				map("n", "[h", function()
					if vim.wo.diff then
						vim.cmd.normal({ "[c", bang = true })
					else
						gs.nav_hunk("prev")
					end
				end, "Git: previous hunk")

				map("n", "]H", function()
					gs.nav_hunk("last")
				end, "Git: last hunk")
				map("n", "[H", function()
					gs.nav_hunk("first")
				end, "Git: first hunk")

				-- Hunks --
				map({ "n", "x" }, "<leader>ghs", ":Gitsigns stage_hunk<CR>", "Git: stage hunk")
				map({ "n", "x" }, "<leader>ghr", ":Gitsigns reset_hunk<CR>", "Git: reset hunk")
				map("n", "<leader>ghS", gs.stage_buffer, "Git: stage buffer")
				map("n", "<leader>ghu", gs.undo_stage_hunk, "Git: undo stage hunk")
				map("n", "<leader>ghR", gs.reset_buffer, "Git: reset buffer")
				map("n", "<leader>ghp", gs.preview_hunk_inline, "Git: preview hunk inline")

				-- Blame --
				map("n", "<leader>ghb", function()
					gs.blame_line({ full = true })
				end, "Git: blame line")
				map("n", "<leader>ghB", function()
					gs.blame()
				end, "Git: blame buffer")

				-- Diff --
				map("n", "<leader>ghd", gs.diffthis, "Git: diff this")
				map("n", "<leader>ghD", function()
					gs.diffthis("~")
				end, "Git: diff this ~")

				-- Text object — select hunk in visual/operator mode
				map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "Git: select hunk")
			end,
		},
	},
}
