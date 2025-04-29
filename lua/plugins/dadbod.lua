---@diagnostic disable: undefined-global
-- Database explorer and query runner
return {
  'tpope/vim-dadbod',
  dependencies = {
    'kristijanhusak/vim-dadbod-ui',        -- UI for vim-dadbod
    'kristijanhusak/vim-dadbod-completion' -- Completion for SQL
  },
  cmd = {
    'DBUI',
    'DBUIToggle',
    'DBUIAddConnection',
    'DBUIFindBuffer',
  },
  init = function()
    -- Save DBUI settings
    vim.g.db_ui_save_location = vim.fn.stdpath("data") .. "/db_ui"
    vim.g.db_ui_use_nerd_fonts = true
    vim.g.db_ui_execute_on_save = false -- Don't auto-execute queries on save
    vim.g.db_ui_table_helpers = {
      -- Add useful SQL snippets
      mysql = {
        List = 'SELECT * FROM {table} LIMIT 100',
        Indexes = 'SHOW INDEXES FROM {table}',
        Foreign = 'SELECT * FROM information_schema.key_column_usage WHERE referenced_table_name = {table}',
      },
      postgresql = {
        List = 'SELECT * FROM {table} LIMIT 100',
        Indexes = 'SELECT * FROM pg_indexes WHERE tablename = {table}',
        Foreign = [[
          SELECT
              tc.table_schema, 
              tc.constraint_name, 
              tc.table_name, 
              kcu.column_name, 
              ccu.table_schema AS foreign_table_schema,
              ccu.table_name AS foreign_table_name,
              ccu.column_name AS foreign_column_name 
          FROM 
              information_schema.table_constraints AS tc 
              JOIN information_schema.key_column_usage AS kcu
                ON tc.constraint_name = kcu.constraint_name
                AND tc.table_schema = kcu.table_schema
              JOIN information_schema.constraint_column_usage AS ccu
                ON ccu.constraint_name = tc.constraint_name
                AND ccu.table_schema = tc.table_schema
          WHERE tc.constraint_type = 'FOREIGN KEY' AND tc.table_name={table};
        ]],
      },
    }
  end,
  config = function()
    -- Enable SQL completion in SQL files and dadbod-ui buffers
    vim.api.nvim_create_autocmd('FileType', {
      pattern = {'sql', 'mysql', 'plsql', 'pgsql'},
      callback = function()
        -- Set up completion
        require('cmp').setup.buffer({
          sources = {
            { name = 'vim-dadbod-completion' }, -- Database-aware completion
            { name = 'nvim_lsp' },              -- LSP completion
            { name = 'buffer' },                -- Buffer words
          },
        })
      end,
    })
  end,
}
