local opt = vim.opt
local g = vim.g

-- Leader keys (set BEFORE lazy loads plugins)
g.mapleader = " "
g.maplocalleader = "\\"

-- ── UI ──────────────────────────────────────────────────────
opt.number = true
opt.relativenumber = true
opt.signcolumn = "yes" -- always show gutter
opt.cursorline = true
opt.termguicolors = true
opt.showmode = false -- shown in statusline instead
opt.laststatus = 3 -- global statusline
opt.cmdheight = 1
opt.scrolloff = 8
opt.sidescrolloff = 8
opt.wrap = false
opt.colorcolumn = "100"
opt.splitright = true
opt.splitbelow = true
opt.conceallevel = 2 -- for markdown, noice, etc.
opt.pumheight = 12 -- completion popup max height
opt.pumblend = 5 -- slight transparency for popup
opt.winblend = 5

-- ── Editing ─────────────────────────────────────────────────
opt.expandtab = true
opt.tabstop = 4
opt.shiftwidth = 4
opt.softtabstop = 4
opt.smartindent = true
opt.shiftround = true
opt.breakindent = true

-- ── Search ──────────────────────────────────────────────────
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true
opt.incsearch = true
opt.inccommand = "split" -- live preview for :s/

-- ── Files & Undo ────────────────────────────────────────────
opt.undofile = true
opt.undolevels = 10000
opt.swapfile = false
opt.backup = false
opt.autowrite = true -- save before :make, gd, etc.

-- ── Performance ─────────────────────────────────────────────
opt.updatetime = 200 -- faster CursorHold events (LSP hover, etc.)
opt.timeoutlen = 300 -- which-key popup delay
opt.ttimeoutlen = 10

-- ── Clipboard ───────────────────────────────────────────────
opt.clipboard = "unnamedplus" -- sync with system clipboard

-- ── Folds (using ufo plugin) ────────────────────────────────
opt.foldcolumn = "1"
opt.foldlevel = 99
opt.foldlevelstart = 99
opt.foldenable = true
opt.fillchars = {
  foldopen = "v", -- Try using simpler characters
  foldclose = ">",
  fold = " ",
  diff = "╱",
  eob = " ",
}

-- ── Misc ────────────────────────────────────────────────────
opt.mouse = "a"
opt.virtualedit = "block" -- free-move in visual block mode
opt.formatoptions = "jcroqlnt" -- sensible auto-formatting
opt.spelllang = { "en" }
opt.shortmess:append("WIcC")
opt.sessionoptions = { "buffers", "curdir", "folds", "help", "tabpages", "winsize", "terminal" }

-- ── Neovim 0.10+ defaults (keep explicit for clarity) ───────
opt.smoothscroll = true
