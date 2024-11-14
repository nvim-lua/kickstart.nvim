return {
  'akinsho/bufferline.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  version = '*',
  config = function()
    local bufferline = require 'bufferline'

    bufferline.setup {
      options = {
        mode = 'buffers',
        offsets = {
          filetype = 'NvimTree',
        },
      },
    }

    vim.keymap.set('n', '<S-l>', '<cmd>BufferLineCycleNext<CR>', { desc = 'Buffer line cycle next' })
    vim.keymap.set('n', '<S-h>', '<cmd>BufferLineCyclePrev<CR>', { desc = 'Buffer line cycle prev' })
  end,
}
