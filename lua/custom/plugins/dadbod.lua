-- Database UI plugin for viewing and interacting with databases
return {
  'kristijanhusak/vim-dadbod-ui',
  dependencies = {
    { 'tpope/vim-dadbod', lazy = true },
    { 'kristijanhusak/vim-dadbod-completion', ft = { 'sql', 'mysql', 'plsql' }, lazy = true },
  },
  cmd = {
    'DBUI',
    'DBUIToggle',
    'DBUIAddConnection',
    'DBUIFindBuffer',
  },
  init = function()
    -- Use nerd fonts for nice icons
    vim.g.db_ui_use_nerd_fonts = 1

    -- Save database connections (optional)
    -- vim.g.dbs = {
    --   dev = 'sqlite:' .. vim.fn.expand('~/path/to/your/database.db'),
    -- }
  end,
  keys = {
    { '<leader>db', '<cmd>DBUIToggle<cr>', desc = 'Toggle Database UI' },
  },
}
