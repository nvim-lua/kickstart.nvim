-- LazyGit integration for Neovim
-- https://github.com/kdheepak/lazygit.nvim

return {
  {
    "kdheepak/lazygit.nvim",
    -- Lazy load on command
    cmd = {
      "LazyGit",
      "LazyGitConfig",
      "LazyGitCurrentFile",
      "LazyGitFilter",
      "LazyGitFilterCurrentFile",
    },
    -- Lazy load on keymaps
    keys = {
      { "<leader>gg", "<cmd>LazyGit<CR>", desc = "Open LazyGit" },
      { "<leader>gc", "<cmd>LazyGitConfig<CR>", desc = "Open LazyGit Config" },
      { "<leader>gf", "<cmd>LazyGitCurrentFile<CR>", desc = "LazyGit Current File" },
    },
    -- Dependencies
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    -- Plugin configuration
    config = function()
      -- Configure floating window border
      require("lazygit").setup({
        floating_window_winblend = 0, -- transparency of floating window
        floating_window_scaling_factor = 0.9, -- scaling factor for floating window
        floating_window_border_chars = { '╭', '─', '╮', '│', '╯', '─', '╰', '│' }, -- customize floating window border chars
        lazygit_floating_window_use_plenary = true, -- use plenary.nvim to manage floating window if available
      })
    end,
  }
}
