-- ================================================================================================
-- TITLE : lua_ls — Lua Language Server
-- INSTALL :
--   Mac  : brew install lua-language-server
--   Arch : sudo pacman -S lua-language-server
-- LINKS :
--   > lspconfig : https://github.com/neovim/nvim-lspconfig/blob/master/lsp/lua_ls.lua
--   > github    : https://github.com/LuaLS/lua-language-server
-- ================================================================================================

local root_markers1 = {
	".emmyrc.json",
	".luarc.json",
	".luarc.jsonc",
}

local root_markers2 = {
	".luacheckrc",
	".stylua.toml",
	"stylua.toml",
	"selene.toml",
	"selene.yml",
}

---@type vim.lsp.Config
return {
	cmd = { "lua-language-server" },
	filetypes = { "lua" },
	root_markers = vim.fn.has("nvim-0.11.3") == 1 and { root_markers1, root_markers2, { ".git" } }
		or vim.list_extend(vim.list_extend(root_markers1, root_markers2), { ".git" }),
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
