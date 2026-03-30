-- ================================================================================================
-- TITLE : bashls — Bash Language Server
-- INSTALL :
--   Mac  : npm install -g bash-language-server
--   Arch : sudo pacman -S bash-language-server
--          or : npm install -g bash-language-server
-- LINKS :
--   > lspconfig : https://github.com/neovim/nvim-lspconfig/blob/master/lsp/bashls.lua
--   > github    : https://github.com/bash-lsp/bash-language-server
-- ================================================================================================

---@type vim.lsp.Config
return {
	cmd = { "bash-language-server", "start" },
	filetypes = { "bash", "sh" },
	root_markers = { ".git" },
	settings = {
		bashIde = {
			-- Prevent recursive scanning in home directory
			globPattern = vim.env.GLOB_PATTERN or "*@(.sh|.inc|.bash|.command)",
		},
	},
}
