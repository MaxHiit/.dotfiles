-- ================================================================================================
-- TITLE : lua_ls — Lua Language Server
-- INSTALL :
--   Mac  : brew install lua-language-server
--   Arch : sudo pacman -S lua-language-server
-- LINKS :
--   > lspconfig : https://github.com/neovim/nvim-lspconfig/blob/master/lsp/lua_ls.lua
--   > github    : https://github.com/LuaLS/lua-language-server
-- ================================================================================================

---@type vim.lsp.Config
return {
	cmd = { "lua-language-server" },
	settings = {
		Lua = {
			runtime = {
				version = "LuaJIT",
			},
			workspace = {
				checkThirdParty = false,
				library = {
					vim.fn.expand("$VIMRUNTIME/lua"),
					vim.fn.stdpath("config") .. "/lua",
				},
			},
			diagnostics = {
				globals = { "vim" },
			},
			hint = {
				enable = true,
				semicolon = "Disable",
			},
			codeLens = {
				enable = true,
			},
			telemetry = {
				enable = false,
			},
		},
	},
}
