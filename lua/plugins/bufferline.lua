-- Keybinds for cycling through buffers (left and right)
vim.api.nvim_set_keymap('n', '<S-h>', '<cmd>BufferLineCyclePrev<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<S-l>', '<cmd>BufferLineCycleNext<CR>', { noremap = true, silent = true })

return {
  'akinsho/bufferline.nvim',
  version = '*',
  dependencies = 'nvim-tree/nvim-web-devicons',
  config = function()
    vim.opt.termguicolors = true
    require('bufferline').setup {
      options = {
        offsets = {
          {
            filetype = 'neo-tree',
            text = function()
              return vim.fn.getcwd()
            end,
            -- text = 'File Explorer',
            highlight = 'Directory',
            separator = true, -- use a "true" to enable the default, or set your own character
          },
        },
      },
    }
  end,
}
