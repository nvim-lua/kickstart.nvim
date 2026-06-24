return {
  'akinsho/toggleterm.nvim',
  version = '*',
  opts = {
    open_mapping = [[<leader>tt]],
  },
  config = function(_, opts)
    require('toggleterm').setup(opts)
    vim.keymap.set('t', '<Esc>', [[<C-\><C-n>]], { desc = 'Exit terminal mode' })

    local lazygit = require('toggleterm.terminal').Terminal:new {
      cmd = 'lazygit',
      direction = 'float',
      hidden = true,
    }
    vim.keymap.set('n', '<leader>tg', function() lazygit:toggle() end, { desc = 'Toggle lazygit' })
  end,
}
