return {
  "kdheepak/lazygit.nvim",
  -- enabled = vim.api.nvim_get_var("useLazyGit"),
  cmd = {
    "LazyGit",
    "LazyGitConfig",
    "LazyGitCurrentFile",
    "LazyGitFilter",
    "LazyGitFilterCurrentFile",    
  },
  event = "VeryLazy",
  keys = {
    { "<leader>lg", "<cmd>LazyGit<cr>", desc = "Lazy Git" },
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim",
  },
  config = function()
    require("telescope").load_extension("lazygit")
  end
}

