return {
  {
    'FabijanZulj/blame.nvim',
    lazy = false,
    config = function()
      require('blame').setup()
    end,
  },
  -- keys = {
  --   {
  --     '<leader>mt',
  --     function()
  --       vim.keymap.set('n', '<leader>bt', ':BlameToggle<CR>')
  --     end,
  --     desc = 'Toggle git blame window',
  --   },
  -- },
}
