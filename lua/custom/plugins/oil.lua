local M = {
  'stevearc/oil.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
}

function M.config()
  require('oil').setup({
    float = {
      max_height = 30,
      max_width = 120,
    },
    keymaps = {
      ['g?'] = 'actions.show_help',
      ['<CR>'] = 'actions.select',
      ['<C-v>'] = 'actions.select_vsplit',
      ['<C-h>'] = 'actions.select_split',
      ['<C-t>'] = 'actions.select_tab',
      ['<C-p>'] = 'actions.preview',
      ['q'] = 'actions.close',
      ['<C-r>'] = 'actions.refresh',
      ['<BS>'] = 'actions.parent',
      ['_'] = 'actions.open_cwd',
      -- ['`'] = 'actions.cd',
      -- ['~'] = 'actions.tcd',
      ['`'] = 'false',
      ['~'] = 'false',
      ['gs'] = 'actions.change_sort',
      ['gx'] = 'actions.open_external',
      ['g.'] = 'actions.toggle_hidden',
      -- ['g\\'] = 'actions.toggle_trash',
      ['g\\'] = 'false',
    },
    view_options = {
      show_hidden = true,
    },
  })
  vim.keymap.set('n', '<BS>', '<CMD>Oil --float<CR>', { desc = 'Open parent directory' })
end

return M
