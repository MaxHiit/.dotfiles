-- ================================================================================================
-- TITLE : NeoVim options
-- ABOUT : Core editor settings — behavior, UI, indentation, search, folding
-- ================================================================================================

local arrows = require("icons").arrows

-- Leader --
-- Must be set before lazy.nvim loads to ensure correct keymaps
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Line numbers --
vim.opt.number = true -- Show absolute line number on current line
vim.opt.relativenumber = true -- Show relative numbers on all other lines

-- Indentation --
vim.opt.tabstop = 2 -- A tab character = 2 spaces visually
vim.opt.softtabstop = 2 -- Pressing Tab in insert mode = 2 spaces
vim.opt.shiftwidth = 2 -- Auto-indent uses 2 spaces (<<, >>, =)
vim.opt.expandtab = true -- Always insert spaces, never tab characters
vim.opt.smartindent = true -- Auto-indent new lines based on context
vim.opt.breakindent = true -- Wrapped lines keep their indentation level

-- Search --
vim.opt.ignorecase = true -- Case-insensitive search by default
vim.opt.smartcase = true -- Switch to case-sensitive if query has uppercase
vim.opt.incsearch = true -- Show matches incrementally as you type
vim.opt.hlsearch = true -- Keep search results highlighted after search

-- Clipboard --
-- Sync vim registers with system clipboard
-- y/d/p in vim = copy/cut/paste from/to system clipboard
vim.opt.clipboard = "unnamed,unnamedplus"

-- UI --
vim.opt.termguicolors = true -- Enable 24-bit RGB colors
vim.opt.cursorline = true -- Highlight the line where the cursor is
vim.opt.signcolumn = "yes" -- Always show sign column (git signs, diagnostics)
vim.opt.showmode = false -- Hide "-- INSERT --" (statusline shows it instead)
vim.opt.wrap = false -- Don't wrap long lines
vim.opt.scrolloff = 8 -- Keep 8 lines visible above/below cursor
vim.opt.sidescrolloff = 8 -- Keep 8 columns visible left/right of cursor
vim.opt.colorcolumn = "80" -- Show a vertical guide at column 80
vim.opt.pumheight = 10 -- Max height for completion popup menu
vim.opt.winborder = "rounded" -- Rounded borders on all floating windows (nvim 0.11+)
vim.opt.winbar = ""

-- Cursor shape --
-- Different cursor shapes per mode — visual feedback for current mode
vim.opt.guicursor = {
	"n-v-c:block", -- Normal / Visual / Command : block
	"i-ci-ve:ver25", -- Insert : vertical bar (25% width)
	"r-cr:hor20", -- Replace : horizontal bar (20% height)
	"o:hor50", -- Operator-pending : horizontal bar (50%)
	"a:blinkwait700-blinkoff400-blinkon250", -- All modes : blinking settings
	"sm:block-blinkwait175-blinkoff150-blinkon175", -- Showmatch : block with blink
}

-- Splits --
vim.opt.splitbelow = true -- Horizontal split opens below current window
vim.opt.splitright = true -- Vertical split opens to the right

-- Files --
vim.opt.autoread = true -- Auto-reload file if changed outside neovim
vim.opt.confirm = true -- Ask confirmation before closing unsaved buffer
vim.opt.swapfile = false -- No .swp files (use git instead)
vim.opt.backup = false -- No backup files before overwriting
vim.opt.undofile = true -- Persistent undo — survives file close/reopen

-- Create undo directory if it doesn't exist
local undodir = vim.fn.expand("~/.local/share/nvim/undodir")
if vim.fn.isdirectory(undodir) == 0 then
	vim.fn.mkdir(undodir, "p")
end
vim.opt.undodir = undodir

-- Performance --
vim.opt.updatetime = 250 -- Faster CursorHold events (default 4000ms)
vim.opt.timeoutlen = 500 -- Time to wait for mapped key sequence (ms)
vim.opt.ttimeoutlen = 0 -- No delay for key code sequences

-- Diff --
vim.opt.diffopt:append("vertical") -- Diff opens in vertical splits
vim.opt.diffopt:append("algorithm:patience") -- Better diff algorithm
vim.opt.diffopt:append("linematch:60") -- Smarter line matching in diffs

-- Completion --
vim.opt.completeopt = { "menu", "menuone", "noselect" }

-- Mouse --
vim.opt.mouse = "a" -- Enable mouse in all modes
vim.opt.mousescroll = "ver:3,hor:0" -- Vertical scroll only — no horizontal

-- Folding --
-- Folding — native nvim 0.11 with treesitter
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldlevel = 99
vim.opt.foldcolumn = "1"
vim.opt.foldlevelstart = 99

vim.opt.fillchars = {
	eob = " ",
	fold = " ",
	foldopen = arrows.down,
	foldclose = arrows.right,
	foldsep = " ",
	foldinner = " ",
	msgsep = "─",
}

_G.MyFoldText = function()
	local line = vim.fn.getline(vim.v.foldstart)
	local count = vim.v.foldend - vim.v.foldstart
	return line .. "  ··· " .. count .. " lines"
end

-- Custom foldtext — same render as nvim-ufo
-- Shows first line with syntax + ··· N lines
-- vim.opt.foldtext = "v:lua.MyFoldText()"

-- Misc --
vim.opt.encoding = "UTF-8" -- Default file encoding
vim.opt.errorbells = false -- No sound on errors
vim.opt.backspace = "indent,eol,start" -- Backspace works naturally in insert mode
vim.opt.iskeyword:append("-") -- Treat dash-separated-words as one word
vim.opt.inccommand = "split" -- Live preview of :s substitutions in a split
