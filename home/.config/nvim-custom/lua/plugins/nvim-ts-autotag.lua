-- ================================================================================================
-- TITLE : nvim-ts-autotag
-- ABOUT : Auto-close and auto-rename tags
--         Essential for React and TypeScript development
-- LINKS :
--   > github : https://github.com/windwp/nvim-ts-autotag
-- ================================================================================================

return {
  {
    "windwp/nvim-ts-autotag",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      opts = {
        enable_close          = true,  -- auto-close tags
        enable_rename         = true,  -- auto-rename paired tag
        enable_close_on_slash = false, -- don't close on </
      },
    },
  },
}
