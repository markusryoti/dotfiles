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
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
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
        },
        auto_install = true,
        highlight = { enable = true, additional_vim_regex_highlighting = { "ruby" } },
        indent = { enable = true },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "<C-space>",
            node_incremental = "<C-space>",
            scope_incremental = false,
            node_decremental = "<bs>",
          },
        },
        textobjects = {
          select = {
            enable = true,
            lookahead = true,
            keymaps = {
              ["af"] = { query = "@function.outer", desc = "Around function" },
              ["if"] = { query = "@function.inner", desc = "Inner function" },
              ["ac"] = { query = "@class.outer", desc = "Around class" },
              ["ic"] = { query = "@class.inner", desc = "Inner class" },
              ["aa"] = { query = "@parameter.outer", desc = "Around argument" },
              ["ia"] = { query = "@parameter.inner", desc = "Inner argument" },
              ["ai"] = { query = "@conditional.outer", desc = "Around conditional" },
              ["ii"] = { query = "@conditional.inner", desc = "Inner conditional" },
              ["al"] = { query = "@loop.outer", desc = "Around loop" },
              ["il"] = { query = "@loop.inner", desc = "Inner loop" },
              ["ab"] = { query = "@block.outer", desc = "Around block" },
              ["ib"] = { query = "@block.inner", desc = "Inner block" },
            },
          },
          move = {
            enable = true,
            set_jumps = true,
            goto_next_start = { ["]f"] = "@function.outer", ["]c"] = "@class.outer" },
            goto_next_end = { ["]F"] = "@function.outer", ["]C"] = "@class.outer" },
            goto_previous_start = { ["[f"] = "@function.outer", ["[c"] = "@class.outer" },
            goto_previous_end = { ["[F"] = "@function.outer", ["[C"] = "@class.outer" },
          },
          swap = {
            enable = true,
            swap_next = { ["<leader>cna"] = "@parameter.inner" },
            swap_previous = { ["<leader>cpa"] = "@parameter.inner" },
          },
        },
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
