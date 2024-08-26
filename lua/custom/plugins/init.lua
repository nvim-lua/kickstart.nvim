-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  {
    'amitds1997/remote-nvim.nvim',
    version = '*', -- Pin to GitHub releases
    dependencies = {
      'nvim-lua/plenary.nvim', -- For standard functions
      'MunifTanjim/nui.nvim', -- To build the plugin UI
      'nvim-telescope/telescope.nvim', -- For picking between different remote methods
    },
    config = function()
      require('remote-nvim').setup {
        server = 'localhost',
        port = 8765,
        -- additional configuration options
      }
    end,
  },

  {
    'yetone/avante.nvim',
    event = 'VeryLazy',
    build = 'make',
    opts = {
      -- add any opts here
    },
    dependencies = {
      'nvim-tree/nvim-web-devicons',
      'echasnovski/mini.icons',
      'stevearc/dressing.nvim',
      'nvim-lua/plenary.nvim',
      'MunifTanjim/nui.nvim',
      -- The below is optional, make sure to setup it properly if you have lazy=true
      {
        'MeanderingProgrammer/render-markdown.nvim',
        opts = {
          file_types = { 'markdown', 'Avante' },
        },
        ft = { 'markdown', 'Avante' },
      },
    },
    config = function()
      local provider = 'openai'

      -- Configuration specific to Claude (replace with OpenAI if necessary)
      local openai = {
        endpoint = 'https://api.openai.com/v1',
        model = 'gpt-4o', -- Replace with the desired OpenAI model
        temperature = 0.7,
        max_tokens = 4096,
      }

      -- Key mappings
      local mappings = {
        ask = '<leader>aa',
        edit = '<leader>ae',
        refresh = '<leader>ar',
        diff = {
          ours = 'co',
          theirs = 'ct',
          none = 'c0',
          both = 'cb',
          next = ']x',
          prev = '[x',
        },
        jump = {
          next = ']]',
          prev = '[[',
        },
        submit = {
          normal = '<CR>',
          insert = '<C-s>',
        },
        toggle = {
          debug = '<leader>ad',
          hint = '<leader>ah',
        },
      }

      -- UI and window settings
      local windows = {
        wrap = true, -- similar to vim.o.wrap
        width = 30, -- default % based on available width
        sidebar_header = {
          align = 'center', -- left, center, right for title
          rounded = true,
        },
      }

      -- Highlights for diffs
      local highlights = {
        diff = {
          current = 'DiffText',
          incoming = 'DiffAdd',
        },
      }

      -- Diff configuration
      local diff = {
        debug = false,
        autojump = true,
        list_opener = 'copen',
      }

      -- Set up Avante.nvim with the OpenAI provider and custom configurations
      require('avante').setup {
        provider = provider,
        openai = openai,
        mappings = mappings,
        hints = { enabled = true },
        windows = windows,
        highlights = highlights,
        diff = diff,
      }
    end,
  },
}
