-- ================================================================================================
-- TITLE : pyright
-- ABOUT : Python type checker and language server
-- LINKS :
--   > github : https://github.com/microsoft/pyright
-- ================================================================================================

-- Custom config required — disable formatting (handled by ruff via conform)
-- and configure type checking mode
vim.lsp.config("pyright", {
  settings = {
    python = {
      analysis = {
        typeCheckingMode    = "standard", -- off / basic / standard / strict
        autoSearchPaths     = true,
        useLibraryCodeForTypes = true,
        diagnosticMode      = "workspace", -- openFilesOnly / workspace
      },
    },
  },
  -- Disable formatting — handled by ruff via conform
  on_attach = function(client)
    client.server_capabilities.documentFormattingProvider = false
  end,
})
