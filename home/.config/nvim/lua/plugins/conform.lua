-- ================================================================================================
-- TITLE : conform.nvim
-- ABOUT : Format on save with formatter auto-detection based on project config files
--         Priority: oxfmt → biome → prettierd → LSP fallback
-- LINKS :
--   > github : https://github.com/stevearc/conform.nvim
-- ================================================================================================

-- Toggle format on save globally or per buffer --
vim.api.nvim_create_user_command("ConformDisable", function(args)
	if args.bang then
		vim.b.disable_autoformat = true -- disable for current buffer only
	else
		vim.g.disable_autoformat = true -- disable globally
	end
end, { desc = "Disable format on save", bang = true })

vim.api.nvim_create_user_command("ConformEnable", function()
	vim.b.disable_autoformat = false
	vim.g.disable_autoformat = false
end, { desc = "Enable format on save" })

return {
	{
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		keys = {
			{
				"<leader>lf",
				function()
					require("conform").format({ async = true, lsp_format = "fallback" })
				end,
				mode = { "n", "v" },
				desc = "Format buffer",
			},
		},
		opts = {
			notify_on_error = false,

			-- Format after save — async, non-blocking
			-- Respects ConformDisable toggle
			format_after_save = function(bufnr)
				if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
					return
				end
				return {
					async = true,
					timeout_ms = 3000,
					lsp_format = "fallback",
				}
			end,

			-- Formatters by filetype --
			-- Priority: oxfmt → biome → prettierd → LSP fallback
			-- Each formatter only runs if its config file is found in the project
			-- stop_after_first = true — use the first available formatter
			formatters_by_ft = {
				-- TypeScript / JavaScript
				javascript = { "oxfmt", "biome", "prettierd", stop_after_first = true },
				javascriptreact = { "oxfmt", "biome", "prettierd", stop_after_first = true },
				typescript = { "oxfmt", "biome", "prettierd", stop_after_first = true },
				typescriptreact = { "oxfmt", "biome", "prettierd", stop_after_first = true },
				-- Web
				css = { "oxfmt", "prettierd", stop_after_first = true },
				html = { "prettierd" },
				scss = { "prettierd" },
				-- Data
				json = { "oxfmt", "biome", "prettierd", stop_after_first = true },
				jsonc = { "oxfmt", "biome", "prettierd", stop_after_first = true },
				yaml = { "prettierd" },
				-- Docs
				markdown = { "prettierd" },
				-- Python
				python = { "ruff_format" },
				-- Lua
				lua = { "stylua" },
				-- Shell
				bash = { "shfmt" },
				sh = { "shfmt" },
			},

			-- Formatter conditions --
			-- Each formatter checks for its config file before running
			-- Searches upward from current file to home directory
			formatters = {
				oxfmt = {
					-- Run only if oxfmt is installed in node_modules
					condition = function(_, ctx)
						return vim.fs.find({ ".oxfmtrc.json", ".oxfmtrc.jsonc" }, {
							path = ctx.filename,
							upward = true,
							stop = vim.uv.os_homedir(),
						})[1] ~= nil
					end,
				},
				biome = {
					-- Run only if biome.json exists in the project
					condition = function(_, ctx)
						return vim.fs.find({ "biome.json", "biome.jsonc" }, {
							path = ctx.filename,
							upward = true,
							stop = vim.uv.os_homedir(),
						})[1] ~= nil
					end,
				},
				-- prettierd = {
				--   -- Run only if a prettierd config exists in the project
				--   condition = function(_, ctx)
				--     return vim.fs.find({
				--       ".prettierdrc",
				--       ".prettierdrc.json",
				--       ".prettierdrc.js",
				--       ".prettierdrc.cjs",
				--       ".prettierdrc.mjs",
				--       ".prettierdrc.yaml",
				--       ".prettierdrc.yml",
				--       "prettierd.config.js",
				--       "prettierd.config.cjs",
				--       "prettierd.config.mjs",
				--     }, {
				--       path  = ctx.filename,
				--       upward = true,
				--       stop  = vim.uv.os_homedir(),
				--     })[1] ~= nil
				--   end,
				-- },
			},
		},
	},
}
