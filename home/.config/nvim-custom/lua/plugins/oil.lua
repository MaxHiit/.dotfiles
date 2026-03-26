-- ================================================================================================
-- TITLE : oil.nvim
-- ABOUT : File explorer that lets you edit the filesystem like a buffer
--         Rename files with cw, delete with dd, move with yy/p — just like editing text
-- LINKS :
--   > github : https://github.com/stevearc/oil.nvim
-- ================================================================================================

return {
  {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("oil").setup({
        -- Replace netrw as the default file explorer
        default_file_explorer = true,

        -- Rounded borders on all oil popups
        confirmation = { border = "rounded" },
        float         = { border = "rounded" },

        -- Send to trash instead of permanent delete
        delete_to_trash = true,

        -- Skip confirmation for simple edits (rename, etc.)
        skip_confirm_for_simple_edits = true,

        keymaps = {
          -- Disable keys that conflict with our global keymaps
          ["<C-l>"] = false, -- conflicts with tmux-aware navigate right
          ["<C-h>"] = false, -- conflicts with tmux-aware navigate left
          ["<C-c>"] = false, -- conflicts with our Esc remap

          -- Replacements
          ["<C-r>"]  = "actions.refresh",
          ["<M-h>"]  = "actions.select_split",
          ["q"]      = "actions.close",
        },

        view_options = {
          show_hidden = true, -- show dotfiles (.env, .gitignore, etc.)
        },
      })

      -- Keymaps --
      local map = vim.keymap.set

      -- Open parent directory in current window (standard oil convention)
      map("n", "-", "<Cmd>Oil<CR>", { desc = "Oil: open parent directory" })

      -- Open parent directory in float window
      map("n", "<leader>e", function()
        require("oil").toggle_float()
      end, { desc = "Oil: toggle float explorer" })

      -- Autocmds --

      -- Hide colorcolumn in oil buffer — not useful in a file explorer
      vim.api.nvim_create_autocmd("FileType", {
        pattern  = "oil",
        callback = function()
          vim.opt_local.colorcolumn = ""
          vim.opt_local.cursorline  = true
        end,
      })
    end,
  },
}
