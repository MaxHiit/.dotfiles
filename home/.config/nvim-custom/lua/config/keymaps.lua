-- ================================================================================================
-- TITLE : NeoVim keymaps
-- ABOUT : Global keymaps and LSP keymaps
--         Plugin-specific keymaps are defined in their respective plugin file
-- ================================================================================================

local map = vim.keymap.set

-- Disable bad habits --
map("n", "<up>", "<nop>", { desc = "Disabled — use k" })
map("n", "<down>", "<nop>", { desc = "Disabled — use j" })
map("n", "<left>", "<nop>", { desc = "Disabled — use h" })
map("n", "<right>", "<nop>", { desc = "Disabled — use l" })
map("n", "Q", "<nop>", { desc = "Disabled — ex mode" })

-- Insert mode --
map("i", "jj", "<Esc>", { desc = "Exit insert mode" })
map("i", "JJ", "<Esc>", { desc = "Exit insert mode" })

-- File --
map({ "n", "i" }, "<C-s>", "<Cmd>w<CR>", { desc = "Save file" })
map("n", "<leader>fw", "<Cmd>w<CR>", { desc = "Save file" })
map("n", "<leader>fq", "<Cmd>q<CR>", { desc = "Quit" })
map("n", "<leader>fQ", "<Cmd>qa!<CR>", { desc = "Quit all without saving" })
map("n", "<leader>fr", "<Cmd>checktime<CR>", { desc = "Reload file" })
map("n", "<leader>fp", function()
	local path = vim.fn.expand("%:~")
	vim.fn.setreg("+", path)
	vim.notify("Copied: " .. path)
end, { desc = "Copy file path to clipboard" })

-- Config --
map("n", "<leader>rc", "<Cmd>e ~/.config/nvim-custom/init.lua<CR>", { desc = "Edit neovim config" })
map("n", "<leader>rr", function()
	vim.cmd.source(vim.fn.stdpath("config") .. "/init.lua")
	vim.notify("Config reloaded!", vim.log.levels.INFO)
end, { desc = "Reload neovim config" })

-- Navigation centered --
-- zz centers the screen after each jump — reduces context switching
map("n", "<C-d>", "<C-d>zz", { desc = "Half page down (centered)" })
map("n", "<C-u>", "<C-u>zz", { desc = "Half page up (centered)" })
map("n", "n", "nzzzv", { desc = "Next search result (centered)" })
map("n", "N", "Nzzzv", { desc = "Previous search result (centered)" })
map("n", "G", "Gzz", { desc = "End of file (centered)" })
map("n", "gg", "ggzz", { desc = "Start of file (centered)" })
map("n", "{", "{zz", { desc = "Previous paragraph (centered)" })
map("n", "}", "}zz", { desc = "Next paragraph (centered)" })
map("n", "<C-i>", "<C-i>zz", { desc = "Jump forward in jumplist (centered)" })
map("n", "<C-o>", "<C-o>zz", { desc = "Jump backward in jumplist (centered)" })
map("n", "%", "%zz", { desc = "Matching bracket (centered)" })
map("n", "*", "*zz", { desc = "Search word forward (centered)" })
map("n", "#", "#zz", { desc = "Search word backward (centered)" })

-- H/L remapped to line start/end
-- Native H/L (screen top/bottom) replaced by more useful line navigation
map("n", "H", "^", { desc = "First non-blank character of line" })
map("n", "L", "$", { desc = "End of line" })
map("v", "H", "^", { desc = "First non-blank character of line" })
map("v", "L", "$<left>", { desc = "End of line (visual)" })

-- Windows --
-- Navigate between splits — falls back to wincmd if tmux plugin not loaded
map("n", "<C-h>", function()
	if vim.fn.exists(":NvimTmuxNavigateLeft") ~= 0 then
		vim.cmd.NvimTmuxNavigateLeft()
	else
		vim.cmd.wincmd("h")
	end
end, { desc = "Navigate left (tmux-aware)" })

map("n", "<C-j>", function()
	if vim.fn.exists(":NvimTmuxNavigateDown") ~= 0 then
		vim.cmd.NvimTmuxNavigateDown()
	else
		vim.cmd.wincmd("j")
	end
end, { desc = "Navigate down (tmux-aware)" })

map("n", "<C-k>", function()
	if vim.fn.exists(":NvimTmuxNavigateUp") ~= 0 then
		vim.cmd.NvimTmuxNavigateUp()
	else
		vim.cmd.wincmd("k")
	end
end, { desc = "Navigate up (tmux-aware)" })

map("n", "<C-l>", function()
	if vim.fn.exists(":NvimTmuxNavigateRight") ~= 0 then
		vim.cmd.NvimTmuxNavigateRight()
	else
		vim.cmd.wincmd("l")
	end
end, { desc = "Navigate right (tmux-aware)" })

-- Splits --
map("n", "<leader>sv", "<Cmd>vsplit<CR>", { desc = "Split vertically" })
map("n", "<leader>sh", "<Cmd>split<CR>", { desc = "Split horizontally" })
map("n", "<leader>se", "<C-w>=", { desc = "Equalize split sizes" })
map("n", "<leader>sx", "<Cmd>close<CR>", { desc = "Close current split" })

-- Resize splits with arrow keys
map("n", "<C-Up>", "<Cmd>resize +2<CR>", { desc = "Increase window height" })
map("n", "<C-Down>", "<Cmd>resize -2<CR>", { desc = "Decrease window height" })
map("n", "<C-Left>", "<Cmd>vertical resize -2<CR>", { desc = "Decrease window width" })
map("n", "<C-Right>", "<Cmd>vertical resize +2<CR>", { desc = "Increase window width" })

