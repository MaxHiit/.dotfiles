-- ================================================================================================
-- TITLE : LSP configuration
-- ABOUT : Native Neovim 0.11+ LSP setup — no mason, no lspconfig plugin
--         Servers installed via system package manager (brew/pacman/npm)
--         Server configs live in nvim/lsp/*.lua and are auto-loaded
-- ================================================================================================

local diagnostic_icons = require("icons").diagnostics

-- On attach

local function on_lsp_attach(client, bufnr)
	local function map(mode, lhs, rhs, desc)
		vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
	end

	-- Go to --
	if client:supports_method("textDocument/definition") then
		map("n", "gd", vim.lsp.buf.definition, "LSP: go to definition")
	end

	if client:supports_method("textDocument/declaration") then
		map("n", "gD", vim.lsp.buf.declaration, "LSP: go to declaration")
	end

	if client:supports_method("textDocument/implementation") then
		map("n", "gi", vim.lsp.buf.implementation, "LSP: go to implementation")
	end

	if client:supports_method("textDocument/references") then
		map("n", "gr", vim.lsp.buf.references, "LSP: go to references")
	end

	if client:supports_method("textDocument/typeDefinition") then
		map("n", "td", vim.lsp.buf.type_definition, "LSP: go to type definition")
	end

	-- Hover / Signature --
	map("n", "K", function()
		local ufo_ok, ufo = pcall(require, "ufo")
		if ufo_ok then
			local winid = ufo.peekFoldedLinesUnderCursor()
			if winid then
				return
			end
		end
		vim.lsp.buf.hover()
	end, "LSP: hover / peek fold")

	if client:supports_method("textDocument/signatureHelp") then
		map("i", "<C-k>", vim.lsp.buf.signature_help, "LSP: signature help")
	end

	-- Code actions --
	if client:supports_method("textDocument/codeAction") then
		map({ "n", "v" }, "<leader>la", vim.lsp.buf.code_action, "LSP: code action")
	end

	if client:supports_method("textDocument/rename") then
		map("n", "<leader>lr", vim.lsp.buf.rename, "LSP: rename symbol")
	end

	-- Document color — natif 0.12
	if client:supports_method("textDocument/documentColor") then
		map({ "n", "x" }, "grc", function()
			vim.lsp.document_color.color_presentation()
		end, "LSP: color presentation")
	end

	-- Format
	map("n", "<leader>lf", function()
		require("conform").format({ async = true, lsp_format = "fallback" })
	end, "LSP: format buffer")

	-- Inlay hints toggle
	if client:supports_method("textDocument/inlayHint") then
		map("n", "<leader>li", function()
			vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr }), { bufnr = bufnr })
		end, "LSP: toggle inlay hints")
	end

	-- Diagnostics navigation --
	map("n", "]d", function()
		vim.diagnostic.jump({ count = 1, float = false })
		vim.api.nvim_feedkeys("zz", "n", false)
	end, "LSP: next diagnostic")

	map("n", "[d", function()
		vim.diagnostic.jump({ count = -1, float = false })
		vim.api.nvim_feedkeys("zz", "n", false)
	end, "LSP: previous diagnostic")

	map("n", "]e", function()
		vim.diagnostic.jump({ count = 1, severity = vim.diagnostic.severity.ERROR, float = false })
		vim.api.nvim_feedkeys("zz", "n", false)
	end, "LSP: next error")

	map("n", "[e", function()
		vim.diagnostic.jump({ count = -1, severity = vim.diagnostic.severity.ERROR, float = false })
		vim.api.nvim_feedkeys("zz", "n", false)
	end, "LSP: previous error")

	map("n", "]w", function()
		vim.diagnostic.jump({ count = 1, severity = vim.diagnostic.severity.WARN, float = false })
		vim.api.nvim_feedkeys("zz", "n", false)
	end, "LSP: next warning")

	map("n", "[w", function()
		vim.diagnostic.jump({ count = -1, severity = vim.diagnostic.severity.WARN, float = false })
		vim.api.nvim_feedkeys("zz", "n", false)
	end, "LSP: previous warning")

	map("n", "<leader>ld", function()
		vim.diagnostic.open_float({ border = "rounded" })
	end, "LSP: open diagnostic float")

	map("n", "<leader>lq", vim.diagnostic.setqflist, "LSP: diagnostics to quickfix")

	-- Document highlight on cursor hold --
	if client:supports_method("textDocument/documentHighlight") then
		local group = vim.api.nvim_create_augroup("lsp_document_highlight_" .. bufnr, { clear = true })
		vim.api.nvim_create_autocmd({ "CursorHold", "InsertLeave" }, {
			group = group,
			buffer = bufnr,
			callback = vim.lsp.buf.document_highlight,
		})
		vim.api.nvim_create_autocmd({ "CursorMoved", "InsertEnter", "BufLeave" }, {
			group = group,
			buffer = bufnr,
			callback = vim.lsp.buf.clear_references,
		})
	end

	-- Inlay hints — hide in insert mode to avoid distraction --
	if client:supports_method("textDocument/inlayHint") then
		local group = vim.api.nvim_create_augroup("lsp_inlay_hints_" .. bufnr, { clear = true })
		vim.api.nvim_create_autocmd("InsertEnter", {
			group = group,
			buffer = bufnr,
			callback = function()
				vim.lsp.inlay_hint.enable(false, { bufnr = bufnr })
			end,
		})
		vim.api.nvim_create_autocmd("InsertLeave", {
			group = group,
			buffer = bufnr,
			callback = function()
				vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
			end,
		})
	end
end

-- Diagnostics

vim.diagnostic.config({
	status = {
		format = {
			[vim.diagnostic.severity.ERROR] = diagnostic_icons.ERROR,
			[vim.diagnostic.severity.WARN] = diagnostic_icons.WARN,
			[vim.diagnostic.severity.INFO] = diagnostic_icons.INFO,
			[vim.diagnostic.severity.HINT] = diagnostic_icons.HINT,
		},
	},
	underline = true,
	virtual_text = {
		prefix = "",
		spacing = 2,
		format = function(diagnostic)
			local icon = diagnostic_icons[vim.diagnostic.severity[diagnostic.severity]] or ""
			local msg = icon
			if diagnostic.source then
				msg = msg .. " " .. diagnostic.source
			end
			if diagnostic.code then
				msg = msg .. " [" .. diagnostic.code .. "]"
			end
			return msg .. " "
		end,
	},
	-- Disable signs in the gutter
	signs = false,
	float = {
		border = "rounded",
		source = "if_many",
		focusable = false,
		prefix = function(diag)
			local level = vim.diagnostic.severity[diag.severity]
			return diagnostic_icons[level] .. " ", "Diagnostic" .. level:gsub("^%l", string.upper)
		end,
	},
	update_in_insert = false,
	severity_sort = true,
})

-- Sort virtual text — most severe first
local show_handler = assert(vim.diagnostic.handlers.virtual_text.show)
local hide_handler = vim.diagnostic.handlers.virtual_text.hide
vim.diagnostic.handlers.virtual_text = {
	show = function(ns, bufnr, diagnostics, opts)
		table.sort(diagnostics, function(a, b)
			return a.severity > b.severity
		end)
		return show_handler(ns, bufnr, diagnostics, opts)
	end,
	hide = hide_handler,
}

-- Hover / Signature sizing
local hover_orig = vim.lsp.buf.hover
---@diagnostic disable-next-line: duplicate-set-field
vim.lsp.buf.hover = function()
	return hover_orig({
		max_height = math.floor(vim.o.lines * 0.5),
		max_width = math.floor(vim.o.columns * 0.4),
		border = "rounded",
	})
end

local sig_orig = vim.lsp.buf.signature_help
---@diagnostic disable-next-line: duplicate-set-field
vim.lsp.buf.signature_help = function()
	return sig_orig({
		max_height = math.floor(vim.o.lines * 0.5),
		max_width = math.floor(vim.o.columns * 0.4),
		border = "rounded",
	})
end

-- Dynamic capability registration

-- Re-run on_lsp_attach when server registers new capabilities dynamically
local register_capability = vim.lsp.handlers["client/registerCapability"]
---@diagnostic disable-next-line: duplicate-set-field
vim.lsp.handlers["client/registerCapability"] = function(err, res, ctx)
	local client = vim.lsp.get_client_by_id(ctx.client_id)
	if client then
		on_lsp_attach(client, vim.api.nvim_get_current_buf())
	end
	return register_capability(err, res, ctx)
end

-- LspAttach

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("lsp_attach", { clear = true }),
	callback = function(event)
		local client = vim.lsp.get_client_by_id(event.data.client_id)
		if not client then
			return
		end

		local bufnr = event.buf
		local bufname = vim.api.nvim_buf_get_name(bufnr)

		-- Detach from non-file buffers
		if bufname == "" or bufname:match("^diffview://") or bufname:match("^fugitive://") then
			vim.schedule(function()
				vim.lsp.buf_detach_client(bufnr, event.data.client_id)
			end)
			return
		end

		on_lsp_attach(client, bufnr)
	end,
})

-- Server loading

-- Auto-load all servers from nvim/lsp/*.lua
-- Capabilities set here to ensure blink.cmp is loaded before enabling servers
vim.api.nvim_create_autocmd({ "BufReadPre", "BufNewFile" }, {
	once = true,
	callback = function()
		-- Extend neovim capabilities with blink.cmp completion capabilities
		vim.lsp.config("*", {
			capabilities = require("blink.cmp").get_lsp_capabilities(nil, true),
		})

		-- Discover and enable all servers from lsp/*.lua automatically
		local servers = vim.iter(vim.api.nvim_get_runtime_file("lsp/*.lua", true))
			:map(function(file)
				return vim.fn.fnamemodify(file, ":t:r")
			end)
			:totable()

		vim.lsp.enable(servers)
	end,
})
