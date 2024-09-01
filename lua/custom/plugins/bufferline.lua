-- https://github.com/akinsho/bufferline.nvim
return {
  'akinsho/bufferline.nvim',
  enabled = true,
  opts = {
    options = {
      mode = 'buffers',
      themable = true,
      diagnostics = 'nvim_lsp',
      offsets = {
        {
          filetype = 'neo-tree',
        },
      },
    },
  },
  config = function(_, opts)
    require('bufferline').setup(opts)

    vim.keymap.set('n', '<Tab>', ':BufferLineCycleNext<CR>', { noremap = true, silent = true, desc = 'Move to next buffer' })
    vim.keymap.set('n', '<S-Tab>', ':BufferLineCyclePrev<CR>', { noremap = true, silent = true, desc = 'Move to previous buffer' })
  end,
}
