-- ================================================================================================
-- TITLE : ts_ls — TypeScript/JavaScript Language Server
-- INSTALL :
--   Mac  : brew install node && npm install -g typescript-language-server typescript
--   Arch : sudo pacman -S nodejs npm && npm install -g typescript-language-server typescript
-- LINKS :
--   > lspconfig : https://github.com/neovim/nvim-lspconfig/blob/master/lsp/ts_ls.lua
--   > github    : https://github.com/typescript-language-server/typescript-language-server
-- ================================================================================================

---@type vim.lsp.Config
return {
	cmd = { "typescript-language-server", "--stdio" },
	filetypes = {
		"javascript",
		"javascriptreact",
		"typescript",
		"typescriptreact",
	},
	settings = {
		typescript = {
			inlayHints = {
				includeInlayParameterNameHints = "all",
				includeInlayParameterNameHintsWhenArgumentMatchesName = false,
				includeInlayFunctionParameterTypeHints = true,
				includeInlayVariableTypeHints = true,
				includeInlayPropertyDeclarationTypeHints = true,
				includeInlayFunctionLikeReturnTypeHints = true,
				includeInlayEnumMemberValueHints = true,
			},
		},
		javascript = {
			inlayHints = {
				includeInlayParameterNameHints = "all",
				includeInlayParameterNameHintsWhenArgumentMatchesName = false,
				includeInlayFunctionParameterTypeHints = true,
				includeInlayVariableTypeHints = true,
				includeInlayPropertyDeclarationTypeHints = true,
				includeInlayFunctionLikeReturnTypeHints = true,
				includeInlayEnumMemberValueHints = true,
			},
		},
	},
	on_attach = function(client)
		-- Disable formatting — handled by conform (oxfmt/biome/prettierd)
		client.server_capabilities.documentFormattingProvider = false
		client.server_capabilities.documentRangeFormattingProvider = false
	end,
}
