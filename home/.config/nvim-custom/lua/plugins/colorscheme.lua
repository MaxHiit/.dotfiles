-- ================================================================================================
-- TITLE : colorscheme
-- ABOUT : Gruber Darker theme via gruvbox palette overrides
--         Colors are mapped from Gruber Darker to gruvbox palette
--         to match the Ghostty terminal theme exactly
-- LINKS :
--   > github : https://github.com/ellisonleao/gruvbox.nvim
--   > theme : https://github.com/davide-ferrara/omarchy-gruberdark-tsoding-theme
-- ================================================================================================

return {
  {
    "ellisonleao/gruvbox.nvim",
    lazy = false,    -- Load immediately — colorscheme must be available on startup
    priority = 1000, -- Load before all other plugins
    opts = {
      palette_overrides = {
        -- Backgrounds
        dark0_hard = "#101010", -- gruber-darker-bg-1
        dark0 = "#181818",      -- gruber-darker-bg
        dark0_soft = "#282828", -- gruber-darker-bg+1
        dark1 = "#303540",      -- gruber-darker-niagara-2
        dark2 = "#453d41",      -- gruber-darker-bg+2
        dark3 = "#484848",      -- gruber-darker-bg+3
        dark4 = "#52494e",      -- gruber-darker-bg+4

        -- Foregrounds
        light0_hard = "#ffffff", -- gruber-darker-white
        light0 = "#f4f4ff",      -- gruber-darker-fg+1
        light0_soft = "#e4e4ef", -- gruber-darker-fg
        light1 = "#e4e4ef",      -- gruber-darker-fg
        light2 = "#e4e4ef",      -- gruber-darker-fg (fallback)
        light3 = "#96a6c8",      -- gruber-darker-niagara (dimmed text)
        light4 = "#565f73",      -- gruber-darker-niagara-1 (darker text)

        -- Bright colors
        bright_red = "#f43841",    -- gruber-darker-red
        bright_green = "#73c936",  -- gruber-darker-green
        bright_yellow = "#ffdd33", -- gruber-darker-yellow
        bright_blue = "#96a6c8",   -- gruber-darker-niagara
        bright_purple = "#9e95c7", -- gruber-darker-wisteria
        bright_aqua = "#95a99f",   -- gruber-darker-quartz
        bright_orange = "#cc8c3c", -- gruber-darker-brown

        -- Neutral colors
        neutral_red = "#c73c3f",    -- gruber-darker-red-1
        neutral_green = "#73c936",  -- gruber-darker-green
        neutral_yellow = "#ffdd33", -- gruber-darker-yellow
        neutral_blue = "#565f73",   -- gruber-darker-niagara-1
        neutral_purple = "#9e95c7", -- gruber-darker-wisteria
        neutral_aqua = "#95a99f",   -- gruber-darker-quartz
        neutral_orange = "#cc8c3c", -- gruber-darker-brown

        -- Faded colors
        faded_red = "#c73c3f",
        faded_green = "#73c936",
        faded_yellow = "#cc8c3c",
        faded_blue = "#303540",
        faded_purple = "#9e95c7",
        faded_aqua = "#95a99f",
        faded_orange = "#cc8c3c",

        -- Git / diff variants
        dark_red_hard = "#c73c3f",
        dark_red = "#f43841",
        dark_red_soft = "#ff4f58",
        light_red_hard = "#ff4f58",
        light_red = "#f43841",
        light_red_soft = "#c73c3f",

        dark_green_hard = "#73c936",
        dark_green = "#73c936",
        dark_green_soft = "#73c936",
        light_green_hard = "#73c936",
        light_green = "#73c936",
        light_green_soft = "#73c936",

        dark_aqua_hard = "#95a99f",
        dark_aqua = "#95a99f",
        dark_aqua_soft = "#95a99f",
        light_aqua_hard = "#95a99f",
        light_aqua = "#95a99f",
        light_aqua_soft = "#95a99f",

        gray = "#52494e",
      },
      overrides = {
        -- Comments in brown/orange — Gruber Darker style
        Comment                    = { fg = "#cc8c3c", italic = true },
        ["@comment"]               = { link = "Comment" },

        -- Inlay hints — subtle, doesn't compete with code
        LspInlayHint               = { fg = "#52494e", bg = "NONE" },

        -- Remove sign column background
        SignColumn                 = { bg = "NONE" },
        SignColumnSB               = { bg = "NONE" },
        GitSignsAdd                = { bg = "NONE" },
        GitSignsChange             = { bg = "NONE" },
        GitSignsDelete             = { bg = "NONE" },

        -- Float windows match editor background
        NormalFloat                = { bg = "#181818" },
        FloatBorder                = { bg = "#181818", fg = "#484848" },

        -- Gitsigns — couleurs du thème Gruber Darker
        Gitsignsadd                = { fg = "#73c936", bg = "none" },
        Gitsignschange             = { fg = "#ffdd33", bg = "none" },
        Gitsignsdelete             = { fg = "#f43841", bg = "none" },
        Gitsignstopdelete          = { fg = "#f43841", bg = "none" },
        Gitsignschangedelete       = { fg = "#ffdd33", bg = "none" },
        Gitsignsuntracked          = { fg = "#96a6c8", bg = "none" },

        -- staged (après git add)
        GitSignsAddStaged          = { fg = "#73c936", bg = "NONE" },
        GitSignsChangeStaged       = { fg = "#ffdd33", bg = "NONE" },
        GitSignsDeleteStaged       = { fg = "#f43841", bg = "NONE" },
        GitSignsTopdeleteStaged    = { fg = "#f43841", bg = "NONE" },
        GitSignsChangedeleteStaged = { fg = "#ffdd33", bg = "NONE" },
      },
    },
    config = function(_, opts)
      require("gruvbox").setup(opts)

      -- Apply colorscheme
      vim.cmd.colorscheme("gruvbox")

      -- Clear LSP semantic highlight groups --
      -- Neovim 0.9+ injects @lsp.* highlight groups that can override theme colors
      -- Clearing them lets the colorscheme control all syntax highlighting
      for _, group in ipairs(vim.fn.getcompletion("@lsp", "highlight")) do
        vim.api.nvim_set_hl(0, group, {})
      end
    end,
  },
}
