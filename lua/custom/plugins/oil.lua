return {
  'stevearc/oil.nvim',
  dependencies = {
    'kyazdani42/nvim-web-devicons', -- Lazy dependency for devicons
  },
  config = function()
    require('oil').setup({
      columns = {
        'icon',
        -- 'permissions',
      },
      keymaps = {
        ['C-h'] = false,
        ['M-h'] = 'actions.select_split',
      },
      view_options = {
        show_hidden = true,
      },
    })

    vim.keymap.set('n', '-', '<CMD>Oil<CR>', { noremap = true, silent = true, desc = 'Open parent directory' })
    vim.keymap.set('n', '<leader>-', function() require('oil').toggle_float() end,
      { noremap = true, silent = true, desc = 'Toggle oil floating window' })
  end,
}

