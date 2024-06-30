return {
  'kristijanhusak/vim-dadbod-ui',
  event = 'VeryLazy',
  dependencies = {
    { 'tpope/vim-dadbod', event = 'VeryLazy' },
    { 'kristijanhusak/vim-dadbod-completion', event = 'InsertEnter' },
  },
  config = function()
    vim.g.db_ui_use_nerd_fonts = 1
    vim.g.db_ui_show_database_icon = 1
  end,
}
