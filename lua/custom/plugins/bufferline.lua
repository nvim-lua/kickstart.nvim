return {
  'akinsho/bufferline.nvim',
  event = 'VeryLazy',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  keys = {
    { '<S-h>', '<cmd>BufferLineCyclePrev<CR>', desc = 'Previous buffer' },
    { '<S-l>', '<cmd>BufferLineCycleNext<CR>', desc = 'Next buffer' },
    { '<leader>bp', '<cmd>BufferLinePick<CR>', desc = '[B]uffer [P]ick' },
    {
      '<leader>bD',
      function()
        local bufremove = require 'mini.bufremove'

        for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
          if vim.api.nvim_buf_is_valid(bufnr) and vim.bo[bufnr].buflisted and vim.bo[bufnr].filetype ~= 'neo-tree' then
            bufremove.delete(bufnr, false)
          end
        end
      end,
      desc = '[B]uffer [D]elete all',
    },
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
