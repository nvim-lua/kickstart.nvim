local setup_chatgpt = function()
  require('chatgpt').setup {
    openai_params = {
      model = 'gpt-4-turbo-preview',
      frequency_penalty = 0,
      presence_penalty = 0,
      max_tokens = 1000,
      temperature = 0,
      top_p = 1,
      n = 1,
    },
    openai_edit_params = {
      model = 'gpt-4-turbo-preview',
      temperature = 0,
      top_p = 1,
      n = 1,
    },
  }
end

return {
  'jackMort/ChatGPT.nvim',
  event = 'VeryLazy',
  config = setup_chatgpt,
  dependencies = {
    'MunifTanjim/nui.nvim',
    'nvim-lua/plenary.nvim',
    'folke/trouble.nvim',
    'nvim-telescope/telescope.nvim',
  },
}
