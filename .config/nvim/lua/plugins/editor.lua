return {

  -- ── Neo-tree (file explorer) ─────────────────────────────────
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    cmd = "Neotree",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    keys = {
      { "<leader>e", "<cmd>Neotree toggle<CR>", desc = "Toggle Explorer" },
      { "<leader>E", "<cmd>Neotree reveal<CR>", desc = "Reveal in Explorer" },
      { "<leader>ge", "<cmd>Neotree float git_status<CR>", desc = "Git Explorer" },
    },
    opts = {
      sources = { "filesystem", "buffers", "git_status" },
      open_files_do_not_replace_types = { "terminal", "Trouble", "trouble", "qf", "Outline" },
      filesystem = {
        bind_to_cwd = false,
        follow_current_file = { enabled = true },
        use_libuv_file_watcher = true,
        filtered_items = {
          hide_dotfiles = false,
          hide_gitignored = true,
        },
      },
      window = {
        mappings = {
          ["<space>"] = "none",
          ["Y"] = {
            function(state)
              local node = state.tree:get_node()
              local path = node:get_id()
              vim.fn.setreg("+", path, "c")
            end,
            desc = "Copy path to clipboard",
          },
        },
      },
      default_component_configs = {
        indent = {
          with_expanders = true,
          expander_collapsed = "",
          expander_expanded = "",
          expander_highlight = "NeoTreeExpander",
        },
        git_status = {
          symbols = {
            added = "✚",
            modified = "",
            deleted = "✖",
            renamed = "",
            untracked = "",
            ignored = "",
            unstaged = "󰄱",
            staged = "",
            conflict = "",
          },
        },
      },
    },
  },

  -- ── Flash (fast motions, replaces leap/hop) ──────────────────
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {},
    keys = {
      {
        "s",
        function()
          require("flash").jump()
        end,
        mode = { "n", "x", "o" },
        desc = "Flash jump",
      },
      {
        "S",
        function()
          require("flash").treesitter()
        end,
        mode = { "n", "x", "o" },
        desc = "Flash treesitter",
      },
      {
        "r",
        function()
          require("flash").remote()
        end,
        mode = "o",
        desc = "Remote flash",
      },
      {
        "R",
        function()
          require("flash").treesitter_search()
        end,
        mode = { "o", "x" },
        desc = "Treesitter search",
      },
      {
        "<C-s>",
        function()
          require("flash").toggle()
        end,
        mode = "c",
        desc = "Toggle flash (search)",
      },
    },
  },

  -- ── Harpoon 2 (quick file marks) ────────────────────────────
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = "nvim-lua/plenary.nvim",
    opts = { menu = { width = vim.api.nvim_win_get_width(0) - 4 } },
    keys = function()
      local harpoon = require("harpoon")
      return {
        {
          "<leader>ha",
          function()
            harpoon:list():add()
          end,
          desc = "Harpoon add file",
        },
        {
          "<leader>hh",
          function()
            harpoon.ui:toggle_quick_menu(harpoon:list())
          end,
          desc = "Harpoon menu",
        },
        {
          "<leader>1",
          function()
            harpoon:list():select(1)
          end,
          desc = "Harpoon file 1",
        },
        {
          "<leader>2",
          function()
            harpoon:list():select(2)
          end,
          desc = "Harpoon file 2",
        },
        {
          "<leader>3",
          function()
            harpoon:list():select(3)
          end,
          desc = "Harpoon file 3",
        },
        {
          "<leader>4",
          function()
            harpoon:list():select(4)
          end,
          desc = "Harpoon file 4",
        },
        {
          "<leader>hp",
          function()
            harpoon:list():prev()
          end,
          desc = "Harpoon prev",
        },
        {
          "<leader>hn",
          function()
            harpoon:list():next()
          end,
          desc = "Harpoon next",
        },
      }
    end,
  },

  -- ── Auto-pairs ──────────────────────────────────────────────
  {
    "echasnovski/mini.pairs",
    event = "VeryLazy",
    opts = {
      modes = { insert = true, command = true, terminal = false },
      skip_next = [=[[%w%%%'%[%"%.%`%$]]=],
      skip_ts = { "string" },
    },
  },

  -- ── Surround ─────────────────────────────────────────────────
  {
    "echasnovski/mini.surround",
    event = "VeryLazy",
    opts = {
      mappings = {
        add = "gsa",
        delete = "gsd",
        find = "gsf",
        find_left = "gsF",
        highlight = "gsh",
        replace = "gsr",
        update_n_lines = "gsn",
      },
    },
  },

  -- ── Comments ────────────────────────────────────────────────
  {
    "echasnovski/mini.comment",
    event = { "BufReadPost", "BufNewFile" },
    opts = {},
  },

  -- ── Better f/t motions ──────────────────────────────────────
  {
    "echasnovski/mini.move",
    event = "VeryLazy",
    opts = {},
  },

  -- ── Bufremove ───────────────────────────────────────────────
  {
    "echasnovski/mini.bufremove",
    keys = {
      {
        "<leader>bd",
        function()
          require("mini.bufremove").delete(0, false)
        end,
        desc = "Delete buffer",
      },
      {
        "<leader>bD",
        function()
          require("mini.bufremove").delete(0, true)
        end,
        desc = "Delete buffer (force)",
      },
    },
  },

  -- ── Splitjoin (gS / gJ) ─────────────────────────────────────
  {
    "echasnovski/mini.splitjoin",
    event = "VeryLazy",
    opts = { mappings = { toggle = "gS" } },
  },

  -- ── Session management ──────────────────────────────────────
  {
    "folke/persistence.nvim",
    event = "BufReadPre",
    opts = {},
    keys = {
      {
        "<leader>ss",
        function()
          require("persistence").load()
        end,
        desc = "Restore session",
      },
      {
        "<leader>sl",
        function()
          require("persistence").load({ last = true })
        end,
        desc = "Restore last session",
      },
      {
        "<leader>sd",
        function()
          require("persistence").stop()
        end,
        desc = "Stop session save",
      },
    },
  },

  -- ── Better search (grug-far for find & replace) ─────────────
  {
    "MagicDuck/grug-far.nvim",
    cmd = "GrugFar",
    opts = { headerMaxWidth = 80 },
    keys = {
      {
        "<leader>sr",
        function()
          require("grug-far").open({ prefills = { search = vim.fn.expand("<cword>") } })
        end,
        desc = "Search & Replace (grug)",
      },
      {
        "<leader>sR",
        function()
          require("grug-far").open()
        end,
        desc = "Search & Replace (grug, empty)",
      },
    },
  },

  -- ── Better word motions ─────────────────────────────────────
  {
    "chrisgrieser/nvim-spider",
    lazy = true,
    keys = {
      {
        "w",
        function()
          require("spider").motion("w")
        end,
        mode = { "n", "o", "x" },
        desc = "Spider w",
      },
      {
        "e",
        function()
          require("spider").motion("e")
        end,
        mode = { "n", "o", "x" },
        desc = "Spider e",
      },
      {
        "b",
        function()
          require("spider").motion("b")
        end,
        mode = { "n", "o", "x" },
        desc = "Spider b",
      },
    },
  },

  -- ── Terminal ────────────────────────────────────────────────
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    keys = {
      {
        "<C-t>",
        "<cmd>ToggleTerm<CR>",
        mode = { "n", "t" },
        desc = "Toggle terminal",
      },
      { "<leader>tf", "<cmd>ToggleTerm direction=float<CR>", desc = "Terminal (float)" },
      { "<leader>th", "<cmd>ToggleTerm direction=horizontal size=15<CR>", desc = "Terminal (horizontal)" },
      { "<leader>tv", "<cmd>ToggleTerm direction=vertical size=80<CR>", desc = "Terminal (vertical)" },
    },
    opts = {
      size = function(term)
        if term.direction == "horizontal" then
          return 15
        elseif term.direction == "vertical" then
          return math.floor(vim.o.columns * 0.4)
        end
      end,
      open_mapping = [[<C-\>]],
      shade_terminals = false,
      start_in_insert = true,
      persist_mode = true,
      direction = "float",
      float_opts = { border = "curved", winblend = 5 },
    },
  },

  -- ── Better yank ring ────────────────────────────────────────
  {
    "gbprod/yanky.nvim",
  },
}
