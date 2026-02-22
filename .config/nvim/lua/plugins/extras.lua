-- ┌─────────────────────────────────────────┐
-- │             plugins/extras.lua          │
-- └─────────────────────────────────────────┘

return {

  -- ── Go extras (gopher.nvim) ─────────────────────────────────
  {
    "olexsmir/gopher.nvim",
    ft = "go",
    build = function()
      vim.cmd("GoInstallDeps")
    end,
    config = true,
    keys = {
      { "<leader>cgt", "<cmd>GoTagAdd json<CR>", ft = "go", desc = "Add JSON struct tags" },
      { "<leader>cgT", "<cmd>GoTagRm json<CR>", ft = "go", desc = "Remove JSON struct tags" },
      { "<leader>cge", "<cmd>GoIfErr<CR>", ft = "go", desc = "Add if err check" },
      { "<leader>cgm", "<cmd>GoMod tidy<CR>", ft = "go", desc = "go mod tidy" },
      { "<leader>cgi", "<cmd>GoImpl<CR>", ft = "go", desc = "Implement interface" },
    },
  },

  -- ── Crates.nvim (Rust dependency management) ─────────────────
  {
    "saecki/crates.nvim",
    event = { "BufRead Cargo.toml" },
    opts = {
      lsp = {
        enabled = true,
        on_attach = function() end,
        actions = true,
        completion = true,
        hover = true,
      },
    },
  },

  -- ── TypeScript extras (type-check, tsserver utilities) ───────
  {
    "dmmulroy/ts-error-translator.nvim", -- human-readable TS errors
    ft = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
    config = true,
  },

  -- ── Package.json dependency helper ──────────────────────────
  {
    "vuki656/package-info.nvim",
    dependencies = "MunifTanjim/nui.nvim",
    ft = "json",
    config = true,
    keys = {
      {
        "<leader>cns",
        function()
          require("package-info").show()
        end,
        ft = "json",
        desc = "Show npm package info",
      },
      {
        "<leader>cnd",
        function()
          require("package-info").delete()
        end,
        ft = "json",
        desc = "Delete package",
      },
      {
        "<leader>cnu",
        function()
          require("package-info").update()
        end,
        ft = "json",
        desc = "Update package",
      },
      {
        "<leader>cni",
        function()
          require("package-info").install()
        end,
        ft = "json",
        desc = "Install package",
      },
      {
        "<leader>cnv",
        function()
          require("package-info").change_version()
        end,
        ft = "json",
        desc = "Change package version",
      },
    },
  },

  -- ── CSV/data files ──────────────────────────────────────────
  {
    "hat0uma/csvview.nvim",
    cmd = { "CsvViewEnable", "CsvViewDisable", "CsvViewToggle" },
    opts = { parser = { async = true } },
    keys = {
      { "<leader>uC", "<cmd>CsvViewToggle<CR>", desc = "Toggle CSV view" },
    },
  },

  -- ── Markdown preview ────────────────────────────────────────
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
    keys = {
      { "<leader>mp", "<cmd>MarkdownPreviewToggle<CR>", ft = "markdown", desc = "Toggle markdown preview" },
    },
  },

  -- ── REST client (like Postman inside nvim) ───────────────────
  {
    "mistweaverco/kulala.nvim",
    ft = "http",
    keys = {
      {
        "<leader>Rs",
        function()
          require("kulala").run()
        end,
        ft = "http",
        desc = "Send HTTP request",
      },
      {
        "<leader>Ra",
        function()
          require("kulala").run_all()
        end,
        ft = "http",
        desc = "Send all HTTP requests",
      },
    },
    opts = {},
  },

  -- ── Outline / Symbol tree ───────────────────────────────────
  {
    "hedyhli/outline.nvim",
    cmd = { "Outline", "OutlineOpen" },
    keys = { { "<leader>co", "<cmd>Outline<CR>", desc = "Toggle symbol outline" } },
    opts = {
      outline_window = { width = 30, relative_width = false },
    },
  },

  -- ── Tailwind colorizer ──────────────────────────────────────
  {
    "roobert/tailwindcss-colorizer-cmp.nvim",
    ft = { "html", "css", "scss", "typescriptreact", "javascriptreact" },
    config = true,
  },

  -- ── Git blame (floating window) ─────────────────────────────
  {
    "f-person/git-blame.nvim",
    event = "VeryLazy",
    opts = { enabled = false, delay = 300, date_format = "%Y-%m-%d" },
    keys = {
      { "<leader>gbl", "<cmd>GitBlameToggle<CR>", desc = "Toggle git blame" },
      { "<leader>gbo", "<cmd>GitBlameOpenCommitURL<CR>", desc = "Open commit URL" },
      { "<leader>gbO", "<cmd>GitBlameOpenFileURL<CR>", desc = "Open file URL" },
      { "<leader>gbC", "<cmd>GitBlameCopyCommitURL<CR>", desc = "Copy commit URL" },
    },
  },

  {
    "alexghergh/nvim-tmux-navigation",
    event = "VeryLazy",
    opts = { disable_when_zoomed = true },
    keys = {
      {
        "<C-h>",
        function()
          require("nvim-tmux-navigation").NvimTmuxNavigateLeft()
        end,
      },
      {
        "<C-j>",
        function()
          require("nvim-tmux-navigation").NvimTmuxNavigateDown()
        end,
      },
      {
        "<C-k>",
        function()
          require("nvim-tmux-navigation").NvimTmuxNavigateUp()
        end,
      },
      {
        "<C-l>",
        function()
          require("nvim-tmux-navigation").NvimTmuxNavigateRight()
        end,
      },
    },
  },
}
