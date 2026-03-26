-- ================================================================================================
-- TITLE : mini.pairs
-- ABOUT : Auto-insert closing pairs for (), [], {}, "", '', ``
--         Lightweight alternative to nvim-autopairs — no nvim-cmp dependency
--         blink.cmp handles auto-brackets after LSP completion
-- LINKS :
--   > github : https://github.com/echasnovski/mini.pairs
-- ================================================================================================

return {
  {
    "echasnovski/mini.pairs",
    version = "*",
    event   = "InsertEnter",
    opts    = {
      -- Pairs to auto-close
      modes = { insert = true, command = false, terminal = false },
    },
  },
}
