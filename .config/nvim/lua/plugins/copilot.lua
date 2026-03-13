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
    "giuxtaposition/blink-cmp-copilot",
    dependencies = "zbirenbaum/copilot.lua",
  },
}
