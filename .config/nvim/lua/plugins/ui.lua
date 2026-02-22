return {

  -- ── Statusline ──────────────────────────────────────────────
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = function()
      local icons = {
        diagnostics = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " },
        git = { added = "󰐖 ", modified = "󰏬 ", removed = " " },
      }
      return {
        options = {
          theme = "catppuccin",
          globalstatus = true,
          disabled_filetypes = { statusline = { "dashboard", "alpha", "starter" } },
          component_separators = "",
          section_separators = { left = "", right = "" },
        },
        sections = {
          lualine_a = { { "mode", separator = { left = "" }, right_padding = 2 } },
          lualine_b = { "branch" },
          lualine_c = {
            { "diagnostics", symbols = icons.diagnostics },
            { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
            { "filename", path = 1, symbols = { modified = "  ", readonly = "", unnamed = "" } },
          },
          lualine_x = {
            {
              function()
                return require("noice").api.status.command.get()
              end,
              cond = function()
                return package.loaded["noice"] and require("noice").api.status.command.has()
              end,
              color = { fg = "#c6a0f6" },
            },
            {
              "diff",
              symbols = icons.git,
              source = function()
                local gs = package.loaded.gitsigns
                if gs then
                  local s = gs.get_hunks()
                  if s then
                    return { added = s.added, modified = s.changed, removed = s.removed }
                  end
                end
              end,
            },
          },
          lualine_y = {
            { "progress", separator = " ", padding = { left = 1, right = 0 } },
            { "location", padding = { left = 0, right = 1 } },
          },
          lualine_z = {
            {
              function()
                return " " .. os.date("%H:%M")
              end,
              separator = { right = "" },
            },
          },
        },
      }
    end,
  },

  -- ── Bufferline ──────────────────────────────────────────────
  -- {
  --   "akinsho/bufferline.nvim",
  --   event = "VeryLazy",
  --   version = "*",
  --   dependencies = "nvim-tree/nvim-web-devicons",
  --   opts = {
  --     options = {
  --       mode = "buffers",
  --       themable = true,
  --       diagnostics = "nvim_lsp",
  --       always_show_bufferline = false,
  --       show_buffer_close_icons = true,
  --       separator_style = "slant",
  --       offsets = {
  --         { filetype = "neo-tree", text = "Explorer", highlight = "Directory", text_align = "left" },
  --       },
  --       diagnostics_indicator = function(_, _, diag)
  --         local icons = { error = " ", warning = " " }
  --         local ret = (diag.error and icons.error .. diag.error .. " " or "")
  --           .. (diag.warning and icons.warning .. diag.warning or "")
  --         return vim.trim(ret)
  --       end,
  --     },
  --   },
  --   keys = {
  --     { "<leader>bp", "<cmd>BufferLineTogglePin<CR>", desc = "Toggle pin buffer" },
  --     { "<leader>bP", "<cmd>BufferLineGroupClose ungrouped<CR>", desc = "Close unpinned buffers" },
  --   },
  -- },

  -- ── Noice (UI overhaul: cmdline, messages, popupmenu) ───────
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = { "MunifTanjim/nui.nvim", "rcarriga/nvim-notify" },
    opts = {
      lsp = {
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
      },
      routes = {
        {
          filter = {
            event = "msg_show",
            any = { { find = "%d+L, %d+B" }, { find = "; after #%d+" }, { find = "; before #%d+" } },
          },
          view = "mini",
        },
      },
      presets = {
        bottom_search = true,
        command_palette = true,
        long_message_to_split = true,
        inc_rename = true,
      },
    },
    keys = {
      {
        "<S-Enter>",
        function()
          require("noice").redirect(vim.fn.getcmdline())
        end,
        mode = "c",
        desc = "Redirect cmdline",
      },
      {
        "<leader>nl",
        function()
          require("noice").cmd("last")
        end,
        desc = "Noice last message",
      },
      {
        "<leader>nh",
        function()
          require("noice").cmd("history")
        end,
        desc = "Noice history",
      },
      {
        "<leader>nd",
        function()
          require("noice").cmd("dismiss")
        end,
        desc = "Dismiss all",
      },
    },
  },

  -- ── Notify ─────────────────────────────────────────────────
  {
    "rcarriga/nvim-notify",
    opts = {
      timeout = 3000,
      max_width = 60,
      stages = "fade_in_slide_out",
      render = "wrapped-compact",
    },
    init = function()
      vim.notify = require("notify")
    end,
  },

  -- ── Dashboard ───────────────────────────────────────────────
  {
    "nvimdev/dashboard-nvim",
    event = "VimEnter",
    dependencies = "nvim-tree/nvim-web-devicons",
    opts = {
      theme = "doom",
      config = {
        header = {
          "",
          "  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗  ",
          "  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║  ",
          "  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║  ",
          "  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║  ",
          "  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║  ",
          "  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝  ",
          "",
        },
        center = {
          { icon = "  ", key = "f", desc = "Find file", action = "Telescope find_files" },
          { icon = "  ", key = "n", desc = "New file", action = "enew" },
          { icon = "  ", key = "r", desc = "Recent files", action = "Telescope oldfiles" },
          { icon = "  ", key = "g", desc = "Find text", action = "Telescope live_grep" },
          { icon = "  ", key = "s", desc = "Restore session", action = [[lua require("persistence").load()]] },
          { icon = "  ", key = "l", desc = "Lazy", action = "Lazy" },
          { icon = "  ", key = "q", desc = "Quit", action = "qa" },
        },
        footer = function()
          local stats = require("lazy").stats()
          return { "⚡ Loaded " .. stats.loaded .. "/" .. stats.count .. " plugins" }
        end,
      },
    },
  },

  -- ── Which-key ───────────────────────────────────────────────
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      preset = "modern",
      spec = {
        { "<leader>b", group = "buffers", icon = "󰈔 " },
        { "<leader>c", group = "code", icon = "󰅩 " },
        { "<leader>d", group = "debug", icon = " " },
        { "<leader>f", group = "file/find", icon = "󰈔 " },
        { "<leader>g", group = "git", icon = "󰊢 " },
        { "<leader>n", group = "noice", icon = " " },
        { "<leader>s", group = "search", icon = "󰍉 " },
        { "<leader>t", group = "test", icon = "󰙨 " },
        { "<leader>u", group = "ui", icon = " " },
        { "<leader>w", group = "windows", icon = "󱂬 " },
        { "<leader>x", group = "diagnostics/quickfix", icon = "󱖫 " },
        { "<leader><tab>", group = "tabs", icon = "󰓩 " },
        { "[", group = "prev" },
        { "]", group = "next" },
        { "g", group = "goto" },
        { "z", group = "fold" },
      },
    },
  },

  -- ── Indent guides ───────────────────────────────────────────
  {
    "lukas-reineke/indent-blankline.nvim",
    event = { "BufReadPost", "BufNewFile" },
    main = "ibl",
    opts = {
      indent = { char = "│", tab_char = "│" },
      scope = { show_start = false, show_end = false },
      exclude = {
        filetypes = {
          "help",
          "dashboard",
          "neo-tree",
          "Trouble",
          "lazy",
          "notify",
        },
      },
    },
  },

  -- ── Trouble (diagnostics panel) ─────────────────────────────
  {
    "folke/trouble.nvim",
    cmd = "Trouble",
    opts = { modes = { lsp = { win = { position = "right" } } } },
    keys = {
      { "<leader>xx", "<cmd>Trouble diagnostics toggle<CR>", desc = "Diagnostics (Trouble)" },
      { "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<CR>", desc = "Buffer diagnostics" },
      { "<leader>cs", "<cmd>Trouble symbols toggle focus=false<CR>", desc = "Symbols (Trouble)" },
      { "<leader>xL", "<cmd>Trouble loclist toggle<CR>", desc = "Location list (Trouble)" },
      { "<leader>xQ", "<cmd>Trouble qflist toggle<CR>", desc = "Quickfix list (Trouble)" },
      {
        "[t",
        function()
          require("trouble").prev({ skip_groups = true, jump = true })
        end,
        desc = "Prev trouble item",
      },
      {
        "]t",
        function()
          require("trouble").next({ skip_groups = true, jump = true })
        end,
        desc = "Next trouble item",
      },
    },
  },

  -- ── Todo comments ───────────────────────────────────────────
  {
    "folke/todo-comments.nvim",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = "nvim-lua/plenary.nvim",
    opts = {},
    keys = {
      {
        "]t",
        function()
          require("todo-comments").jump_next()
        end,
        desc = "Next todo",
      },
      {
        "[t",
        function()
          require("todo-comments").jump_prev()
        end,
        desc = "Prev todo",
      },
      { "<leader>xt", "<cmd>Trouble todo toggle<CR>", desc = "Todo (Trouble)" },
      { "<leader>st", "<cmd>TodoTelescope<CR>", desc = "Todo (Telescope)" },
    },
  },

  -- ── UFO (folding) ───────────────────────────────────────────
  {
    "kevinhwang91/nvim-ufo",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = "kevinhwang91/promise-async",
    opts = {
      provider_selector = function()
        return { "treesitter", "indent" }
      end,
    },
    keys = {
      {
        "zR",
        function()
          require("ufo").openAllFolds()
        end,
        desc = "Open all folds",
      },
      {
        "zM",
        function()
          require("ufo").closeAllFolds()
        end,
        desc = "Close all folds",
      },
    },
  },
}
