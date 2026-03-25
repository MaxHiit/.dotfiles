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
    config = function()
      local telescope = require("telescope")
      local actions   = require("telescope.actions")
      local builtin   = require("telescope.builtin")

      -- Find command — auto-detect best available tool
      -- Priority: ripgrep > fd > find
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
          -- Custom prompt and selection icons
          prompt_prefix   = " ",
          selection_caret = " ",

          -- Show filename before path — easier to scan
          path_display = { "filename_first" },

          -- Ignore common large/irrelevant directories
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

          -- Open file in a real editor window — not in quickfix or plugin panels
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

          mappings = {
            i = {
              -- Navigation
              ["<C-j>"]    = actions.move_selection_next,
              ["<C-k>"]    = actions.move_selection_previous,
              -- History navigation
              ["<C-Down>"] = actions.cycle_history_next,
              ["<C-Up>"]   = actions.cycle_history_prev,
              -- Preview scrolling
              ["<C-f>"]    = actions.preview_scrolling_down,
              ["<C-b>"]    = actions.preview_scrolling_up,
              -- Send to quickfix
              ["<C-q>"]    = actions.send_selected_to_qflist + actions.open_qflist,
              -- Delete buffer (useful in buffer picker)
              ["<C-x>"]    = actions.delete_buffer,
              -- Toggle hidden files
              ["<A-h>"]    = function()
                local action_state = require("telescope.actions.state")
                local line = action_state.get_current_line()
                builtin.find_files({ hidden = true, default_text = line })
              end,
              -- Toggle no_ignore (show gitignored files)
              ["<A-i>"]    = function()
                local action_state = require("telescope.actions.state")
                local line = action_state.get_current_line()
                builtin.find_files({ no_ignore = true, default_text = line })
              end,
            },
            n = {
              -- Close telescope in normal mode
              ["q"] = actions.close,
            },
          },
        },

        pickers = {
          find_files = {
            find_command = find_command(),
            hidden       = true, -- show dotfiles by default
          },
        },
      })

      -- Load fzf extension — significantly improves search performance
      pcall(telescope.load_extension, "fzf")

      -- Keymaps --
      local map = vim.keymap.set

      -- Files
      map("n", "<leader>tf",  builtin.find_files,  { desc = "Telescope: find files" })
      map("n", "<leader>tr",  builtin.oldfiles,     { desc = "Telescope: recent files" })
      map("n", "<leader>tg",  builtin.live_grep,    { desc = "Telescope: live grep" })
      map("n", "<leader>tb",  builtin.buffers,      { desc = "Telescope: buffers" })
      map("n", "<leader>th",  builtin.help_tags,    { desc = "Telescope: help tags" })
      map("n", "<leader>tk",  builtin.keymaps,      { desc = "Telescope: keymaps" })
      map("n", "<leader>tR",  builtin.resume,       { desc = "Telescope: resume last search" })

      -- Current buffer fuzzy find
      map("n", "<leader>t/", function()
        builtin.current_buffer_fuzzy_find(
          require("telescope.themes").get_dropdown({ previewer = false })
        )
      end, { desc = "Telescope: fuzzy find in buffer" })

      -- Search word under cursor
      map("n", "<leader>tw", function()
        builtin.grep_string({ search = vim.fn.expand("<cword>") })
      end, { desc = "Telescope: grep word under cursor" })

      -- Search WORD under cursor (including special chars)
      map("n", "<leader>tW", function()
        builtin.grep_string({ search = vim.fn.expand("<cWORD>") })
      end, { desc = "Telescope: grep WORD under cursor" })

      -- Git
      map("n", "<leader>tgc", builtin.git_commits,  { desc = "Telescope: git commits" })
      map("n", "<leader>tgb", builtin.git_branches, { desc = "Telescope: git branches" })
      map("n", "<leader>tgs", builtin.git_status,   { desc = "Telescope: git status" })

      -- LSP
      map("n", "<leader>ts",  builtin.lsp_document_symbols,  { desc = "Telescope: document symbols" })
      map("n", "<leader>tS",  builtin.lsp_workspace_symbols, { desc = "Telescope: workspace symbols" })
      map("n", "<leader>td",  builtin.diagnostics,           { desc = "Telescope: diagnostics" })
    end,
  },
}
