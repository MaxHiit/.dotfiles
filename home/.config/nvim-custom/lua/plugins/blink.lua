-- ================================================================================================
-- TITLE : blink.cmp
-- ABOUT : Fast completion engine with LSP, path, snippets and buffer sources
-- LINKS :
--   > github              : https://github.com/saghen/blink.cmp
--   > luasnip (dep)       : https://github.com/L3MON4D3/LuaSnip
--   > friendly-snippets   : https://github.com/rafamadriz/friendly-snippets
-- ================================================================================================

return {
  {
    "saghen/blink.cmp",
    event   = { "InsertEnter", "CmdlineEnter" },
    version = "1.*",
    dependencies = {
      "rafamadriz/friendly-snippets",
      {
        "L3MON4D3/LuaSnip",
        version = "2.*",
        build   = "make install_jsregexp",
        dependencies = {
          {
            "rafamadriz/friendly-snippets",
            config = function()
              require("luasnip.loaders.from_vscode").lazy_load()
            end,
          },
        },
        opts = {
          history              = true,
          delete_check_events  = "TextChanged",
        },
      },
    },

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      snippets = { preset = "luasnip" },

      appearance = {
        nerd_font_variant = "mono",
      },

      keymap = {
        preset        = "default",
        ["<CR>"]      = { "accept", "fallback" },
        ["<C-j>"]     = { "select_next", "fallback" },
        ["<C-Space>"] = { "show", "fallback" },
        ["<C-c>"]     = { "cancel", "fallback" },
        ["<C-u>"]     = { "scroll_documentation_up", "fallback" },
        ["<C-d>"]     = { "scroll_documentation_down", "fallback" },
        -- Tab navigates snippets when active, otherwise selects next
        ["<Tab>"] = {
          function(cmp)
            if cmp.snippet_active() then return cmp.snippet_forward() end
            return cmp.select_next()
          end,
          "fallback",
        },
        ["<S-Tab>"] = {
          function(cmp)
            if cmp.snippet_active() then return cmp.snippet_backward() end
            return cmp.select_prev()
          end,
          "fallback",
        },
      },

      completion = {
        accept = {
          auto_brackets = { enabled = true },
        },

        menu = {
          border     = "rounded",
          max_height = 10,
          draw = {
            treesitter = { "lsp" },
            columns    = {
              { "kind_icon" },
              { "label", "label_description", gap = 1 },
              { "source_name" },
            },
            components = {
              source_name = {
                text = function(ctx)
                  local names = {
                    lsp      = "[LSP]",
                    buffer   = "[Buffer]",
                    path     = "[Path]",
                    snippets = "[Snippet]",
                  }
                  return names[ctx.source_name] or ("[" .. ctx.source_name .. "]")
                end,
                highlight = "CmpItemMenu",
              },
            },
          },
        },

        documentation = {
          auto_show          = true,
          auto_show_delay_ms = 300,
          window = { border = "rounded" },
        },
      },

      -- Signature help — shows function parameters while typing
      signature = {
        enabled = true,
        window  = {
          border             = "rounded",
          show_documentation = true,
        },
      },

      sources = {
        default = { "lsp", "path", "snippets", "buffer" },
        providers = {
          lsp = {
            score_offset = 1000,
          },
          path = {
            score_offset = 3,
          },
          snippets = {
            score_offset       = -100,
            max_items          = 2,
            min_keyword_length = 3,
          },
          buffer = {
            score_offset       = -150,
            min_keyword_length = 3,
          },
        },
      },

      fuzzy = {
        implementation = "prefer_rust_with_warning",
      },
    },
  },
}
