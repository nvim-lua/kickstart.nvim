return {
  {
    'jackMort/ChatGPT.nvim',
    event = 'VeryLazy',
    config = function()
      require('chatgpt').setup {
        api_key_cmd = 'pass show azure/hypera/oai/idg-dev/token',
        api_host_cmd = 'echo -n ""',
        api_type_cmd = 'echo azure',
        azure_api_base_cmd = 'pass show azure/hypera/oai/idg-dev/base',
        azure_api_engine_cmd = 'pass show azure/hypera/oai/idg-dev/engine',
        azure_api_version_cmd = 'pass show azure/hypera/oai/idg-dev/api-version',
        predefined_chat_gpt_prompts = 'https://raw.githubusercontent.com/julianobarbosa/custom-gpt-prompts/main/prompt.csv',
      }
    end,
    dependencies = {
      'MunifTanjim/nui.nvim',
      'nvim-lua/plenary.nvim',
      'folke/trouble.nvim',
      'nvim-telescope/telescope.nvim',
    },
  },
}

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
