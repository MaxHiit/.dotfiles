-- ================================================================================================
-- TITLE : pyright — Python Type Checker and Language Server
-- INSTALL :
--   Mac  : brew install pyright
--          or : npm install -g pyright
--   Arch : sudo pacman -S pyright
--          or : npm install -g pyright
-- LINKS :
--   > lspconfig : https://github.com/neovim/nvim-lspconfig/blob/master/lsp/pyright.lua
--   > github    : https://github.com/microsoft/pyright
-- ================================================================================================

---@type vim.lsp.Config
return {
  cmd = { "pyright-langserver", "--stdio" },
  workspace_required = true,
  root_markers = {
    "pyrightconfig.json",
    "pyproject.toml",
    "setup.py",
    "setup.cfg",
    "requirements.txt",
    "Pipfile",
  },
  settings = {
    python = {
      analysis = {
        typeCheckingMode = "standard",
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
        diagnosticMode = "workspace",
      },
    },
  },
  on_attach = function(client)
    -- Disable formatting — handled by ruff via conform
    client.server_capabilities.documentFormattingProvider = false
  end,
}
