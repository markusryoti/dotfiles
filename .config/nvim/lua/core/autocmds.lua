local au = vim.api.nvim_create_autocmd
local aug = vim.api.nvim_create_augroup

-- ── Highlight on yank ───────────────────────────────────────
au("TextYankPost", {
  group = aug("highlight_yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = 150 })
  end,
})

-- ── Restore cursor position ─────────────────────────────────
au("BufReadPost", {
  group = aug("restore_cursor", { clear = true }),
  callback = function(ev)
    local mark = vim.api.nvim_buf_get_mark(ev.buf, '"')
    local line_count = vim.api.nvim_buf_line_count(ev.buf)
    if mark[1] > 0 and mark[1] <= line_count then
      vim.api.nvim_win_set_cursor(0, mark)
    end
  end,
})

-- ── Resize splits on window resize ──────────────────────────
au("VimResized", {
  group = aug("resize_splits", { clear = true }),
  callback = function()
    vim.cmd("tabdo wincmd =")
  end,
})

-- ── Close certain windows with <q> ──────────────────────────
au("FileType", {
  group = aug("close_with_q", { clear = true }),
  pattern = { "help", "qf", "lspinfo", "man", "checkhealth", "query", "notify", "startuptime" },
  callback = function(ev)
    vim.bo[ev.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<CR>", { buffer = ev.buf, silent = true })
  end,
})

-- ── Auto-create missing dirs on save ────────────────────────
au("BufWritePre", {
  group = aug("auto_create_dir", { clear = true }),
  callback = function(ev)
    local file = vim.uv.fs_realpath(ev.match) or ev.match
    vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
  end,
})

-- ── Language-specific indentation ───────────────────────────
au("FileType", {
  group = aug("lang_indent", { clear = true }),
  pattern = {
    "javascript",
    "typescript",
    "typescriptreact",
    "javascriptreact",
    "json",
    "yaml",
    "html",
    "css",
    "scss",
    "lua",
  },
  callback = function()
    vim.opt_local.tabstop = 2
    vim.opt_local.shiftwidth = 2
    vim.opt_local.softtabstop = 2
  end,
})

-- ── Spell-check in text/markdown ────────────────────────────
au("FileType", {
  group = aug("spell_check", { clear = true }),
  pattern = { "markdown", "gitcommit", "text" },
  callback = function()
    vim.opt_local.spell = true
  end,
})

-- ── Terminal: no line numbers, enter insert ─────────────────
au({ "TermOpen", "BufEnter" }, {
  group = aug("terminal_settings", { clear = true }),
  pattern = "term://*",
  callback = function()
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
    vim.opt_local.signcolumn = "no"
    vim.cmd("startinsert")
  end,
})

-- ── Go: use tabs (gofmt standard) ───────────────────────────
au("FileType", {
  group = aug("go_tabs", { clear = true }),
  pattern = "go",
  callback = function()
    vim.opt_local.expandtab = false
    vim.opt_local.tabstop = 4
    vim.opt_local.shiftwidth = 4
  end,
})
