return {
  "TimUntersberger/neogit",
  dependencies = "nvim-lua/plenary.nvim",
  keys = {
    { "<leader>gs", "<cmd>Neogit<CR>", desc = "Open neogit" },
  },
  opts = {
    use_magit_keybindings = true,
  },
}
