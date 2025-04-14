--
-- See the kickstart.nvim README for more information
return {
  {
    'akinsho/bufferline.nvim',
    dependencies = 'nvim-tree/nvim-web-devicons',

    event = 'VeryLazy',
    keys = {
      { '<leader>bp', '<Cmd>BufferLineTogglePin<CR>', desc = 'Toggle Pin' },
      { '<leader>bP', '<Cmd>BufferLineGroupClose ungrouped<CR>', desc = 'Delete Non-Pinned Buffers' },
      { '<leader>br', '<Cmd>BufferLineCloseRight<CR>', desc = 'Delete Buffers to the Right' },
      { '<leader>bl', '<Cmd>BufferLineCloseLeft<CR>', desc = 'Delete Buffers to the Left' },
      { '<S-j>', '<cmd>BufferLineCyclePrev<cr>', desc = 'Prev Buffer' },
      { '<S-k>', '<cmd>BufferLineCycleNext<cr>', desc = 'Next Buffer' },
      { '<S-C-j>', '<cmd>BufferLineMovePrev<cr>', desc = 'Move buffer prev' },
      { '<S-C-k>', '<cmd>BufferLineMoveNext<cr>', desc = 'Move buffer next' },
      { '[b', '<cmd>BufferLineCyclePrev<cr>', desc = 'Prev Buffer' },
      { ']b', '<cmd>BufferLineCycleNext<cr>', desc = 'Next Buffer' },
      { '[B', '<cmd>BufferLineMovePrev<cr>', desc = 'Move buffer prev' },
      { ']B', '<cmd>BufferLineMoveNext<cr>', desc = 'Move buffer next' },
    },
    opts = {
      options = {
	      -- stylua: ignore
              -- // close_command = require('bufdelete').bufdelete,
	      -- stylua: ignore
	      -- // right_mouse_command = require('bufdelete').bufdelete,
        diagnostics = 'nvim_lsp',
        always_show_bufferline = false,
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
    config = function(_, opts)
      require('bufferline').setup(opts)
      -- Fix bufferline when restoring a session
      vim.api.nvim_create_autocmd({ 'BufAdd', 'BufDelete' }, {
        callback = function()
          vim.schedule(function()
            pcall(nvim_bufferline)
          end)
        end,
      })
    end,
  },
  {
    'mattn/emmet-vim',
  },
  {
    'yetone/avante.nvim',
    event = 'VeryLazy',
    version = false, -- Never set this value to "*"! Never!
    opts = {
      provider = 'openrouter',
      vendors = {
        openai = {
          endpoint = 'https://api.openai.com/v1',
          model = 'gpt-4o', -- your desired model (or use gpt-4o, etc.)
          timeout = 30000, -- Timeout in milliseconds, increase this for reasoning models
          temperature = 0,
          max_completion_tokens = 8192, -- Increase this to include reasoning tokens (for reasoning models)
          --reasoning_effort = "medium", -- low|medium|high, only used for reasoning models
        },
        deepseek = {
          __inherited_from = 'openai',
          api_key_name = 'DEEPSEEK_API_KEY',
          api_endpoint = 'https://api.deepseek.com',
          model = 'deepseek-coder',
          max_tokens = 200,
        },
        openrouter = {
          __inherited_from = 'openai',
          endpoint = 'https://openrouter.ai/api/v1',
          api_key_name = 'OPENROUTER_API_KEY',
          model = 'mistralai/mistral-7b-instruct:free',
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
}
