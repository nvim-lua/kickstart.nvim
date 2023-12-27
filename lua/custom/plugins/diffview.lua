return {
  'sindrets/diffview.nvim',
  cmd = { 'DiffviewOpen', 'DiffviewClose', 'DiffviewToggleFiles', 'DiffviewFocusFiles' },
  opts = {},
  keys = { { '<leader>gd', '<cmd>DiffviewOpen<cr>', desc = 'DiffView' } },
  config = function()
    require('diffview').setup()
    vim.keymap.set('n', '<leader>gd', function()
      if next(require('diffview.lib').views) == nil then
        vim.cmd 'DiffviewOpen'
      else
        vim.cmd 'DiffviewClose'
      end
    end)
  end,
}
