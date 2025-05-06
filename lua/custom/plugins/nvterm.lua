return {
  'NvChad/nvterm',
  config = function()
    require('nvterm').setup()

    vim.keymap.set('n', '<leader>tt', function()
      require('nvterm.terminal').toggle 'horizontal'
    end, { desc = '[T]oggle [T]erminal' })
  end,
}
