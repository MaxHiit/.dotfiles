-- ================================================================================================
-- TITLE : telescope.nvim
-- ABOUT : Fuzzy finder for files, buffers, LSP symbols, git and more
-- LINKS :
--   > github (telescope)     : https://github.com/nvim-telescope/telescope.nvim
--   > github (fzf-native)    : https://github.com/nvim-telescope/telescope-fzf-native.nvim
-- ================================================================================================

return {
  {
    "nvim-telescope/telescope.nvim",
    branch       = "master",
    cmd          = "Telescope",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        cond  = vim.fn.executable("make") == 1,
      },
    },
    config       = function()
      local telescope = require("telescope")
      local actions   = require("telescope.actions")
      local builtin   = require("telescope.builtin")

      -- Find command — auto-detect best available tool
      local function find_command()
        if vim.fn.executable("rg") == 1 then
          return { "rg", "--files", "--color", "never", "-g", "!.git" }
        elseif vim.fn.executable("fd") == 1 then
          return { "fd", "--type", "f", "--color", "never", "-E", ".git" }
        else
          return { "find", ".", "-type", "f" }
        end
      end

      telescope.setup({
        defaults = {
          prompt_prefix        = " ",
          selection_caret      = " ",
          path_display         = { "filename_first" },

          file_ignore_patterns = {
            "node_modules",
            "yarn.lock",
            "package-lock.json",
            ".git/",
            ".next/",
            "dist/",
            "build/",
            ".cache/",
          },

          -- Open file in a real editor window
          get_selection_window = function()
            local wins = vim.api.nvim_list_wins()
            table.insert(wins, 1, vim.api.nvim_get_current_win())
            for _, win in ipairs(wins) do
              local buf = vim.api.nvim_win_get_buf(win)
              if vim.bo[buf].buftype == "" then
                return win
              end
            end
            return 0
          end,

          mappings             = {
            i = {
              ["<C-j>"]    = actions.move_selection_next,
              ["<C-k>"]    = actions.move_selection_previous,
              ["<C-Down>"] = actions.cycle_history_next,
              ["<C-Up>"]   = actions.cycle_history_prev,
              ["<C-f>"]    = actions.preview_scrolling_down,
              ["<C-b>"]    = actions.preview_scrolling_up,
              ["<C-q>"]    = actions.send_selected_to_qflist + actions.open_qflist,
              ["<C-x>"]    = actions.delete_buffer,
              ["<A-h>"]    = function()
                local action_state = require("telescope.actions.state")
                local line = action_state.get_current_line()
                builtin.find_files({ hidden = true, default_text = line })
              end,
              ["<A-i>"]    = function()
                local action_state = require("telescope.actions.state")
                local line = action_state.get_current_line()
                builtin.find_files({ no_ignore = true, default_text = line })
              end,
            },
            n = {
              ["q"] = actions.close,
            },
          },
        },

        pickers = {
          find_files = {
            find_command = find_command(),
            hidden       = true,
          },
        },
      })

      -- Load fzf extension
      pcall(telescope.load_extension, "fzf")

      -- Keymaps --
      local map = vim.keymap.set

      -- Files
      map("n", "<leader>sf", builtin.find_files, { desc = "Search: find files" })
      map("n", "<leader>sr", builtin.oldfiles, { desc = "Search: recent files" })
      map("n", "<leader>sg", builtin.live_grep, { desc = "Search: live grep" })
      map("n", "<leader>sb", builtin.buffers, { desc = "Search: buffers" })
      map("n", "<leader>sh", builtin.help_tags, { desc = "Search: help tags" })
      map("n", "<leader>sk", builtin.keymaps, { desc = "Search: keymaps" })
      map("n", "<leader>sR", builtin.resume, { desc = "Search: resume last search" })
      map("n", "<leader>sd", builtin.diagnostics, { desc = "Search: diagnostics" })
      map("n", "<leader>sj", builtin.jumplist, { desc = "Search: jumplist" })
      map("n", "<leader>sm", builtin.marks, { desc = "Search: marks" })
      map("n", '<leader>s"', builtin.registers, { desc = "Search: registers" })
      map("n", "<leader>ss", builtin.lsp_document_symbols, { desc = "Search: document symbols" })
      map("n", "<leader>sS", builtin.lsp_workspace_symbols, { desc = "Search: workspace symbols" })

      -- Search word under cursor
      map("n", "<leader>sw", function()
        builtin.grep_string({ search = vim.fn.expand("<cword>") })
      end, { desc = "Search: grep word under cursor" })

      map("n", "<leader>sW", function()
        builtin.grep_string({ search = vim.fn.expand("<cWORD>") })
      end, { desc = "Search: grep WORD under cursor" })

      -- Fuzzy find in current buffer
      map("n", "<leader>s/", function()
        builtin.current_buffer_fuzzy_find(
          require("telescope.themes").get_dropdown({ previewer = false })
        )
      end, { desc = "Search: fuzzy find in buffer" })

      -- Git
      map("n", "<leader>sgc", builtin.git_commits, { desc = "Search: git commits" })
      map("n", "<leader>sgb", builtin.git_branches, { desc = "Search: git branches" })
      map("n", "<leader>sgs", builtin.git_status, { desc = "Search: git status" })
    end,
  },
}
