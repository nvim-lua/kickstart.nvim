return {
  'akinsho/bufferline.nvim',
  version = '*',
  -- `BufReadPre` event to prevent show a `No Name` buffer when open a directory use nvim directly
  event = 'BufReadPre',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  keys = {
    { '<leader>bp', '<Cmd>BufferLineTogglePin<CR>', desc = 'Toggle pin' },
    { '<leader>bP', '<Cmd>BufferLineGroupClose ungrouped<CR>', desc = 'Delete non-pinned buffers' },
    { '<leader>bo', '<Cmd>BufferLineCloseOthers<CR>', desc = 'Delete other buffers' },
    { '<leader>br', '<Cmd>BufferLineCloseRight<CR>', desc = 'Delete buffers to the right' },
    { '<leader>bl', '<Cmd>BufferLineCloseLeft<CR>', desc = 'Delete buffers to the left' },
    { '<S-h>', '<cmd>BufferLineCyclePrev<cr>', desc = 'Prev buffer' },
    { '<S-l>', '<cmd>BufferLineCycleNext<cr>', desc = 'Next buffer' },
    { '[b', '<cmd>BufferLineCyclePrev<cr>', desc = 'Prev buffer' },
    { ']b', '<cmd>BufferLineCycleNext<cr>', desc = 'Next buffer' },
  },
  opts = {
    options = {
      offsets = {
        {
          filetype = 'neo-tree',
          text = 'Neo-tree',
          highlight = 'Directory',
          text_align = 'left',
        },
      },
    },
  },
}
