return {
  {
    'olimorris/codecompanion.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
    },
    opts = {
      adapters = {
        http = {
          anthropic = function()
            return require('codecompanion.adapters').extend('anthropic', {
              env = {
                api_key = os.getenv 'ANTHROPIC_API_KEY',
                model = 'claude-sonnet-4-20250514',
              },
            })
          end,
        },
      },
      strategies = {
        chat = { adapter = 'anthropic' },
        inline = { adapter = 'anthropic' },
        agent = { adapter = 'anthropic' },
      },
      display = {
        action_palette = {
          provider = 'snacks',
          opts = {
            show_default_actions = true, -- Show the default actions in the action palette?
            show_default_prompt_library = true, -- Show the default prompt library in the action palette?
            title = 'CodeCompanion actions', -- The title of the action palette
          },
        },
      },
      -- NOTE: The log_level is in `opts.opts`
      opts = {
        log_level = 'DEBUG', -- or "TRACE"
      },
    },
  },
  {
    'Exafunction/windsurf.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'hrsh7th/nvim-cmp',
    },
    config = function()
      require('codeium').setup {}
      vim.keymap.set('n', '<leader>tc', ':Codeium Toggle<CR>', { desc = 'Toggle Codeium' })
    end,
  },
}
