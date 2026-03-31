-- ================================================================================================
-- TITLE : nvim-highlight-colors
-- ABOUT : Preview CSS colors inline — hex, rgb, hsl, tailwind, CSS variables
-- LINKS :
--   > github : https://github.com/brenoprata10/nvim-highlight-colors
-- ================================================================================================

return {
	{
		"brenoprata10/nvim-highlight-colors",
		event = { "BufReadPost", "BufNewFile" },
		opts = {
			render = "background", -- background | foreground | virtual
			enable_hex = true,
			enable_short_hex = true,
			enable_rgb = true,
			enable_hsl = true,
			enable_var_usage = true,
			enable_named_colors = true,
			enable_tailwind = true,
		},
	},
}
