vim.keymap.set('n', '<leader>db', '<cmd>DBUIToggle<CR>', { noremap = true, desc = 'DB UI Toggle' })
vim.keymap.set('n', '<leader>dba', '<cmd>DBUIAddConnection<CR>', { noremap = true, desc = 'Add New DB Connection' })

local M = {}

local function db_completion()
  require('cmp').setup.buffer { sources = { { name = 'vim-dadbod-completion' } } }
end

function M.setup()
  vim.api.nvim_create_autocmd('FileType', {
    pattern = {
      'sql',
    },
    command = [[setlocal omnifunc=vim_dadbod_completion#omni]],
  })

  vim.api.nvim_create_autocmd('FileType', {
    pattern = {
      'sql',
      'mysql',
      'plsql',
    },
    callback = function()
      vim.schedule(db_completion)
    end,
  })
end

return M
