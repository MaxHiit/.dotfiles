-- ================================================================================================
-- TITLE : conform.nvim
-- ABOUT : Format on save with formatter auto-detection based on project config files
--         Priority: oxfmt → biome → prettier → LSP fallback
-- LINKS :
--   > github : https://github.com/stevearc/conform.nvim
-- ================================================================================================

-- Toggle format on save globally or per buffer --
vim.api.nvim_create_user_command("ConformDisable", function(args)
  if args.bang then
    vim.b.disable_autoformat = true  -- disable for current buffer only
  else
    vim.g.disable_autoformat = true  -- disable globally
  end
end, { desc = "Disable format on save", bang = true })

vim.api.nvim_create_user_command("ConformEnable", function()
  vim.b.disable_autoformat = false
  vim.g.disable_autoformat = false
end, { desc = "Enable format on save" })

return {
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd   = { "ConformInfo" },
    keys  = {
      {
        "<leader>lf",
        function()
          require("conform").format({ async = true, lsp_format = "fallback" })
        end,
        mode = { "n", "v" },
        desc = "Format buffer",
      },
    },
    opts = {
      notify_on_error = false,

      -- Format after save — async, non-blocking
      -- Respects ConformDisable toggle
      format_after_save = function(bufnr)
        if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
          return
        end
        return {
          async      = true,
          timeout_ms = 3000,
          lsp_format = "fallback",
        }
      end,

      -- Formatters by filetype --
      -- Priority: oxfmt → biome → prettier → LSP fallback
      -- Each formatter only runs if its config file is found in the project
      -- stop_after_first = true — use the first available formatter
      formatters_by_ft = {
        -- TypeScript / JavaScript
        typescript      = { "oxfmt", "biome", "prettier", stop_after_first = true },
        typescriptreact = { "oxfmt", "biome", "prettier", stop_after_first = true },
        javascript      = { "oxfmt", "biome", "prettier", stop_after_first = true },
        javascriptreact = { "oxfmt", "biome", "prettier", stop_after_first = true },
        -- Web
        html     = { "prettier" },
        css      = { "oxfmt", "prettier", stop_after_first = true },
        scss     = { "prettier" },
        -- Data
        json     = { "oxfmt", "biome", "prettier", stop_after_first = true },
        jsonc    = { "oxfmt", "biome", "prettier", stop_after_first = true },
        yaml     = { "prettier" },
        -- Docs
        markdown = { "prettier" },
        -- Python
        python   = { "ruff_format" },
        -- Lua
        lua      = { "stylua" },
        -- Shell
        bash     = { "shfmt" },
        sh       = { "shfmt" },
      },

      -- Formatter conditions --
      -- Each formatter checks for its config file before running
      -- Searches upward from current file to home directory
      formatters = {
        oxfmt = {
          -- Run only if oxfmt is installed in node_modules
          condition = function(_, ctx)
            return vim.fs.find({ "node_modules/.bin/oxfmt" }, {
              path  = ctx.filename,
              upward = true,
              stop  = vim.uv.os_homedir(),
            })[1] ~= nil
          end,
        },
        biome = {
          -- Run only if biome.json exists in the project
          condition = function(_, ctx)
            return vim.fs.find({ "biome.json", "biome.jsonc" }, {
              path  = ctx.filename,
              upward = true,
              stop  = vim.uv.os_homedir(),
            })[1] ~= nil
          end,
        },
        prettier = {
          -- Run only if a prettier config exists in the project
          condition = function(_, ctx)
            return vim.fs.find({
              ".prettierrc",
              ".prettierrc.json",
              ".prettierrc.js",
              ".prettierrc.cjs",
              ".prettierrc.mjs",
              ".prettierrc.yaml",
              ".prettierrc.yml",
              "prettier.config.js",
              "prettier.config.cjs",
              "prettier.config.mjs",
            }, {
              path  = ctx.filename,
              upward = true,
              stop  = vim.uv.os_homedir(),
            })[1] ~= nil
          end,
        },
      },
    },
  },
}
