return {
  'folke/trouble.nvim',
  cmd = "Trouble",
  opts = {
    auto_open = false,
    auto_close = true,
    auto_preview = true,
    auto_fold = true,
    use_diagnostic_signs = true,
  },
  keys = {
    { "<leader>tt", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics (Trouble)" },
  },
}

