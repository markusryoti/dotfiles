return {
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
      {
        "<leader>cf",
        function()
          require("conform").format({ async = true, lsp_fallback = true })
        end,
        desc = "Format buffer",
      },
    },
    opts = {
      formatters_by_ft = {
        go = { "goimports", "gofumpt" },
        rust = { "rustfmt" },
        python = { "ruff_format", "ruff_organize_imports" },
        typescript = { "prettierd", "prettier" },
        javascript = { "prettierd", "prettier" },
        typescriptreact = { "prettierd", "prettier" },
        javascriptreact = { "prettierd", "prettier" },
        json = { "prettierd", "prettier" },
        yaml = { "prettierd", "prettier" },
        markdown = { "prettierd", "prettier" },
        html = { "prettierd", "prettier" },
        css = { "prettierd", "prettier" },
        scss = { "prettierd", "prettier" },
        lua = { "stylua" },
        sh = { "shfmt" },
        toml = { "taplo" },
        sql = { "sqlfmt" },
        ["_"] = { "trim_whitespace" }, -- fallback for all others
      },
      -- Format on save
      format_on_save = function(bufnr)
        -- Disable for certain filetypes or if a variable is set
        if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
          return
        end
        return { timeout_ms = 3000, lsp_fallback = true }
      end,
      formatters = {
        stylua = {
          prepend_args = { "--indent-type", "Spaces", "--indent-width", "2" },
        },
        shfmt = {
          prepend_args = { "-i", "2", "-ci" },
        },
      },
    },
    init = function()
      -- Toggle format on save
      vim.api.nvim_create_user_command("FormatToggle", function(args)
        local is_global = not args.bang
        if is_global then
          vim.g.disable_autoformat = not vim.g.disable_autoformat
          vim.notify(
            "Format on save " .. (vim.g.disable_autoformat and "disabled" or "enabled") .. " (global)",
            vim.log.levels.INFO
          )
        else
          vim.b.disable_autoformat = not vim.b.disable_autoformat
          vim.notify(
            "Format on save " .. (vim.b.disable_autoformat and "disabled" or "enabled") .. " (buffer)",
            vim.log.levels.INFO
          )
        end
      end, { bang = true, desc = "Toggle autoformat-on-save" })

      vim.keymap.set("n", "<leader>uf", "<cmd>FormatToggle<CR>", { desc = "Toggle format on save (global)" })
      vim.keymap.set("n", "<leader>uF", "<cmd>FormatToggle!<CR>", { desc = "Toggle format on save (buffer)" })
    end,
  },

  -- ── mason-conform (auto install formatters) ─────────────────
  {
    "zapling/mason-conform.nvim",
    dependencies = { "mason-org/mason.nvim", "stevearc/conform.nvim" },
    event = "VeryLazy",
    opts = {
      ensure_installed = {
        "goimports",
        "gofumpt",
        "rustfmt",
        "ruff",
        "prettierd",
        "stylua",
        "shfmt",
        "taplo",
      },
    },
  },
}
