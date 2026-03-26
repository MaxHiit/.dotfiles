-- ================================================================================================
-- TITLE : mini.icons
-- ABOUT : Icon provider — used by which-key, lualine, telescope and other plugins
--         Takes priority over nvim-web-devicons when installed
-- LINKS :
--   > github : https://github.com/echasnovski/mini.icons
-- ================================================================================================

return {
  {
    "echasnovski/mini.icons",
    version = "*",
    lazy    = true,
    opts    = {},
    init    = function()
      -- Mock nvim-web-devicons so plugins that depend on it
      -- use mini.icons instead without needing to be updated
      package.preload["nvim-web-devicons"] = function()
        require("mini.icons").mock_nvim_web_devicons()
        return package.loaded["nvim-web-devicons"]
      end
    end,
  },
}
