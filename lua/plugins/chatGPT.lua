vim.keymap.set('v', '<leader>a', '<cmd>ChatGPTEditWithInstructions<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>a', '<cmd>ChatGPT<CR>', { noremap = true, silent = true })

return {
  'jackMort/ChatGPT.nvim',
  event = 'VeryLazy',
  config = function()
    require('chatgpt').setup {
      popup_input = {
        submit = '<S-CR>',
      },
      defaults = {
        openai_params = {
          model = 'gpt-4o',
          max_tokens = 4096,
        },
        openai_edit_params = {
          model = 'gpt-4o',
        },
        popup_layout = {
          default = 'right',
        },
      },
    }
  end,
  dependencies = {
    'MunifTanjim/nui.nvim',
    'nvim-lua/plenary.nvim',
    'folke/trouble.nvim',
    'nvim-telescope/telescope.nvim',
  },
}
