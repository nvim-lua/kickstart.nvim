return {
  'akinsho/bufferline.nvim',
  lazy = false,
  config = function()
    vim.opt.termguicolors = true
    require('bufferline').setup {
      options = {
        numbers = 'buffer_id',
      },
    }
  end,
}
