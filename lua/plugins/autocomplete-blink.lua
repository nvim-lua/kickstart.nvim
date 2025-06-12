-- TODO: blink is faster than nvim-cmp, but still missing integration
-- with a good number of other plugins. fuzzy is still being improved.

return {
  {
    'saghen/blink.cmp',
    -- branch = 'fuzzy-scoring',
    -- commit = 'b9cca35c503f6d220b1162e604e06477db02a23c',
    version = 'v1.*',
    branch = 'main',
    commit = '2c3d276',
    event = 'InsertEnter',
    enabled = function()
      return vim.g.autocomplete_enable
    end,
    dependencies = {
      'saghen/blink.compat',
      {
        'L3MON4D3/LuaSnip',
        build = (function()
          if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
            return
          end
          return 'make install_jsregexp'
        end)(),
        dependencies = {
          -- `friendly-snippets` contains a variety of premade snippets.
          --    See the README about individual language/framework/plugin snippets:
          --    https://github.com/rafamadriz/friendly-snippets
          -- {
          --   'rafamadriz/friendly-snippets',
          --   config = function()
          --     require('luasnip.loaders.from_vscode').lazy_load()
          --   end,
          -- },
        },
      },
    },
    opts = {
      --cmdline = { enabled = false },
      cmdline = {
        keymap = {
          -- recommended, as the default keymap will only show and select the next item
          ['<Tab>'] = { 'show', 'accept' },
          ['<down>'] = { 'select_next', 'fallback' },
          ['<up>'] = { 'select_prev', 'fallback' },
          ['<left>'] = { 'scroll_documentation_up', 'fallback' },
          ['<right>'] = { 'scroll_documentation_down', 'fallback' },
          ['<C-g>'] = { 'cancel', 'fallback' },
          ['<C-h>'] = { 'show', 'fallback' },
        },
        completion = {
          menu = {
            auto_show = true,
          },
          list = {
            selection = {
              preselect = true,
              auto_insert = true,
            },
          },
        },
      },
      fuzzy = {
        implementation = 'lua', -- slower, more flexible, patchable
        sorts = { 'exact', 'score', 'sort_text' },
        use_frecency = false,
        use_proximity = false,
        max_typos = function()
          return 0
        end,
      },
      completion = {
        keyword = { range = 'full' },
        -- list = { selection = 'auto_insert' },
        trigger = {
          show_on_insert_on_trigger_character = false, -- Use C-Space
        },
        accept = {
          auto_brackets = {
            enabled = true,
          },
        },
        menu = {
          border = 'single',
          draw = {
            columns = {
              { 'kind_icon' },
              -- { 'source_name' },
              { 'label', 'label_description', gap = 1 },
            },
          },
        },
        documentation = {
          window = {
            border = 'single',
          },
        },
      },
      keymap = {
        preset = 'default',
        -- Disable conflicting emacs keys - let neovimacs handle them
        ['<C-k>'] = {}, -- Remove C-k (emacs: kill to end of line)
        ['<C-b>'] = {}, -- Remove C-b (emacs: backward char)
        ['<C-f>'] = {}, -- Remove C-f (emacs: forward char)
        ['<C-p>'] = {}, -- Remove C-p (emacs: previous line)
        ['<C-n>'] = {}, -- Remove C-n (emacs: next line)
        ['<C-e>'] = {}, -- Remove C-e (emacs: end of line)
        ['<C-y>'] = {}, -- Remove C-y (emacs: yank)
        ['<C-Space>'] = {}, -- Remove C-Space (emacs: highlight)

        -- Alternative completion navigation
        ['<M-j>'] = { 'select_next', 'fallback' }, -- Alt-j for next
        ['<M-k>'] = { 'select_prev', 'fallback' }, -- Alt-k for prev
        ['<M-h>'] = { 'scroll_documentation_up', 'fallback' }, -- Alt-h for doc up
        ['<M-l>'] = { 'scroll_documentation_down', 'fallback' }, -- Alt-l for doc down

        -- Keep arrow keys and other non-conflicting bindings
        ['<down>'] = { 'select_next', 'fallback' },
        ['<up>'] = { 'select_prev', 'fallback' },
        ['<left>'] = { 'scroll_documentation_up', 'fallback' },
        ['<right>'] = { 'scroll_documentation_down', 'fallback' },
        ['<Tab>'] = { 'accept', 'fallback' },
        ['<C-g>'] = { 'cancel', 'fallback' },
        ['<C-h>'] = { 'show', 'fallback' },
        ['<C-right>'] = {
          function(cmp)
            local luasnip = require 'luasnip'
            if luasnip.expand_or_locally_jumpable() then
              luasnip.expand_or_jump()
            else
              return cmp.fallback()
            end
          end,
          'fallback',
        },
        ['<C-left>'] = {
          function(cmp)
            local luasnip = require 'luasnip'
            if luasnip.locally_jumpable(-1) then
              luasnip.jump(-1)
            else
              return cmp.fallback()
            end
          end,
          'fallback',
        },
      },
      signature = {
        enabled = true,
        window = {
          border = 'single',
        },
      },
      sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
        per_filetype = {},
        -- TODO: broken
        providers = {
          tabnine = {
            name = 'Tabnine',
            module = 'blink.compat.source',
          },
        },
      },
      snippets = {
        preset = 'luasnip',
      },
    },
    config = function(_, opts)
      local luasnip = require 'luasnip'
      luasnip.config.setup {}

      require('blink.cmp').setup(opts)
    end,
  },
}
