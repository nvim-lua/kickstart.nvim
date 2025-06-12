return {
  {
    'yetone/avante.nvim',
    event = 'VeryLazy',
    lazy = false,
    version = false,
    opts = {
      -- Use ANTHROPIC_API_KEY=your-api-key
      providers = {
        claude = {
          auto_suggestions_provider = 'claude', -- high-frequency provider (free recommended)
          claude = {
            endpoint = 'https://api.anthropic.com',
            model = 'claude-3-5-sonnet-20241022',
            temperature = 0,
            max_tokens = 4096,
          },
        },
      },
      hints = { enabled = false },
    },
    build = 'make', -- BUILD_FROM_SOURCE=true
    dependencies = {
      'stevearc/dressing.nvim',
      'nvim-lua/plenary.nvim',
      'MunifTanjim/nui.nvim',
      --- The below dependencies are optional,
      'hrsh7th/nvim-cmp', -- autocompletion for avante commands and mentions
      'echasnovski/mini.icons',
      {
        -- support for image pasting
        'HakonHarnes/img-clip.nvim',
        event = 'VeryLazy',
        opts = {
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = {
              insert_mode = true,
            },
            use_absolute_path = false,
          },
        },
      },
      {
        -- Make sure to set this up properly if you have lazy=true
        'MeanderingProgrammer/render-markdown.nvim',
        opts = {
          file_types = { 'markdown', 'Avante' },
        },
        ft = { 'markdown', 'Avante' },
      },
    },
    keys = {
      { '<leader>la', '<cmd>AvanteChat<cr>', desc = '[A]vante Chat' },
    },
  },
}
