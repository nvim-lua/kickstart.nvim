return {
  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    config = true,
    -- use opts = {} for passing setup options
    -- this is equivalent to setup({}) function
  },
  {
    'karb94/neoscroll.nvim',
    config = function()
      require('neoscroll').setup {}
    end,
  },
  {
    'christoomey/vim-tmux-navigator',
    cmd = {
      'TmuxNavigateLeft',
      'TmuxNavigateDown',
      'TmuxNavigateUp',
      'TmuxNavigateRight',
      'TmuxNavigatePrevious',
    },
    keys = {
      { '<c-h>', '<cmd><C-U>TmuxNavigateLeft<cr>' },
      { '<c-j>', '<cmd><C-U>TmuxNavigateDown<cr>' },
      { '<c-k>', '<cmd><C-U>TmuxNavigateUp<cr>' },
      { '<c-l>', '<cmd><C-U>TmuxNavigateRight<cr>' },
      { '<c-\\>', '<cmd><C-U>TmuxNavigatePrevious<cr>' },
    },
  },
  {
    'stevearc/resession.nvim',
    -- opts = {
    config = function()
      local resession = require 'resession'

      ---@diagnostic disable-next-line: missing-parameter
      resession.setup()

      -- Resession does NOTHING automagically, so we have to set up some keymaps
      vim.keymap.set('n', '<leader>Ss', resession.save, { desc = 'Save Session' })
      vim.keymap.set('n', '<leader>SL', resession.load, { desc = 'Load Session' })
      vim.keymap.set('n', '<leader>Sd', resession.delete, { desc = 'Delete Session' })
      vim.keymap.set('n', '<leader>Sl', function()
        require('resession').load 'Last'
      end, { desc = 'Load last session' })

      vim.api.nvim_create_autocmd('VimLeavePre', {
        callback = function()
          -- Always save a special session named "last"
          resession.save 'last'
        end,
      })
    end,
    -- },
  },
  {
    'rcarriga/nvim-notify',
  },
  {
    'folke/noice.nvim',
    event = 'VeryLazy',
    opts = {
      -- require('notify').setup {
      --   background_colour = '#000000',
      -- },
      -- add any options here
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
      vim.keymap.set('n', '<leader>nl', function()
        require('noice').cmd 'last'
      end, { desc = 'Last Message' }),

      vim.keymap.set('n', '<leader>nd', function()
        require('noice').cmd 'dismiss'
      end, { desc = 'Dismiss Message' }),

      vim.keymap.set('n', '<leader>nh', function()
        require('noice').cmd 'history'
      end, { desc = 'History' }),
    },
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      'MunifTanjim/nui.nvim',
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      'rcarriga/nvim-notify',
    },
    config = function()
      require('noice').setup {
        -- Your existing configuration
      }
      -- Set the background color for NotifyBackground highlight group
      vim.cmd [[highlight NotifyBackground guibg=#000000]]
    end,
  },
  { 'fladson/vim-kitty' },
  {
    'f-person/git-blame.nvim',
    -- load the plugin at startup
    event = 'VeryLazy',
    -- Because of the keys part, you will be lazy loading this plugin.
    -- The plugin wil only load once one of the keys is used.
    -- If you want to load the plugin at startup, add something like event = "VeryLazy",
    -- or lazy = false. One of both options will work.
    opts = {
      -- your configuration comes here
      -- for example
      enabled = true, -- if you want to enable the plugin
      message_template = ' <summary> • <date> • <author> • <<sha>>', -- template for the blame message, check the Message template section for more options
      date_format = '%m-%d-%Y %H:%M:%S', -- template for the date, check Date format section for more options
      virtual_text_column = 1, -- virtual text start column, check Start virtual text at column section for more options
    },
  },
  {
    'FabijanZulj/blame.nvim',
    init = function()
      vim.api.nvim_set_keymap('n', '<Leader>gB', ':BlameToggle<CR>', { noremap = true, silent = true })
    end,
    config = true,
  },
}
