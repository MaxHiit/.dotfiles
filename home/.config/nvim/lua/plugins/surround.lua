-- ================================================================================================
-- TITLE : mini.surround
-- ABOUT : Add, delete, replace surrounding pairs (brackets, quotes, tags)
-- LINKS :
--   > github : https://github.com/echasnovski/mini.surround
--
-- Commands (gs prefix — cohérent avec gc pour les commentaires):
--   gsa{motion}{char}  add surrounding       e.g. gsaiw) → (word)
--   gsd{char}          delete surrounding    e.g. gsd)   → word
--   gsr{char}{char}    replace surrounding   e.g. gsr)"  → "word"
--   gsf{char}          find surrounding (right)
--   gsF{char}          find surrounding (left)
--   gsh{char}          highlight surrounding
--   gsn                update n_lines
-- ================================================================================================

return {
  {
    "echasnovski/mini.surround",
    version = "*",
    event   = { "BufReadPost", "BufNewFile" },
    opts    = {
      -- Use gs prefix instead of s — consistent with gc (comment)
      -- and avoids conflicts with vim's native s (substitute)
      mappings = {
        add            = "gsa",
        delete         = "gsd",
        find           = "gsf",
        find_left      = "gsF",
        highlight      = "gsh",
        replace        = "gsr",
        update_n_lines = "gsn",
      },
      n_lines = 20,
    },
  },
}
