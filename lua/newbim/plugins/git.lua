return {
  {
    'tpope/vim-fugitive',
    config = function()
      vim.keymap.set('n', '<leader>gs', vim.cmd.Git)
      vim.keymap.set('n', '<leader>gg', ':GBrowse<CR>', { desc = 'GitHub Browse (Gbrowse)' })
    end,
  },
  {
    'tpope/vim-rhubarb', -- Enables :Gbrowse for GitHub remotes
    event = 'VeryLazy',
  },
}