-- Buffers --
map("n", "<Tab>", "<Cmd>bnext<CR>", { desc = "Next buffer" })
map("n", "<S-Tab>", "<Cmd>bprevious<CR>", { desc = "Previous buffer" })
map("n", "<leader>'", "<C-^>", { desc = "Switch to last buffer" })

-- Search --
map({ "n", "i" }, "<Esc>", "<Cmd>noh<CR><Esc>", { desc = "Clear search highlight" })
map("n", "<leader>nh", "<Cmd>noh<CR>", { desc = "Clear search highlight" })

-- Quick find/replace word under cursor
-- S replaces native substitute line — more useful for daily workflow
map("n", "S", function()
	local cmd = ":%s/<C-r><C-w>/<C-r><C-w>/gI<Left><Left><Left>"
	local keys = vim.api.nvim_replace_termcodes(cmd, true, false, true)
	vim.api.nvim_feedkeys(keys, "n", false)
end, { desc = "Find/replace word under cursor" })

-- Editing --
-- Join lines without moving cursor position
map("n", "J", "mzJ`z", { desc = "Join lines (keep cursor position)" })

-- Move selected lines up/down in visual mode
map("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
map("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

-- Indent and reselect visual block
map("v", "<", "<gv", { desc = "Indent left and reselect" })
map("v", ">", ">gv", { desc = "Indent right and reselect" })

-- Redo with U (more intuitive than <C-r>)
map("n", "U", "<C-r>", { desc = "Redo" })

-- Clipboard --
-- Paste over selection without overwriting unnamed register
-- clipboard = "unnamed,unnamedplus" already syncs vim with system clipboard
map("x", "<leader>p", '"_dP', { desc = "Paste without overwriting register" })
map("v", "p", '"_dp', { desc = "Paste without overwriting register" })

-- x to black hole — won't replace clipboard content
map("n", "x", '"_x', { desc = "Delete char without yanking" })

-- LSP keymaps --
-- Called from lsp on_attach — keymaps are buffer-local
local M = {}

M.map_lsp_keybinds = function(buffer_number)
	local opts = function(desc)
		return { buffer = buffer_number, desc = desc }
	end

	-- Go to --
	map("n", "gd", vim.lsp.buf.definition, opts("LSP: Go to definition"))
	map("n", "gD", vim.lsp.buf.declaration, opts("LSP: Go to declaration"))
	map("n", "gi", vim.lsp.buf.implementation, opts("LSP: Go to implementation"))
	map("n", "gr", vim.lsp.buf.references, opts("LSP: Go to references"))
	map("n", "td", vim.lsp.buf.type_definition, opts("LSP: Go to type definition"))

	-- Hover / Signature --
	-- nvim 0.11+ accepts options directly in hover() and signature_help()
	map("n", "K", function()
		vim.lsp.buf.hover({ border = "rounded" })
	end, opts("LSP: Hover documentation"))

	map("i", "<C-k>", function()
		vim.lsp.buf.signature_help({ border = "rounded" })
	end, opts("LSP: Signature help"))

	-- Code --
	map({ "n", "v" }, "<leader>la", vim.lsp.buf.code_action, opts("LSP: Code action"))
	map("n", "<leader>lr", vim.lsp.buf.rename, opts("LSP: Rename symbol"))
	map("n", "<leader>lf", function()
		require("conform").format({ async = true, lsp_format = "fallback" })
	end, opts("LSP: Format buffer"))

	-- Toggle inlay hints (nvim 0.11+)
	map("n", "<leader>li", function()
		vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({}))
	end, opts("LSP: Toggle inlay hints"))

	-- Diagnostics --
	-- nvim 0.11+ vim.diagnostic.jump() replaces goto_next/prev
	map("n", "]d", function()
		vim.diagnostic.jump({ count = 1, float = false })
		vim.api.nvim_feedkeys("zz", "n", false)
	end, opts("LSP: Next diagnostic (centered)"))

	map("n", "[d", function()
		vim.diagnostic.jump({ count = -1, float = false })
		vim.api.nvim_feedkeys("zz", "n", false)
	end, opts("LSP: Previous diagnostic (centered)"))

	map("n", "]e", function()
		vim.diagnostic.jump({ count = 1, severity = vim.diagnostic.severity.ERROR, float = false })
		vim.api.nvim_feedkeys("zz", "n", false)
	end, opts("LSP: Next error (centered)"))

	map("n", "[e", function()
		vim.diagnostic.jump({ count = -1, severity = vim.diagnostic.severity.ERROR, float = false })
		vim.api.nvim_feedkeys("zz", "n", false)
	end, opts("LSP: Previous error (centered)"))

	map("n", "]w", function()
		vim.diagnostic.jump({ count = 1, severity = vim.diagnostic.severity.WARN, float = false })
		vim.api.nvim_feedkeys("zz", "n", false)
	end, opts("LSP: Next warning (centered)"))

	map("n", "[w", function()
		vim.diagnostic.jump({ count = -1, severity = vim.diagnostic.severity.WARN, float = false })
		vim.api.nvim_feedkeys("zz", "n", false)
	end, opts("LSP: Previous warning (centered)"))

	map("n", "<leader>ld", function()
		vim.diagnostic.open_float({ border = "rounded" })
	end, opts("LSP: Open diagnostic float"))

	map("n", "<leader>lq", vim.diagnostic.setqflist, opts("LSP: Diagnostics to quickfix"))
end
