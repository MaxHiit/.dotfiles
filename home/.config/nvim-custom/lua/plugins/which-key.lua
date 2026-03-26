-- ================================================================================================
-- TITLE : which-key.nvim
-- ABOUT : Shows keybindings popup when pressing leader or other prefix keys
-- LINKS :
--   > github : https://github.com/folke/which-key.nvim
-- ================================================================================================

return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      preset = "helix",
      delay  = 300,

      -- Filter out mappings without description or with specific descriptions
      filter = function(mapping)
        return mapping.desc and mapping.desc ~= ""
      end,

      spec   = {
        {
          mode = { "n", "x" },

          -- Leader groups
          { "<leader>f",  group = "file" },
          { "<leader>s",  group = "search" },
          { "<leader>l",  group = "lsp" },
          { "<leader>sg", group = "git" },
          { "<leader>gh", group = "hunks" },
          { "<leader>r",  group = "reload / rename" },
          { "<leader>e",  group = "explorer" },
          { "<leader>h",  group = "harpoon" },
          { "<leader>u",  group = "utils" },
          { "<leader>m",  group = "markdown" },

          -- Buffer group with dynamic expansion
          {
            "<leader>b",
            group = "buffers",
            expand = function()
              return require("which-key.extras").expand.buf()
            end,
          },

          -- Window group — proxy to <C-w> + dynamic expansion
          {
            "<leader>w",
            group  = "windows",
            proxy  = "<c-w>",
            expand = function()
              return require("which-key.extras").expand.win()
            end,
          },

          -- Navigation groups — makes ]d [d ]e [e etc. readable
          { "]",  group = "next" },
          { "[",  group = "prev" },

          -- Go to group — gd, gr, gi, gD etc.
          { "g",  group = "goto" },

          -- Fold group — za, zc, zo etc.
          { "z",  group = "fold" },

          { "gs", group = "surround" },
          { "gc", group = "comment" },
        },
      },
    },

    keys = {
      -- Show buffer-local keymaps
      {
        "<leader>?",
        function()
          require("which-key").show({ global = false })
        end,
        desc = "Buffer keymaps (which-key)",
      },
      -- Window hydra mode — stay in window mode until Esc
      {
        "<C-w><space>",
        function()
          require("which-key").show({ keys = "<c-w>", loop = true })
        end,
        desc = "Window hydra mode (which-key)",
      },
    },
  },
}
