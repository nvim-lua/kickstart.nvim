local M = {
  'cshuaimin/ssr.nvim',
  lazy = true,
}

function M.config()
  require('ssr').setup({
    border = 'rounded',
    min_width = 50,
    min_height = 5,
    max_width = 120,
    max_height = 25,
    adjust_window = true,
    keymaps = {
      close = 'q',
      next_match = 'n',
      prev_match = 'N',
      replace_confirm = '<cr>',
      replace_all = '<leader><cr>',
    },
  })
end

vim.keymap.set({ 'n', 'x' }, '<leader>r', function()
  require('ssr').open()
end)

return M
