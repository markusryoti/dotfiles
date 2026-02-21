return {
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    version = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make", cond = vim.fn.executable("make") == 1 },
      "nvim-telescope/telescope-ui-select.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    keys = {
      -- Files
      { "<leader><space>", "<cmd>Telescope find_files<CR>", desc = "Find files" },
      { "<leader>ff", "<cmd>Telescope find_files<CR>", desc = "Find files" },
      {
        "<leader>fF",
        function()
          require("telescope.builtin").find_files({ cwd = vim.fn.expand("%:p:h") })
        end,
        desc = "Find files (cwd)",
      },
      { "<leader>fr", "<cmd>Telescope oldfiles<CR>", desc = "Recent files" },
      { "<leader>fg", "<cmd>Telescope git_files<CR>", desc = "Git files" },

      -- Search
      { "<leader>/", "<cmd>Telescope live_grep<CR>", desc = "Grep (cwd)" },
      { "<leader>sg", "<cmd>Telescope live_grep<CR>", desc = "Live grep" },
      {
        "<leader>sG",
        function()
          require("telescope.builtin").live_grep({ cwd = vim.fn.expand("%:p:h") })
        end,
        desc = "Live grep (file dir)",
      },
      {
        "<leader>sw",
        "<cmd>Telescope grep_string<CR>",
        desc = "Word under cursor",
      },
      {
        "<leader>sb",
        "<cmd>Telescope current_buffer_fuzzy_find<CR>",
        desc = "Buffer fuzzy find",
      },

      -- Vim
      { "<leader>sc", "<cmd>Telescope commands<CR>", desc = "Commands" },
      { "<leader>sk", "<cmd>Telescope keymaps<CR>", desc = "Keymaps" },
      { "<leader>sh", "<cmd>Telescope help_tags<CR>", desc = "Help" },
      { "<leader>sm", "<cmd>Telescope marks<CR>", desc = "Marks" },
      { "<leader>sM", "<cmd>Telescope man_pages<CR>", desc = "Man pages" },
      { "<leader>so", "<cmd>Telescope vim_options<CR>", desc = "Options" },
      {
        "<leader>sd",
        "<cmd>Telescope diagnostics bufnr=0<CR>",
        desc = "Diagnostics (buffer)",
      },
      {
        "<leader>sD",
        "<cmd>Telescope diagnostics<CR>",
        desc = "Diagnostics (workspace)",
      },
      {
        "<leader>sr",
        "<cmd>Telescope resume<CR>",
        desc = "Resume last search",
      },

      -- Git
      { "<leader>gc", "<cmd>Telescope git_commits<CR>", desc = "Git commits" },
      { "<leader>gs", "<cmd>Telescope git_status<CR>", desc = "Git status" },
      { "<leader>gb", "<cmd>Telescope git_branches<CR>", desc = "Git branches" },

      -- Buffers
      { "<leader>bs", "<cmd>Telescope buffers sort_mru=true sort_lastused=true<CR>", desc = "Switch buffer" },
    },
    config = function()
      local telescope = require("telescope")
      local actions = require("telescope.actions")

      telescope.setup({
        defaults = {
          prompt_prefix = " ",
          selection_caret = " ",
          multi_icon = " ",
          path_display = { "truncate" },
          sorting_strategy = "ascending",
          layout_config = {
            horizontal = { prompt_position = "top", preview_width = 0.55 },
          },
          mappings = {
            i = {
              ["<C-j>"] = actions.move_selection_next,
              ["<C-k>"] = actions.move_selection_previous,
              ["<C-n>"] = actions.cycle_history_next,
              ["<C-p>"] = actions.cycle_history_prev,
              ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
              ["<esc>"] = actions.close,
            },
          },
        },
        extensions = {
          fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = "smart_case",
          },
          ["ui-select"] = {
            require("telescope.themes").get_dropdown({}),
          },
        },
      })

      telescope.load_extension("fzf")
      telescope.load_extension("ui-select")
    end,
  },
}
