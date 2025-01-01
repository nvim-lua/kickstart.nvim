return {
  'folke/snacks.nvim',
  ---@diagnostic disable-next-line: undefined-doc-name
  ---@type snacks.Config
  opts = {
    lazygit = {
      -- your lazygit configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
  },
  keys = {
    {
      '<leader>gg',
      function()
        Snacks.lazygit { cwd = vim.fn.getcwd() }
      end,
      { desc = 'Lazygit (Root Dir)' },
    },
    {
      '<leader>gf',
      function()
        Snacks.lazygit.log_file()
      end,
      { desc = 'Lazygit Current File History' },
    },
    {
      '<leader>gl',
      function()
        Snacks.lazygit.log { cwd = vim.fn.getcwd() }
      end,
      { desc = 'Lazygit Log' },
    },
    { '<leader>gb', '<cmd>Gitsigns blame<cr>', desc = 'Git blame' },
    { '<leader>gs', '<cmd>Telescope git_status<CR>', desc = 'Git Status' },
  },
}
