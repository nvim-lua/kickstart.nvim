return {
  {
    'folke/which-key.nvim',
    event = 'VimEnter',
    config = function()
      require('which-key').setup()

      require('which-key').register {
        ['<leader>c'] = { name = '[C]ode', _ = 'which_key_ignore' },
        ['<leader>d'] = { name = '[D]ocument', _ = 'which_key_ignore' },
        ['<leader>r'] = { name = '[R]ename', _ = 'which_key_ignore' },
        ['<leader>f'] = { name = '[F]ind', _ = 'which_key_ignore' },
        ['<leader>t'] = { name = '[T]oggle', _ = 'which_key_ignore' },
        ['<leader>w'] = { name = '[W]orkspace', _ = 'which_key_ignore' },
      }

      -- [T]oggle group
      vim.keymap.set('n', '<leader>tn', function()
        vim.opt.number = not vim.opt.number._value
      end, { desc = '[T]oggle [N]umbers' })

      vim.keymap.set('n', '<leader>tw', function()
        vim.opt.warp = not vim.opt.warp._value
      end, { desc = '[T]oggle [W]rap Lines' })
    end,
  },
}
