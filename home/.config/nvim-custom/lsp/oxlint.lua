-- ================================================================================================
-- TITLE : oxlint — JavaScript/TypeScript Linter
-- INSTALL :
--   Mac  : npm install -g oxlint
--          or dans le projet : npm install --save-dev oxlint
--   Arch : npm install -g oxlint
-- LINKS :
--   > lspconfig : https://github.com/neovim/nvim-lspconfig/blob/master/lsp/oxlint.lua
--   > github    : https://github.com/oxc-project/oxc
-- ================================================================================================

---@type vim.lsp.Config
return {
	-- Use local node_modules binary if available, fallback to global
	cmd = function(dispatchers, config)
		local cmd = "oxlint"
		local local_cmd = (config or {}).root_dir and config.root_dir .. "/node_modules/.bin/oxlint"
		if local_cmd and vim.fn.executable(local_cmd) == 1 then
			cmd = local_cmd
		end
		return vim.lsp.rpc.start({ cmd, "--lsp" }, dispatchers)
	end,
	filetypes = {
		"javascript",
		"javascriptreact",
		"typescript",
		"typescriptreact",
		"vue",
		"svelte",
		"astro",
	},
	root_markers = { ".oxlintrc.json", "oxlint.config.ts" },
	workspace_required = true,
	on_attach = function(client, bufnr)
		-- Command to fix all auto-fixable diagnostics
		vim.api.nvim_buf_create_user_command(bufnr, "LspOxlintFixAll", function()
			client:exec_cmd({
				title = "Apply Oxlint automatic fixes",
				command = "oxc.fixAll",
				arguments = { { uri = vim.uri_from_bufnr(bufnr) } },
			})
		end, { desc = "Apply Oxlint automatic fixes" })
	end,
	before_init = function(init_params, config)
		local settings = config.settings or {}
		local init_options = config.init_options or {}
		init_options.settings = vim.tbl_extend("force", init_options.settings or {} --[[@as table]], settings)
		init_params.initializationOptions = init_options
	end,
}
