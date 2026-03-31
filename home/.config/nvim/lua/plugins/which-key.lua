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
    opts  = {
      preset = "helix",
      delay  = 300,

      filter = function(mapping)
        return mapping.desc and mapping.desc ~= ""
      end,

      spec   = {
        {
          mode = { "n", "x" },

          -- File actions (fichier courant)
          { "<leader>f",  group = "file" },

          -- Search / Telescope
          { "<leader>s",  group = "search" },
          { "<leader>sg", group = "git" },

          -- LSP
          { "<leader>l",  group = "lsp" },

          -- Git
          { "<leader>g",  group = "git" },
          { "<leader>gh", group = "hunks" },

          -- Reload / Rename
          { "<leader>r",  group = "reload / rename" },

          -- Explorer
          { "<leader>e",  group = "explorer" },

          -- Harpoon
          { "<leader>h",  group = "harpoon" },

          -- Utils
          { "<leader>u",  group = "utils" },

          -- Buffer group with dynamic expansion
          {
            "<leader>b",
            group  = "buffers",
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

          -- Navigation groups
          { "]",  group = "next" },
          { "[",  group = "prev" },

          -- Go to
          { "g",  group = "goto" },
          { "gr", group = "lsp" },

          -- Fold
          { "z",  group = "fold" },

          -- Surround and comment
          { "gs", group = "surround" },
          { "gc", group = "comment" },
        },
      },
    },

    keys  = {
      {
        "<leader>?",
        function()
          require("which-key").show({ global = false })
        end,
        desc = "Buffer keymaps (which-key)",
      },
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
