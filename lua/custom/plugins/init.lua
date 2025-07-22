--
-- See the kickstart.nvim README for more information
return {
  {
    'akinsho/bufferline.nvim',
    dependencies = 'nvim-tree/nvim-web-devicons',

    event = 'VeryLazy',
    keys = {
      { '<S-h>', '<cmd>BufferLineCyclePrev<cr>', desc = 'Prev Buffer' },
      { '<S-l>', '<cmd>BufferLineCycleNext<cr>', desc = 'Next Buffer' },
      { '<S-C-j>', '<cmd>BufferLineMovePrev<cr>', desc = 'Move buffer prev' },
      { '<S-C-k>', '<cmd>BufferLineMoveNext<cr>', desc = 'Move buffer next' },
    },
    opts = {
      options = {
        diagnostics = 'nvim_lsp',
        always_show_bufferline = true,
        diagnostics_indicator = function(count, level, diagnostics_dict, context)
          local icon = level:match 'error' and ' ' or ' '
          return ' ' .. icon .. count
        end,
        offsets = {
          {
            filetype = 'neo-tree',
            text = 'Neo-tree',
            highlight = 'Directory',
            text_align = 'left',
          },
          {
            filetype = 'snacks_layout_box',
          },
        },
        show_buffer_icons = true,
        color_icons = true,
      },
    },
  },
  {
    'mattn/emmet-vim',
  },
  {
    'yetone/avante.nvim',
    event = 'VeryLazy',
    version = false, -- Never set this value to "*"! Never!
    opts = {
      provider = 'deepseek',
      providers = {
        deepseek = {
          __inherited_from = 'openai',
          api_key_name = 'DEEPSEEK_API_KEY',
          endpoint = 'https://api.deepseek.com',
          model = 'deepseek-coder',
        },
      },
    },
    -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
    build = 'make',
    -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'stevearc/dressing.nvim',
      'nvim-lua/plenary.nvim',
      'MunifTanjim/nui.nvim',
      --- The below dependencies are optional,
      'echasnovski/mini.pick', -- for file_selector provider mini.pick
      'nvim-telescope/telescope.nvim', -- for file_selector provider telescope
      'hrsh7th/nvim-cmp', -- autocompletion for avante commands and mentions
      -- 'ibhagwan/fzf-lua', -- for file_selector provider fzf
      -- 'nvim-tree/nvim-web-devicons', -- or echasnovski/mini.icons
      'echasnovski/mini.icons', -- or echasnovski/mini.icons
      -- 'zbirenbaum/copilot.lua', -- for providers='copilot'
      -- {
      --   -- support for image pasting
      --   'HakonHarnes/img-clip.nvim',
      --   event = 'VeryLazy',
      --   opts = {
      --     -- recommended settings
      --     default = {
      --       embed_image_as_base64 = false,
      --       prompt_for_file_name = false,
      --       drag_and_drop = {
      --         insert_mode = true,
      --       },
      --       -- required for Windows users
      --       use_absolute_path = true,
      --     },
      --   },
      -- },
      {
        -- Make sure to set this up properly if you have lazy=true
        'MeanderingProgrammer/render-markdown.nvim',
        opts = {
          file_types = { 'markdown', 'Avante' },
        },
        ft = { 'markdown', 'Avante' },
      },
    },
  },
  { 'akinsho/toggleterm.nvim', version = '*', opts = {} },
  {
    'antosha417/nvim-lsp-file-operations',
    dependencies = {
      'nvim-lua/plenary.nvim',
      -- Uncomment whichever supported plugin(s) you use
      -- "nvim-tree/nvim-tree.lua",
      'nvim-neo-tree/neo-tree.nvim',
      -- "simonmclean/triptych.nvim"
    },
    config = function()
      require('lsp-file-operations').setup()
    end,
  },
  {
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      -- Add nvim-ts-autotag
      { 'windwp/nvim-ts-autotag' },
    },
    opts = {},
  },
}
