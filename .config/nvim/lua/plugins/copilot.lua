return {
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    opts = {
      suggestion = { enabled = false }, -- use blink.cmp source instead
      panel = { enabled = false },
      filetypes = { yaml = true, markdown = true, ["*"] = true },
    },
  },
  {
    "zbirenbaum/copilot-cmp",
    dependencies = "zbirenbaum/copilot.lua",
    config = true,
  },
}
