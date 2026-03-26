-- ================================================================================================
-- TITLE : tiny-inline-diagnostic.nvim
-- ABOUT : Inline diagnostics — replaces neovim's default virtual text
-- LINKS :
--   > github : https://github.com/rachartier/tiny-inline-diagnostic.nvim
-- ================================================================================================

return {
  {
    "rachartier/tiny-inline-diagnostic.nvim",
    event    = "VeryLazy",
    priority = 1000,
    opts = {
      preset = "classic",
      options = {
        add_messages = {
          display_count = true,
          messages      = true,
        },
        multilines = {
          always_show = true,
          enabled     = true,
        },
      },
    },
  },
}
