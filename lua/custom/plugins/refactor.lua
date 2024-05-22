return {
  {
    "ThePrimeagen/refactoring.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("refactoring").setup()
      vim.keymap.set("x", "<leader>re", function() require('refactoring').refactor('Extract Function') end
      , { desc = '[E]xtract Function' })
      vim.keymap.set("x", "<leader>rf", function() require('refactoring').refactor('Extract Function To File') end,
        { desc = 'Extract Function to [F]ile' })
      -- Extract function supports only visual mode
      vim.keymap.set("x", "<leader>rv", function() require('refactoring').refactor('Extract Variable') end
      , { desc = 'Extract [V]ariable' })
      -- Extract variable supports only visual mode
      vim.keymap.set("n", "<leader>rI", function() require('refactoring').refactor('Inline Function') end
      , { desc = '[I]nline Function' })
      -- Inline func supports only normal
      vim.keymap.set({ "n", "x" }, "<leader>ri", function() require('refactoring').refactor('Inline Variable') end
      , { desc = '[I]nline Variable' })
      -- Inline var supports both normal and visual mode

      vim.keymap.set("n", "<leader>rb", function() require('refactoring').refactor('Extract Block') end,
        { desc = 'Extract [B]lock' })
      vim.keymap.set("n", "<leader>rbf", function() require('refactoring').refactor('Extract Block To File') end,
        { desc = 'Extract [B]lock to [F]ile' })
      -- Extract block supports only normal mode
    end,
  },
}
