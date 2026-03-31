-- ================================================================================================
-- TITLE : tailwindcss — Tailwind CSS Language Server
-- INSTALL :
--   Mac  : npm install -g @tailwindcss/language-server
--   Arch : npm install -g @tailwindcss/language-server
-- LINKS :
--   > lspconfig : https://github.com/neovim/nvim-lspconfig/blob/master/lsp/tailwindcss.lua
--   > github    : https://github.com/tailwindlabs/tailwindcss-intellisense
-- ================================================================================================

return {
	cmd = { "tailwindcss-language-server", "--stdio" },
	filetypes = {
		-- html
		"aspnetcorerazor",
		"astro",
		"astro-markdown",
		"blade",
		"clojure",
		"django-html",
		"htmldjango",
		"edge",
		"eelixir",
		"elixir",
		"ejs",
		"erb",
		"eruby",
		"gohtml",
		"gohtmltmpl",
		"haml",
		"handlebars",
		"hbs",
		"html",
		"htmlangular",
		"html-eex",
		"heex",
		"jade",
		"leaf",
		"liquid",
		"markdown",
		"mdx",
		"mustache",
		"njk",
		"nunjucks",
		"php",
		"razor",
		"slim",
		"twig",
		-- css
		"css",
		"less",
		"postcss",
		"sass",
		"scss",
		"stylus",
		"sugarss",
		-- js
		"javascript",
		"javascriptreact",
		"reason",
		"rescript",
		"typescript",
		"typescriptreact",
		-- mixed
		"vue",
		"svelte",
		"templ",
	},
	capabilities = {
		workspace = {
			didChangeWatchedFiles = {
				dynamicRegistration = true,
			},
		},
	},
	settings = {
		tailwindCSS = {
			validate = true,
			lint = {
				cssConflict = "warning",
				invalidApply = "error",
				invalidScreen = "error",
				invalidVariant = "error",
				invalidConfigPath = "error",
				invalidTailwindDirective = "error",
				recommendedVariantOrder = "warning",
			},
			classAttributes = { "class", "className", "class:list", "classList", "ngClass" },
			includeLanguages = {
				eelixir = "html-eex",
				elixir = "phoenix-heex",
				eruby = "erb",
				heex = "phoenix-heex",
				htmlangular = "html",
				templ = "html",
			},
		},
	},
	before_init = function(_, config)
		if not config.settings then
			config.settings = {}
		end
		if not config.settings.editor then
			config.settings.editor = {}
		end
		if not config.settings.editor.tabSize then
			config.settings.editor.tabSize = vim.lsp.util.get_effective_tabstop()
		end
	end,
	workspace_required = true,
	root_dir = function(bufnr, on_dir)
		local root_files = {
			"tailwind.config.js",
			"tailwind.config.cjs",
			"tailwind.config.mjs",
			"tailwind.config.ts",
			"postcss.config.js",
			"postcss.config.cjs",
			"postcss.config.mjs",
			"postcss.config.ts",
			".git",
		}
		local fname = vim.api.nvim_buf_get_name(bufnr)
		on_dir(vim.fs.dirname(vim.fs.find(root_files, { path = fname, upward = true })[1]))
	end,
}
