return {
  {
    'NvChad/nvterm',
    config = function()
      require('nvterm').setup()
    end,
    keys = function()
      local map = function(modes, keys, func, desc)
        vim.keymap.set(modes, keys, func, { noremap = true, silent = true, desc = 'spawns terminal: ' .. desc })
      end

      require('nvterm').setup()
      local terminal = require 'nvterm.terminal'
      local toggle_modes = { 'n', 't' }

      map(toggle_modes, '<leader>th', function()
        terminal.toggle 'horizontal'
      end, 'horizontal')

      map(toggle_modes, '<leader>tv', function()
        terminal.toggle 'vertical'
      end, 'vertical')

      map(toggle_modes, '<leader>ti', function()
        terminal.toggle 'float'
      end, 'floating')
    end,
  },
}
