-- ================================================================================================
-- TITLE : lua_ls
-- ABOUT : Lua language server — custom config required for neovim API awareness
-- LINKS :
--   > github : https://github.com/LuaLS/lua-language-server
-- ================================================================================================

-- Custom config required — without this lua_ls reports errors on vim.* globals
-- and doesn't understand the neovim runtime environment
vim.lsp.config("lua_ls", {
  settings = {
    Lua = {
      runtime = {
        version = "LuaJIT", -- neovim uses LuaJIT
      },
      workspace = {
        checkThirdParty = false,
        -- Make lua_ls aware of neovim runtime files
        library = {
          vim.fn.expand("$VIMRUNTIME/lua"),
          vim.fn.stdpath("config") .. "/lua",
        },
      },
      diagnostics = {
        globals = { "vim" }, -- recognize vim as a global
      },
      telemetry = {
        enable = false,
      },
    },
  },
})
