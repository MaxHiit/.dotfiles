-- ================================================================================================
-- TITLE : fidget.nvim
-- ABOUT : LSP progress notifications — shows server loading status bottom right
-- LINKS :
--   > github : https://github.com/j-hui/fidget.nvim
-- ================================================================================================

return {
  {
    "j-hui/fidget.nvim",
    opts = {
      notification = {
        window = {
          winblend = 0,
          border   = "none",
          align    = "bottom",
        },
      },
    },
  },
}
