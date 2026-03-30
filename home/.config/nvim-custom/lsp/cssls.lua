-- ================================================================================================
-- TITLE : cssls — CSS/SCSS/Less Language Server
-- INSTALL :
--   Mac  : npm install -g vscode-langservers-extracted
--   Arch : npm install -g vscode-langservers-extracted
-- LINKS :
--   > lspconfig : https://github.com/neovim/nvim-lspconfig/blob/master/lsp/cssls.lua
--   > github    : https://github.com/hrsh7th/vscode-langservers-extracted
-- ================================================================================================

---@type vim.lsp.Config
return {
	cmd = { "vscode-css-language-server", "--stdio" },
	filetypes = { "css", "scss", "less" },
	init_options = { provideFormatter = true },
	root_markers = { "package.json", ".git" },
	settings = {
		css = { validate = true },
		scss = { validate = true },
		less = { validate = true },
	},
}
