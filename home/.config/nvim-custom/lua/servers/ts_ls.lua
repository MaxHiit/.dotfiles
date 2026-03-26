-- ================================================================================================
-- TITLE : ts_ls
-- ABOUT : TypeScript/JavaScript language server
-- LINKS :
--   > github : https://github.com/typescript-language-server/typescript-language-server
-- ================================================================================================

-- Custom config required — disable document formatting (handled by conform/oxfmt/prettier)
-- and configure TypeScript-specific features
vim.lsp.config("ts_ls", {
  filetypes = {
    "javascript",
    "javascriptreact",
    "typescript",
    "typescriptreact",
  },
  settings = {
    typescript = {
      inlayHints = {
        includeInlayParameterNameHints         = "all",
        includeInlayParameterNameHintsWhenArgumentMatchesName = false,
        includeInlayFunctionParameterTypeHints = true,
        includeInlayVariableTypeHints          = true,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayFunctionLikeReturnTypeHints  = true,
        includeInlayEnumMemberValueHints         = true,
      },
    },
    javascript = {
      inlayHints = {
        includeInlayParameterNameHints         = "all",
        includeInlayParameterNameHintsWhenArgumentMatchesName = false,
        includeInlayFunctionParameterTypeHints = true,
        includeInlayVariableTypeHints          = true,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayFunctionLikeReturnTypeHints  = true,
        includeInlayEnumMemberValueHints         = true,
      },
    },
  },
  -- Disable document formatting — handled by conform (oxfmt/biome/prettier)
  on_attach = function(client)
    client.server_capabilities.documentFormattingProvider      = false
    client.server_capabilities.documentRangeFormattingProvider = false
  end,
})
