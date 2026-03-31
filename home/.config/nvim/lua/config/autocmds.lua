-- ================================================================================================
-- TITLE : NeoVim autocmds
-- ABOUT : Core autocommands — no plugin dependencies
--         Plugin-specific autocmds are defined in their respective plugin file
-- ================================================================================================

-- Helper --
local function augroup(name)
	return vim.api.nvim_create_augroup("custom_" .. name, { clear = true })
end

-- Highlight yank --
-- Briefly highlights yanked text — visual feedback for y/Y/yy
vim.api.nvim_create_autocmd("TextYankPost", {
	group = augroup("highlight_yank"),
	pattern = "*",
	desc = "Highlight yanked text",
	callback = function()
		vim.hl.on_yank({ higroup = "IncSearch", timeout = 200 })
	end,
})

-- Restore cursor position --
-- When reopening a file, cursor returns to last known position
vim.api.nvim_create_autocmd("BufReadPost", {
	group = augroup("restore_cursor"),
	desc = "Restore last cursor position on file open",
	callback = function()
		local mark = vim.api.nvim_buf_get_mark(0, '"')
		local lcount = vim.api.nvim_buf_line_count(0)
		if mark[1] > 0 and mark[1] <= lcount then
			pcall(vim.api.nvim_win_set_cursor, 0, mark)
		end
	end,
})

-- Equalize splits on resize --
-- When terminal window is resized, all splits are equalized automatically
vim.api.nvim_create_autocmd("VimResized", {
	group = augroup("resize_splits"),
	desc = "Equalize splits when terminal is resized",
	callback = function()
		vim.cmd("tabdo wincmd =")
	end,
})

-- Help in vertical split --
-- Opens :help in a vertical split on the right instead of horizontal
-- Much more readable on wide screens
vim.api.nvim_create_autocmd("FileType", {
	group = augroup("vertical_help"),
	pattern = "help",
	desc = "Open help in vertical split",
	callback = function()
		vim.bo.bufhidden = "unload"
		vim.cmd.wincmd("L")
		vim.cmd.wincmd("=")
	end,
})

-- Close some filetypes with q --
-- Lets you close utility windows (help, quickfix, etc.) with just q
vim.api.nvim_create_autocmd("FileType", {
	group = augroup("close_with_q"),
	pattern = {
		"help",
		"lspinfo",
		"man",
		"notify",
		"qf",
		"startuptime",
		"checkhealth",
	},
	desc = "Close utility windows with q",
	callback = function(event)
		vim.bo[event.buf].buflisted = false
		vim.keymap.set("n", "q", "<Cmd>close<CR>", {
			buffer = event.buf,
			silent = true,
			desc = "Close window",
		})
	end,
})

-- Remove trailing whitespace on save --
-- Keeps files clean without needing a formatter
vim.api.nvim_create_autocmd("BufWritePre", {
	group = augroup("trim_whitespace"),
	pattern = "*",
	desc = "Remove trailing whitespace on save",
	callback = function()
		local pos = vim.api.nvim_win_get_cursor(0)
		vim.cmd([[%s/\s\+$//e]])
		vim.api.nvim_win_set_cursor(0, pos)
	end,
})
