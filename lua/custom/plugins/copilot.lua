return {
  "zbirenbaum/copilot.lua",
  cmd = "Copilot",
  dependencies = {
    "github/copilot.vim"
  },
  build = ":Copilot auth",
  opts = {
    suggestion = { enabled = false },
    panel = { enabled = false },
  },
}
