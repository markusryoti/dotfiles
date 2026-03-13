return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile", "BufWritePre", "VeryLazy" },
    cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
      "nvim-treesitter/nvim-treesitter-context",
      "windwp/nvim-ts-autotag",
    },
    config = function()
      require("nvim-treesitter").setup({
        install_dir = vim.fn.stdpath("data") .. "/site",
      })

      require("nvim-treesitter").install({
        "go",
        "gomod",
        "gosum",
        "gowork",
        "rust",
        "python",
        "typescript",
        "javascript",
        "tsx",
        "jsdoc",
        "lua",
        "luadoc",
        "luap",
        "json",
        "jsonc",
        "yaml",
        "toml",
        "markdown",
        "markdown_inline",
        "bash",
        "html",
        "css",
        "dockerfile",
        "regex",
        "vim",
        "vimdoc",
        "git_config",
        "gitcommit",
        "gitignore",
        "sql",
        "proto",
      })

      vim.api.nvim_create_autocmd("FileType", {
        callback = function()
          local ok = pcall(vim.treesitter.start)
        end,
      })
    end,
  },

  -- ── Treesitter context (sticky header) ──────────────────────
  {
    "nvim-treesitter/nvim-treesitter-context",
    event = { "BufReadPost", "BufNewFile" },
    opts = { mode = "cursor", max_lines = 3 },
    keys = {
      { "<leader>ut", "<cmd>TSContextToggle<CR>", desc = "Toggle TS context" },
    },
  },

  -- ── Auto-close HTML/JSX tags ────────────────────────────────
  {
    "windwp/nvim-ts-autotag",
    event = { "BufReadPost", "BufNewFile" },
    opts = {},
  },
}
