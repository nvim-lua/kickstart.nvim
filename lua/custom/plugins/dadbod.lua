return {
  'tpope/vim-dadbod',
  dependencies = {
    'kristijanhusak/vim-dadbod-ui',
    'kristijanhusak/vim-dadbod-completion',
  },
  keys = {
    { '<leader>du', '<cmd>DBUIToggle<cr>', { desc = 'Toggle dadbod', noremap = true } },
  },
  init = function()
    vim.g.db_ui_use_nerd_fonts = 1
  end,
}

