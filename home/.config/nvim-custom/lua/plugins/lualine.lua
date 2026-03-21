-- ================================================================================================
-- TITLE : lualine.nvim
-- ABOUT : Fast and configurable statusline
-- LINKS :
--   > github : https://github.com/nvim-lualine/lualine.nvim
-- ================================================================================================

return {
  {
    "nvim-lualine/lualine.nvim",
    event        = "VeryLazy",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()

      -- Hide component when window is too narrow --
      local function hide_in_width()
        return vim.fn.winwidth(0) > 80
      end

      -- Buffer indicator [current/total] --
      local function buffer_indicator()
        local current = vim.fn.bufnr("%")
        local buffers = vim.fn.getbufinfo({ buflisted = 1 })
        local total   = #buffers
        local index   = 0

        for i, buf in ipairs(buffers) do
          if buf.bufnr == current then
            index = i
            break
          end
        end

        if total <= 1 then return "" end
        return string.format("[%d/%d]", index, total)
      end

      -- Mode component --
      local mode = {
        "mode",
        fmt = function(str)
          if hide_in_width() then
            return " " .. str
          else
            return " " .. str:sub(1, 1)
          end
        end,
      }

      -- Filename component --
      local filename = {
        "filename",
        file_status = true,
        path        = 0,
      }

      -- Diagnostics component --
      local diagnostics = {
        "diagnostics",
        sources  = { "nvim_diagnostic" },
        sections = { "error", "warn", "info", "hint" },
        symbols  = {
          error = " ",
          warn  = " ",
          info  = " ",
          hint  = " ",
        },
        colored          = true,
        update_in_insert = false,
        always_visible   = false,
        cond             = hide_in_width,
      }

      -- Diff component --
      local diff = {
        "diff",
        colored = true,
        symbols = {
          added    = " ",
          modified = " ",
          removed  = " ",
        },
        cond = hide_in_width,
      }

      -- Lazy updates component --
      local lazy_updates = {
        require("lazy.status").updates,
        cond  = require("lazy.status").has_updates,
        color = { fg = "#cc8c3c" },
      }

      require("lualine").setup({
        options = {
          icons_enabled        = true,
          theme                = "auto",
          globalstatus         = true,
          section_separators   = { left = "", right = "" },
          component_separators = { left = "", right = "" },
          disabled_filetypes   = {
            statusline = { "snacks_dashboard", "lazy", "mason" },
          },
        },
        sections = {
          lualine_a = { mode },
          lualine_b = { "branch", diff },
          lualine_c = { filename },
          lualine_x = {
            lazy_updates,
            diagnostics,
            { "filetype", cond = hide_in_width },
            { buffer_indicator },
          },
          lualine_y = { "progress" },
          lualine_z = { "location" },
        },
        inactive_sections = {},
      })
    end,
  },
}
