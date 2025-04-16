return {
  --use nvim in browser
  { 'kristijanhusak/vim-dadbod-ui' },
  { 'kristijanhusak/vim-dadbod-completion' },
  -- Database
  {
    'tpope/vim-dadbod',
    -- lazy = true,
    dependencies = {
      'kristijanhusak/vim-dadbod-ui',
      'kristijanhusak/vim-dadbod-completion',
    },
    -- event = 'VeryLazy',
    config = function()
      vim.g.db_ui_execute_on_save = 0 --do not execute on save
      vim.g.db_ui_win_position = 'left'
      vim.g.db_ui_use_nerd_fonts = 1
      vim.g.db_ui_icons = {
        expanded = {
          db = '▼',
          buffers = '▼',
          saved_queries = '▼',
          schemas = '▼',
          schema = '▼',
          tables = '▼',
          table = '▼',
        },
        collapsed = {
          db = '▶',
          buffers = '▶',
          saved_queries = '▶',
          schemas = '▶',
          schema = '▶',
          tables = '▶',
          table = '▶',
        },
        saved_query = '*',
        new_query = '+',
        tables = '~',
        buffers = '»',
        add_connection = '[+]',
        connection_ok = '✓',
        connection_error = '✕',
      }
    end,
  },
}

-- {'add_connection': '[+]', 'expanded': {'schemas': '▾', 'saved_queries': '▾', 'db': '▾', 'schema': '▾', 'table': '▾', 'buffers': '▾', 'tables': '▾'}, 'connection_ok': '✓', 'connection_error': '✕', 'tables': '~', '
-- collapsed': {'schemas': '▸', 'saved_queries': '▸', 'db': '▸', 'schema': '▸', 'table': '▸', 'buffers': '▸', 'tables': '▸'}, 'saved_query': '*', 'buffers': '»', 'new_query': '+'}
