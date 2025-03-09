return {
  'yetone/avante.nvim',
  event = 'VeryLazy',
  version = '*',
  opts = {
    provider = 'copilot',
    copilot = {
      endpoint = 'https://api.githubcopilot.com',
      model = 'claude-3.5-sonnet',
      proxy = nil,
      allow_insecure = false,
      timeout = 30000,
      temperature = 0.1,
      max_tokens = 8192,
    },
  },
  build = 'make',
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
    'stevearc/dressing.nvim',
    'nvim-lua/plenary.nvim',
    'MunifTanjim/nui.nvim',
    {
      'HakonHarnes/img-clip.nvim',
      event = 'VeryLazy',
      opts = {
        default = {
          embed_image_as_base64 = false,
          prompt_for_file_name = false,
          drag_and_drop = {
            insert_mode = true,
          },
          use_absolute_path = true,
        },
      },
    },
    {
      'MeanderingProgrammer/render-markdown.nvim',
      opts = {
        file_types = { 'markdown', 'Avante' },
      },
      ft = { 'markdown', 'Avante' },
    },
  },
  keys = {
    { '<leader>ax', '<cmd>AvanteClear<cr>', mode = 'n', desc = 'avante: clear chat' },
  },
}
