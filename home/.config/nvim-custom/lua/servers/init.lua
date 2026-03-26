-- ================================================================================================
-- TITLE : servers
-- ABOUT : Load LSP server configurations and enable all servers
--         Servers with custom config have their own file in servers/
--         Simple servers are enabled directly here with default lspconfig settings
-- ================================================================================================

-- Load servers with custom configuration
require("servers.lua_ls")
require("servers.ts_ls")
require("servers.pyright")

-- Enable servers with default lspconfig configuration
-- No custom config needed — lspconfig defaults are sufficient
vim.lsp.enable({
  -- Custom configured
  "lua_ls",
  "ts_ls",
  "pyright",
  -- Default config
  "cssls",
  "html",
  "tailwindcss",
  "bashls",
  "oxlint",
})
