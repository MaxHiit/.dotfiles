-- ================================================================================================
-- TITLE : nvim-lspconfig
-- ABOUT : LSP client configuration — mason, lspconfig, LspAttach
-- LINKS :
--   > github (lspconfig)        : https://github.com/neovim/nvim-lspconfig
--   > github (mason)            : https://github.com/mason-org/mason.nvim
--   > github (mason-lspconfig)  : https://github.com/williamboman/mason-lspconfig.nvim
--   > github (mason-installer)  : https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim
--   > github (lazydev)          : https://github.com/folke/lazydev.nvim
-- ================================================================================================

return {
  -- Lua LSP dev tools for neovim config
  -- Provides autocompletion and type hints for the vim API
  {
    "folke/lazydev.nvim",
    ft   = "lua",
    opts = {
      library = {
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },

  {
    "neovim/nvim-lspconfig",
    event        = { "BufReadPost", "BufNewFile" },
    cmd          = { "LspInfo", "LspInstall", "LspUninstall", "Mason" },
    dependencies = {
      {
        "mason-org/mason.nvim",
        opts = {
          ui = {
            border = "rounded",
            icons  = {
              package_installed   = " ",
              package_pending     = " ",
              package_uninstalled = " ",
            },
          },
          max_concurrent_installers = 10,
        },
      },
      "williamboman/mason-lspconfig.nvim",
      {
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        opts = {
          auto_update    = true,
          run_on_start   = true,
          start_delay    = 3000,
          debounce_hours = 12,
          ensure_installed = {
            -- LSP servers
            "lua-language-server",
            "typescript-language-server",
            "pyright",
            "css-lsp",
            "html-lsp",
            "tailwindcss-language-server",
            "bash-language-server",
            "oxlint",
            -- Formatters
            "prettierd",
            "stylua",
            "ruff",
            "shfmt",
          },
        },
      },
      "saghen/blink.cmp",
    },
    config = function()
      -- Capabilities — merge neovim defaults with blink.cmp
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      local ok, blink = pcall(require, "blink.cmp")
      if ok then
        capabilities = vim.tbl_deep_extend(
          "force",
          capabilities,
          blink.get_lsp_capabilities()
        )
      end

      -- Apply capabilities to all LSP servers globally
      vim.lsp.config("*", { capabilities = capabilities })

      -- Diagnostics --
      -- virtual_text = false — handled by tiny-inline-diagnostic
      vim.diagnostic.config({
        underline    = true,
        virtual_text = false,
        signs        = {
          text = {
            [vim.diagnostic.severity.ERROR] = " ",
            [vim.diagnostic.severity.WARN]  = " ",
            [vim.diagnostic.severity.HINT]  = " ",
            [vim.diagnostic.severity.INFO]  = " ",
          },
        },
        float = {
          border    = "rounded",
          source    = true,
          focusable = false,
        },
        update_in_insert = false,
        severity_sort    = true,
      })

      -- LspAttach — runs when a LSP server attaches to a buffer
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("lsp_attach", { clear = true }),
        callback = function(event)
          local bufnr   = event.buf
          local bufname = vim.api.nvim_buf_get_name(bufnr)

          -- Detach from non-file buffers
          if bufname == ""
            or bufname:match("^diffview://")
            or bufname:match("^fugitive://")
          then
            vim.schedule(function()
              vim.lsp.buf_detach_client(bufnr, event.data.client_id)
            end)
            return
          end

          -- Attach buffer-local LSP keymaps
          local keymaps = require("config.keymaps")
          keymaps.map_lsp_keybinds(bufnr)
        end,
      })

      -- Load server configurations from servers/
      require("servers")
    end,
  },
}
