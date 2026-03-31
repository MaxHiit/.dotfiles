-- ================================================================================================
-- TITLE : html — HTML Language Server
-- INSTALL :
--   Mac  : npm install -g vscode-langservers-extracted
--   Arch : npm install -g vscode-langservers-extracted
-- LINKS :
--   > lspconfig : https://github.com/neovim/nvim-lspconfig/blob/master/lsp/html.lua
--   > github    : https://github.com/hrsh7th/vscode-langservers-extracted
-- ================================================================================================

---@type vim.lsp.Config
return {
	cmd = { "vscode-html-language-server", "--stdio" },
	filetypes = { "html" },
	root_markers = { "package.json", ".git" },
	settings = {},
	init_options = {
		provideFormatter = true,
		embeddedLanguages = { css = true, javascript = true },
		configurationSection = { "html", "css", "javascript" },
	},
}
