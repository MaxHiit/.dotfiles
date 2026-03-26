-- ================================================================================================
-- TITLE : mini.surround
-- ABOUT : Add, delete, replace surrounding pairs (brackets, quotes, tags)
-- LINKS :
--   > github : https://github.com/echasnovski/mini.surround
--
-- Commands:
--   sa{motion}{char}  add surrounding       e.g. saiw) → (word)
--   sd{char}          delete surrounding    e.g. sd)   → word
--   sr{char}{char}    replace surrounding   e.g. sr)"  → "word"
--   sf{char}          find surrounding (right)
--   sF{char}          find surrounding (left)
--   sh{char}          highlight surrounding
--   sn                update n_lines
-- ================================================================================================

return {
  {
    "echasnovski/mini.surround",
    version = "*",
    event   = { "BufReadPost", "BufNewFile" },
    opts    = {
      -- Number of lines to search for surrounding
      n_lines = 20,
    },
  },
}
