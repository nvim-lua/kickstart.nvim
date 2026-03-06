return {
  'akinsho/bufferline.nvim',
  event = 'VeryLazy',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  keys = {
    { '<S-h>', '<cmd>BufferLineCyclePrev<CR>', desc = 'Previous buffer' },
    { '<S-l>', '<cmd>BufferLineCycleNext<CR>', desc = 'Next buffer' },
    { '<leader>bp', '<cmd>BufferLinePick<CR>', desc = '[B]uffer [P]ick' },
  },
  opts = {
    options = {
      mode = 'buffers',
      always_show_bufferline = true,
      show_buffer_close_icons = false,
      show_close_icon = false,
    },
  },
}
