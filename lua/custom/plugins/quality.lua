return {
  {
    'folke/noice.nvim',
    event = 'VeryLazy',
    config = function()
      require('noice').setup {
        lsp = {
          -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
          override = {
            ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
            ['vim.lsp.util.stylize_markdown'] = true,
            ['cmp.entry.get_documentation'] = true, -- requires hrsh7th/nvim-cmp
          },
        },
        -- you can enable a preset for easier configuration
        presets = {
          bottom_search = true, -- use a classic bottom cmdline for search
          command_palette = true, -- position the cmdline and popupmenu together
          long_message_to_split = true, -- long messages will be sent to a split
          inc_rename = false, -- enables an input dialog for inc-rename.nvim
          lsp_doc_border = false, -- add a border to hover docs and signature help
        },
      }
    end,
    dependencies = {
      'MunifTanjim/nui.nvim',
      'rcarriga/nvim-notify',
    },
  },
  {
    'windwp/nvim-autopairs',
    dependencies = { 'hrsh7th/nvim-cmp' },
    config = function()
      require('nvim-autopairs').setup {}
      local cmp_autopairs = require 'nvim-autopairs.completion.cmp'
      local cmp = require 'cmp'
      cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
    end,
  },
  {
    'stevearc/dressing.nvim',
    opts = {},
  },
  {
    'echasnovski/mini.surround',
    config = function()
      require('mini.surround').setup {
        mappings = {
          add = 'sa', -- Add surrounding in Normal and Visual modes
          delete = 'sd', -- Delete surrounding
          find = 'sf', -- Find surrounding (to the right)
          find_left = 'sF', -- Find surrounding (to the left)
          highlight = 'sh', -- Highlight surrounding
          replace = 'sr', -- Replace surrounding
          update_n_lines = 'sn', -- Update `n_lines`

          suffix_last = 'l', -- Suffix to search with "prev" method
          suffix_next = 'n', -- Suffix to search wwth "next" method
        },
      }
    end,
  },
  {
    'TobinPalmer/Tip.nvim',
    event = 'VimEnter',
    init = function()
      -- Default config
      --- @type Tip.config
      require('tip').setup {
        seconds = 2,
        title = 'Tip!',
        url = 'https://vtip.43z.one', -- Or https://vimiscool.tech/neotip
      }
    end,
  },
  {
    'NvChad/nvim-colorizer.lua',
    config = function()
      require('colorizer').setup {}
    end,
  },

  {
    'michaelb/sniprun',
    branch = 'master',

    build = 'sh install.sh',
    -- do 'sh install.sh 1' if you want to force compile locally
    -- (instead of fetching a binary from the github release). Requires Rust >= 1.65

    config = function()
      require('sniprun').setup {
        -- your options
      }
    end,
  },
  {
    'Exafunction/codeium.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'hrsh7th/nvim-cmp',
      'onsails/lspkind.nvim',
    },
    config = function()
      require('codeium').setup {}
    end,
  },
  {
    'nvim-tree/nvim-web-devicons',
    config = function()
      require('nvim-web-devicons').setup {}
    end,
  },
  {
    'rose-pine/neovim',
    name = 'rose-pine',
    priority = 1000,
    init = function()
      vim.cmd.colorscheme 'rose-pine-main'
    end,
    config = function()
      require('rose-pine').setup {}
    end,
  },
  {
    -- Set lualine as statusline
    'nvim-lualine/lualine.nvim',
    -- See `:help lualine.txt`
    opts = {
      options = {
        icons_enabled = false,
        theme = 'powerline_dark',
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
      },
    },
  },
  {
    'nvim-tree/nvim-web-devicons',
    setup = function()
      require('nvim-web-devicons').setup {}
    end,
  },
}
