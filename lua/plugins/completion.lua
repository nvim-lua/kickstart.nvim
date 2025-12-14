-- Autocompletion configuration
--
return {
  'saghen/blink.cmp',
  dependencies = {
    'rafamadriz/friendly-snippets',
    'echasnovski/mini.icons',
    'onsails/lspkind-nvim',
  },
  event = 'VeryLazy',
  version = '*',
  opts = {
    enabled = function()
      return not vim.tbl_contains({ 'oil' }, vim.bo.filetype)
    end,
    keymap = {
      preset = 'enter',
      ['<C-h>'] = {
        function(cmp)
          cmp.show_documentation()
        end,
      },
      ['<tab>'] = {},
    },
    signature = { enabled = false },
    appearance = {
      -- use_nvim_cmp_as_default = true,
      nerd_font_variant = 'mono',
    },
    sources = {
      default = { 'lsp', 'path', 'snippets', 'buffer' },
    },

    cmdline = {
      keymap = {
        ['<Tab>'] = { 'show', 'select_next' },
        ['<S-Tab>'] = { 'select_prev' },
        ['<cr>'] = { 'select_and_accept', 'fallback' },
        ['<space>'] = { 'select_and_accept', 'fallback' },
        ['<right>'] = { 'select_and_accept', 'fallback' },
        ['<down>'] = { 'select_next', 'fallback' },
        ['<up>'] = { 'select_prev', 'fallback' },
        ['<esc>'] = {
          'cancel',
          function()
            vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<C-c>', true, false, true), 'n', true)
          end,
        },
      },

      sources = function()
        local type = vim.fn.getcmdtype()
        -- Search forward and backward
        if type == '/' or type == '?' then
          return {}
        end
        -- Commands
        if type == ':' or type == '@' then
          return { 'cmdline', 'path' }
        end
        return {}
      end,
      completion = { ghost_text = { enabled = false } },
    },

    completion = {
      trigger = {
        show_on_trigger_character = true,
      },
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 200,
        window = {
          border = 'rounded',
          winhighlight = 'Normal:Normal,FloatBorder:FloatBorder,CursorLine:BlinkCmpDocCursorLine,Search:None',
        },
      },
      list = {
        selection = {
          auto_insert = false,
        },
      },
      menu = {
        border = 'rounded',
        draw = {
          gap = 2,
          components = {
            kind_icon = {
              ellipsis = false,
              highlight = function(ctx)
                local _, hl, _ = require('mini.icons').get('lsp', ctx.kind)
                return hl
              end,
              text = function(ctx)
                local icon = require('lspkind').symbolic(ctx.kind, { mode = 'symbol' })
                return icon .. ctx.icon_gap
              end,
            },
          },
        },
        winhighlight = 'Normal:Normal,FloatBorder:FloatBorder,CursorLine:BlinkCmpMenuSelection,Search:None',
      },
    },
  },
  opts_extend = { 'sources.default' },
}
-- return {
--   {
--     'saghen/blink.cmp',
--     event = 'VimEnter',
--     version = '1.*',
--     dependencies = {
--       {
--         'L3MON4D3/LuaSnip',
--         version = '2.*',
--         build = (function()
--           if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
--             return
--           end
--           return 'make install_jsregexp'
--         end)(),
--         opts = {},
--       },
--       'folke/lazydev.nvim',
--     },
--     ---@module 'blink.cmp'
--     ---@type blink.cmp.Config
--     opts = {
--       keymap = {
--         preset = 'enter',
--       },
--
--       appearance = {
--         nerd_font_variant = 'mono',
--       },
--
--       completion = {
--         trigger = {
--           show_on_insert_on_trigger_character = true,
--         },
--         ghost_text = {
--           enabled = true,
--         },
--         menu = {
--           border = 'single',
--           draw = {
--             treesitter = { 'lsp' },
--             padding = { 0, 1 },
--             components = {
--               kind_icon = {
--                 text = function(ctx)
--                   local kind_icon, _, _ = require('mini.icons').get('lsp', ctx.kind)
--                   return kind_icon
--                 end,
--                 highlight = function(ctx)
--                   local _, hl, _ = require('mini.icons').get('lsp', ctx.kind)
--                   return hl
--                 end,
--               },
--               kind = {
--                 highlight = function(ctx)
--                   local _, hl, _ = require('mini.icons').get('lsp', ctx.kind)
--                   return hl
--                 end,
--               },
--             },
--           },
--         },
--         documentation = { auto_show = true, auto_show_delay_ms = 100, window = { border = 'single' } },
--       },
--
--       signature = { enabled = true, window = { border = 'single' } },
--
--       sources = {
--         default = { 'lsp', 'path', 'snippets', 'lazydev' },
--         providers = {
--           lazydev = { module = 'lazydev.integrations.blink', score_offset = 100 },
--         },
--       },
--
--       snippets = { preset = 'luasnip' },
--
--       fuzzy = {
--         sorts = {
--           'exact',
--           'score',
--           'sort_text',
--         },
--         implementation = 'rust',
--       },
--     },
--   },
-- }
