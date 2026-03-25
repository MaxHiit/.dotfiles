-- ================================================================================================
-- TITLE : nvim-treesitter
-- ABOUT : Syntax highlighting, indentation, text objects and incremental selection
-- LINKS :
--   > github (treesitter)   : https://github.com/nvim-treesitter/nvim-treesitter
--   > github (textobjects)  : https://github.com/nvim-treesitter/nvim-treesitter-textobjects
--   > github (context)      : https://github.com/nvim-treesitter/nvim-treesitter-context
-- ================================================================================================

return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch  = "master",
    build   = ":TSUpdate",
    event   = { "BufReadPost", "BufNewFile" },
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
    config = function()
      require("nvim-treesitter.configs").setup({
        auto_install = true,

        ensure_installed = {
          "bash",
          "css",
          "dockerfile",
          "gitignore",
          "html",
          "javascript",
          "json",
          "lua",
          "markdown",
          "markdown_inline",
          "python",
          "toml",
          "tsx",
          "typescript",
          "vimdoc",
          "yaml",
        },

        highlight = {
          enable = true,
          -- Disable for large files to prevent slowdowns
          disable = function(_, buf)
            local max_filesize = 100 * 1024
            local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(buf))
            if ok and stats and stats.size > max_filesize then
              return true
            end
          end,
        },

        indent = { enable = true },

        -- Expand/shrink selection by syntax node
        -- <C-space> to expand, <C-backspace> to shrink
        incremental_selection = {
          enable  = true,
          keymaps = {
            init_selection    = "<C-space>",
            node_incremental  = "<C-space>",
            scope_incremental = "<C-s>",
            node_decremental  = "<C-backspace>",
          },
        },

        -- Select and move by syntax node (function, class, parameter)
        textobjects = {
          select = {
            enable    = true,
            lookahead = true,
            keymaps   = {
              ["af"] = { query = "@function.outer",  desc = "Around function" },
              ["if"] = { query = "@function.inner",  desc = "Inner function" },
              ["ac"] = { query = "@class.outer",     desc = "Around class" },
              ["ic"] = { query = "@class.inner",     desc = "Inner class" },
              ["aa"] = { query = "@parameter.outer", desc = "Around parameter" },
              ["ia"] = { query = "@parameter.inner", desc = "Inner parameter" },
            },
          },
          move = {
            enable    = true,
            set_jumps = true,
            goto_next_start = {
              ["]m"] = { query = "@function.outer", desc = "Next function start" },
              ["]]"] = { query = "@class.outer",    desc = "Next class start" },
            },
            goto_next_end = {
              ["]M"] = { query = "@function.outer", desc = "Next function end" },
              ["]["] = { query = "@class.outer",    desc = "Next class end" },
            },
            goto_previous_start = {
              ["[m"] = { query = "@function.outer", desc = "Previous function start" },
              ["[["] = { query = "@class.outer",    desc = "Previous class start" },
            },
            goto_previous_end = {
              ["[M"] = { query = "@function.outer", desc = "Previous function end" },
              ["[]"] = { query = "@class.outer",    desc = "Previous class end" },
            },
          },
        },
      })
    end,
  },

  -- Show current function/class context at top of screen when scrolling
  -- Disabled by default — toggle with <leader>uc
  {
    "nvim-treesitter/nvim-treesitter-context",
    event = { "BufReadPost", "BufNewFile" },
    opts  = {
      enable     = false,
      max_lines  = 3,
      trim_scope = "outer",
    },
    keys = {
      {
        "<leader>uc",
        "<Cmd>TSContextToggle<CR>",
        desc = "Toggle treesitter context",
      },
    },
  },
}
