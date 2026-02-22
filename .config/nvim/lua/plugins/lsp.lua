return {

  -- ── Mason: LSP/DAP/Linter installer ─────────────────────────
  {
    "mason-org/mason.nvim",
    cmd = "Mason",
    build = ":MasonUpdate",
    opts = {
      ui = {
        border = "rounded",
        icons = { package_installed = "✓", package_pending = "➜", package_uninstalled = "✗" },
      },
    },
  },

  -- ── mason-lspconfig bridge ──────────────────────────────────
  {
    "mason-org/mason-lspconfig.nvim",
    dependencies = {
      "mason-org/mason.nvim",
      "neovim/nvim-lspconfig",
    },
    opts = {
      -- auto-install these servers
      ensure_installed = {
        "gopls", -- Go
        "rust_analyzer", -- Rust (or use rustaceanvim instead)
        "pyright", -- Python (fast Microsoft server)
        "ruff", -- Python linter/formatter as LSP
        "ts_ls", -- TypeScript/JavaScript
        "eslint", -- TS/JS linting
        "lua_ls", -- Lua (for editing this config)
        "jsonls", -- JSON
        "yamlls", -- YAML
        "taplo", -- TOML
        "bashls", -- Bash
        "marksman", -- Markdown
        "docker_compose_language_service",
        "dockerls",
      },
    },
  },

  -- ── nvim-lspconfig ──────────────────────────────────────────
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "mason-org/mason.nvim",
      "mason-org/mason-lspconfig.nvim",
      "saghen/blink.cmp", -- capabilities
      -- { "folke/neodev.nvim", opts = {} }, -- nvim Lua API completions
    },
    config = function()
      -- Diagnostics UI
      vim.diagnostic.config({
        underline = true,
        update_in_insert = false,
        severity_sort = true,
        float = { border = "rounded", source = "if_many" },
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = " ",
            [vim.diagnostic.severity.WARN] = " ",
            [vim.diagnostic.severity.HINT] = "󰠠 ",
            [vim.diagnostic.severity.INFO] = " ",
          },
        },
        virtual_text = {
          spacing = 4,
          source = "if_many",
          prefix = "●",
        },
      })

      -- Rounded borders for hover/signature
      local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
      function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
        opts = opts or {}
        opts.border = opts.border or "rounded"
        return orig_util_open_floating_preview(contents, syntax, opts, ...)
      end

      -- Keymaps on LSP attach
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("lsp_attach_keymaps", { clear = true }),
        callback = function(ev)
          local map = vim.keymap.set
          local buf = ev.buf
          local bopts = { buffer = buf }

          map("n", "gd", vim.lsp.buf.definition, vim.tbl_extend("force", bopts, { desc = "Go to definition" }))
          map("n", "gD", vim.lsp.buf.declaration, vim.tbl_extend("force", bopts, { desc = "Go to declaration" }))
          map("n", "gr", "<cmd>Telescope lsp_references<CR>", vim.tbl_extend("force", bopts, { desc = "References" }))
          map(
            "n",
            "gI",
            "<cmd>Telescope lsp_implementations<CR>",
            vim.tbl_extend("force", bopts, { desc = "Implementations" })
          )
          map(
            "n",
            "gy",
            "<cmd>Telescope lsp_type_definitions<CR>",
            vim.tbl_extend("force", bopts, { desc = "Type definitions" })
          )
          map("n", "K", vim.lsp.buf.hover, vim.tbl_extend("force", bopts, { desc = "Hover docs" }))
          map("n", "gK", vim.lsp.buf.signature_help, vim.tbl_extend("force", bopts, { desc = "Signature help" }))
          map("i", "<C-k>", vim.lsp.buf.signature_help, vim.tbl_extend("force", bopts, { desc = "Signature help" }))
          map("n", "<leader>cr", vim.lsp.buf.rename, vim.tbl_extend("force", bopts, { desc = "Rename symbol" }))
          map(
            { "n", "v" },
            "<leader>ca",
            vim.lsp.buf.code_action,
            vim.tbl_extend("force", bopts, { desc = "Code action" })
          )
          map("n", "<leader>cf", function()
            vim.lsp.buf.format({ async = true })
          end, vim.tbl_extend("force", bopts, { desc = "Format buffer" }))
          map("n", "<leader>cl", "<cmd>LspInfo<CR>", vim.tbl_extend("force", bopts, { desc = "LSP info" }))
          map(
            "n",
            "<leader>cws",
            "<cmd>Telescope lsp_workspace_symbols<CR>",
            vim.tbl_extend("force", bopts, { desc = "Workspace symbols" })
          )
          map(
            "n",
            "<leader>cds",
            "<cmd>Telescope lsp_document_symbols<CR>",
            vim.tbl_extend("force", bopts, { desc = "Document symbols" })
          )

          -- Inlay hints toggle (Neovim 0.10+)
          local client = vim.lsp.get_client_by_id(ev.data.client_id)
          if client and client.supports_method("textDocument/inlayHint") then
            map("n", "<leader>uh", function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = buf }), { bufnr = buf })
            end, vim.tbl_extend("force", bopts, { desc = "Toggle inlay hints" }))
          end
        end,
      })

      -- Capabilities (from blink.cmp)
      local capabilities = require("blink.cmp").get_lsp_capabilities()
      -- local lspconfig = require("lspconfig")

      -- Disable and use Rustaceanvim
      vim.lsp.enable("rust_analyzer", false)

      -- ── Go ─────────────────────────────────────────────────
      vim.lsp.config("gopls", {
        capabilities = capabilities,
        settings = {
          gopls = {
            gofumpt = true,
            codelenses = {
              gc_details = false,
              generate = true,
              regenerate_cgo = true,
              run_govulncheck = true,
              test = true,
              tidy = true,
              upgrade_dependency = true,
              vendor = true,
            },
            hints = {
              assignVariableTypes = true,
              compositeLiteralFields = true,
              compositeLiteralTypes = true,
              constantValues = true,
              functionTypeParameters = true,
              parameterNames = true,
              rangeVariableTypes = true,
            },
            analyses = { fieldalignment = true, nilness = true, unusedparams = true, unusedwrite = true, useany = true },
            usePlaceholders = true,
            completeUnimported = true,
            staticcheck = true,
            directoryFilters = { "-.git", "-.vscode", "-.idea", "-.venv", "-node_modules" },
            semanticTokens = true,
          },
        },
      })

      -- ── Python ─────────────────────────────────────────────
      vim.lsp.config("pyright", {
        capabilities = capabilities,
        settings = {
          pyright = { disableOrganizeImports = true }, -- ruff handles this
          python = {
            analysis = {
              autoSearchPaths = true,
              diagnosticMode = "openFilesOnly",
              useLibraryCodeForTypes = true,
              typeCheckingMode = "standard",
            },
          },
        },
      })

      vim.lsp.config("ruff", {
        capabilities = capabilities,
        on_attach = function(client)
          -- Disable hover in favor of pyright
          client.server_capabilities.hoverProvider = false
        end,
      })

      -- ── TypeScript ─────────────────────────────────────────
      vim.lsp.config("ts_ls", {
        capabilities = capabilities,
        settings = {
          typescript = {
            inlayHints = {
              includeInlayParameterNameHints = "all",
              includeInlayParameterNameHintsWhenArgumentMatchesName = false,
              includeInlayFunctionParameterTypeHints = true,
              includeInlayVariableTypeHints = false,
              includeInlayPropertyDeclarationTypeHints = true,
              includeInlayFunctionLikeReturnTypeHints = true,
              includeInlayEnumMemberValueHints = true,
            },
          },
          javascript = {
            inlayHints = {
              includeInlayParameterNameHints = "all",
              includeInlayFunctionParameterTypeHints = true,
              includeInlayVariableTypeHints = false,
              includeInlayFunctionLikeReturnTypeHints = true,
            },
          },
        },
      })

      vim.lsp.config("eslint", {
        capabilities = capabilities,
        on_attach = function(_, bufnr)
          vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = bufnr,
            command = "EslintFixAll",
          })
        end,
      })

      -- ── Lua ────────────────────────────────────────────────
      vim.lsp.config("lua_ls", {
        capabilities = capabilities,
        settings = {
          Lua = {
            workspace = { checkThirdParty = false },
            codeLens = { enable = true },
            completion = { callSnippet = "Replace" },
            doc = { privateName = { "^_" } },
            hint = {
              enable = true,
              setType = false,
              paramType = true,
              paramName = "Disable",
              semicolon = "Disable",
              arrayIndex = "Disable",
            },
          },
        },
      })

      -- ── Simple servers ─────────────────────────────────────
      for _, server in ipairs({
        "jsonls",
        "yamlls",
        "taplo",
        "bashls",
        "marksman",
        "dockerls",
        "docker_compose_language_service",
      }) do
        vim.lsp.config(server, { capabilities = capabilities })
      end
    end,
  },

  -- ── Rustaceanvim (enhanced Rust support) ────────────────────
  {
    "mrcjkb/rustaceanvim",
    version = "^5",
    ft = { "rust" },
    opts = {
      server = {
        on_attach = function(_, bufnr)
          local map = vim.keymap.set
          map("n", "<leader>cR", function()
            vim.cmd.RustLsp("codeAction")
          end, { buffer = bufnr, desc = "Code Action (Rust)" })
          map("n", "<leader>dr", function()
            vim.cmd.RustLsp("debuggables")
          end, { buffer = bufnr, desc = "Rust debuggables" })
          map("n", "<leader>ce", function()
            vim.cmd.RustLsp("explainError")
          end, { buffer = bufnr, desc = "Explain error" })
          map("n", "<leader>co", function()
            vim.cmd.RustLsp("openDocs")
          end, { buffer = bufnr, desc = "Open docs.rs" })
        end,
        settings = {
          ["rust-analyzer"] = {
            cargo = { allFeatures = true, loadOutDirsFromCheck = true, buildScripts = { enable = true } },
            checkOnSave = true,
            check = { command = "clippy", extraArgs = { "--no-deps" } },
            procMacro = {
              enable = true,
              ignored = {
                ["async-trait"] = { "async_trait" },
                ["napi-derive"] = { "napi" },
                ["async-recursion"] = { "async_recursion" },
              },
            },
            inlayHints = { lifetimeElisionHints = { enable = "skip_trivial" } },
          },
        },
      },
    },
    config = function(_, opts)
      vim.rustaceanvim = vim.tbl_deep_extend("keep", vim.g.rustaceanvim or {}, opts or {})
    end,
  },

  -- ── Incremental rename ──────────────────────────────────────
  {
    "smjonas/inc-rename.nvim",
    cmd = "IncRename",
    config = true,
    keys = {
      {
        "<leader>cr",
        function()
          return ":IncRename " .. vim.fn.expand("<cword>")
        end,
        expr = true,
        desc = "Rename (inc-rename)",
      },
    },
  },
}
