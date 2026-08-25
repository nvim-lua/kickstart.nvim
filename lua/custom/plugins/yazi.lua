local gh = 'https://github.com/'

vim.pack.add {
  gh .. 'mikavilpas/yazi.nvim',
  gh .. 'nvim-lua/plenary.nvim',
}

require('yazi').setup {
  open_for_directories = false,
  keymaps = {
    show_help = '<f1>',
  },
}

vim.g.loaded_netrwPlugin = 1
vim.api.nvim_create_autocmd('UIEnter', {
  callback = function()
    require('yazi').setup {
      open_for_directories = true,
    }
  end,
})

vim.keymap.set('n', '<leader>-', '<cmd>Yazi<cr>', {
  desc = 'Open Yazi',
})
