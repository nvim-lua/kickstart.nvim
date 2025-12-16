return {
  { -- Autocompletion
    'saghen/blink.cmp',
    event = 'VimEnter',
    version = '1.*',
    dependencies = {
      -- Snippet Engine
      {
        'L3MON4D3/LuaSnip',
        version = '2.*',
        build = (function()
          if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
            return
          end
          return 'make install_jsregexp'
        end)(),
        dependencies = {},
        opts = {},
      },
      'folke/lazydev.nvim',

      -- Copilot backend (Lua) -- disable inline/panel; we'll use Blink only
      {
        'zbirenbaum/copilot.lua',
        cmd = 'Copilot',
        build = ':Copilot auth',
        event = 'BufReadPost',
        opts = {
          suggestion = { enabled = false },
          panel = { enabled = false },
        },
      },

      -- Blink source for Copilot
      'giuxtaposition/blink-cmp-copilot',
    },

    --- @module 'blink.cmp'
    --- @type blink.cmp.Config
    opts = {
      keymap = { preset = 'default' },
      appearance = { nerd_font_variant = 'mono' },
      completion = { documentation = { auto_show = false, auto_show_delay_ms = 500 } },

      sources = {
        -- add "copilot" to the default sources
        default = { 'lsp', 'path', 'snippets', 'lazydev', 'copilot' },
        providers = {
          lazydev = { module = 'lazydev.integrations.blink', score_offset = 100 },

          -- define the Copilot provider for Blink
          copilot = {
            name = 'copilot',
            module = 'blink-cmp-copilot',
            async = true,
            score_offset = 100, -- slightly boost Copilot
            -- optional: mark items visually as "Copilot"
            transform_items = function(_, items)
              local Kind = require('blink.cmp.types').CompletionItemKind
              local idx = #Kind + 1
              Kind[idx] = 'Copilot'
              for _, item in ipairs(items) do
                item.kind = idx
              end
              return items
            end,
          },
        },
      },

      snippets = { preset = 'luasnip' },
      fuzzy = { implementation = 'lua' },
      signature = { enabled = true },
    },
  },
}
