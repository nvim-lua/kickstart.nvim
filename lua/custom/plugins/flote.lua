local M = {
  'JellyApple102/flote.nvim',
}

function M.config()
  require('flote').setup({
    q_to_quit = true,
    window_style = 'minimal',
    window_border = 'solid',
    window_title = true,
    notes_dir = vim.fn.stdpath('cache') .. '/flote',
    files = {
      global = 'flote-global.md',
      cwd = function()
        return vim.fn.getcwd()
      end,
      file_name = function(cwd)
        local base_name = vim.fs.basename(cwd)
        local parent_base_name = vim.fs.basename(vim.fs.dirname(cwd))
        return parent_base_name .. '_' .. base_name .. '.md'
      end,
    },
  })
end

vim.keymap.set('n', '<leader>n', '<CMD>Flote<CR>', { desc = 'Open project notes' })
vim.keymap.set('n', '<leader>N', '<CMD>Flote global<CR>', { desc = 'Open global notes' })

return M
