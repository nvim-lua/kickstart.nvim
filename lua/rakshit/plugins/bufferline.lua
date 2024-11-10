-- Adds a new line for the open buffers (aka tabs)
return {
  'akinsho/bufferline.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  version = '*',
  opts = {
    options = {
      mode = 'tabs',
      separator_style = 'slant',
    },
  },
}
