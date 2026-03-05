---@diagnostic disable: undefined-global
-- nvim-cmp setup module
local M = {}

function M.setup()
  local cmp = require 'cmp'
  local luasnip = require 'luasnip'
  local types = require 'cmp.types'
  local compare = require 'cmp.config.compare'
  luasnip.config.setup {}

  cmp.setup {
    snippet = {
      expand = function(args)
        luasnip.lsp_expand(args.body)
      end,
    },
    -- Improved completion settings - more like VSCode
    completion = { 
      completeopt = 'menu,menuone,noinsert',
      keyword_length = 1, -- Show completions after 1 character
      autocomplete = { types.cmp.TriggerEvent.TextChanged },
      get_trigger_characters = function(trigger_characters)
        -- Always add '.' as a trigger character to ensure method/property completions
        if not vim.tbl_contains(trigger_characters, '.') then
          table.insert(trigger_characters, '.')
        end
        if not vim.tbl_contains(trigger_characters, ':') then
          table.insert(trigger_characters, ':')
        end
        return trigger_characters
      end,
    },
    -- Custom sorting to prioritize fields and methods over snippets
    sorting = {
      priority_weight = 10, -- Increase weight to make priority differences more significant
      comparators = {
        -- Custom comparator that puts snippets at the end
        function(entry1, entry2)
          local types = require('cmp.types')
          
          -- Extract the kinds
          local kind1 = entry1:get_kind()
          local kind2 = entry2:get_kind()
          
          -- Define snippet kinds
          local snippet_kinds = {
            [types.lsp.CompletionItemKind.Snippet] = true
          }
          
          -- Check if either is a snippet
          local is_snippet1 = snippet_kinds[kind1] or false
          local is_snippet2 = snippet_kinds[kind2] or false
          
          -- If one is a snippet and the other isn't, the non-snippet comes first
          if is_snippet1 and not is_snippet2 then
            return false
          elseif not is_snippet1 and is_snippet2 then
            return true
          end
          
          -- Otherwise fall through to other comparators
          return nil
        end,
        compare.exact,          -- Exact match first
        compare.kind,           -- Sort by kind (functions first, then properties, etc)
        compare.sort_text,      -- Sort by LSP's sortText
        compare.score,          -- Score based
        compare.offset,         -- Closest to cursor
        compare.length,         -- Shorter first
        compare.order,          -- Source order
      },
    },
    -- Enhanced VSCode-like icons with more modern symbols
    formatting = {
      format = function(entry, vim_item)
        -- Set icons for completion types
        local kind_icons = {
          Text = "󰉿", Method = "󰆧", Function = "󰊕", Constructor = "",
          Field = "󰜢", Variable = "󰀫", Class = "󰠱", Interface = "",
          Module = "", Property = "󰜢", Unit = "", Value = "󰎠",
          Enum = "", Keyword = "󰌋", Snippet = "", Color = "󰏘",
          File = "󰈙", Reference = "", Folder = "󰉋", EnumMember = "",
          Constant = "󰏿", Struct = "", Event = "", Operator = "󰆕",
          TypeParameter = "󰊄", TypeAlias = "", Parameter = "", StaticMethod = "",
          Macro = "󰁌"
        }
        
        -- Enhanced formatting with better icons and spacing
        vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind] or '', vim_item.kind)
        
        -- Show more detailed source info
        vim_item.menu = ({
          buffer = "[Buffer]",
          nvim_lsp = "[LSP]",
          luasnip = "[Snippet]",
          path = "[Path]",
        })[entry.source.name]
        
        return vim_item
      end,
    },
    -- Enhanced documentation window
    window = {
      completion = cmp.config.window.bordered({
        winhighlight = "Normal:CmpPmenu,FloatBorder:CmpPmenuBorder,CursorLine:PmenuSel,Search:None",
        scrollbar = true,
        col_offset = -3,
        side_padding = 1,
      }),
      documentation = cmp.config.window.bordered({
        winhighlight = "Normal:CmpDoc",
      }),
    },
    mapping = cmp.mapping.preset.insert {
      ['<C-n>'] = cmp.mapping.select_next_item(),
      ['<C-p>'] = cmp.mapping.select_prev_item(),
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-y>'] = cmp.mapping.confirm { select = true },
      ['<Tab>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        elseif luasnip.expand_or_locally_jumpable() then
          luasnip.expand_or_jump()
        else
          fallback()
        end
      end, { 'i', 's' }),
      ['<S-Tab>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        elseif luasnip.locally_jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end, { 'i', 's' }),
      ['<C-Space>'] = cmp.mapping.complete {},
      ['<C-l>'] = cmp.mapping(function()
        if luasnip.expand_or_locally_jumpable() then
          luasnip.expand_or_jump()
        end
      end, { 'i', 's' }),
      ['<C-h>'] = cmp.mapping(function()
        if luasnip.locally_jumpable(-1) then
          luasnip.jump(-1)
        end
      end, { 'i', 's' }),
    },
    -- Configure completion sources by priority with tweaked settings
    sources = cmp.config.sources(
      {
        { name = 'nvim_lsp', priority = 1000, max_item_count = 50 },  -- LSP comes first with more items
        { name = 'path', priority = 500 },                           -- Then paths
        { name = 'buffer', priority = 250, keyword_length = 3 },      -- Then current buffer
        -- Snippets with extremely low priority and limited visibility
        { name = 'luasnip', priority = 10, max_item_count = 3, keyword_length = 4 },
      }
    ),
    -- Enable experimental features for VSCode-like experience
    experimental = {
      ghost_text = true,  -- Shows virtual text as preview
    },
  }

  -- Cmdline completion for search (/, ?) and command (:)
  -- Enhanced commandline completion with better history and formatting
  cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer', max_item_count = 20 }
    },
    window = {
      completion = cmp.config.window.bordered({
        winhighlight = "Normal:CmpPmenu,FloatBorder:CmpPmenuBorder,CursorLine:PmenuSel,Search:None",
        scrollbar = true,
      })
    },
    completion = {
      completeopt = 'menu,menuone,noinsert',
    }
  })

  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline({
      -- Explicit key mappings for command mode completion
      ['<Tab>'] = {
        c = function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          else
            cmp.complete()
            cmp.select_next_item()
          end
        end,
      },
      ['<S-Tab>'] = {
        c = function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          else
            cmp.complete()
            cmp.select_prev_item()
          end
        end,
      },
      ['<C-n>'] = {
        c = function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          else
            cmp.complete()
          end
        end,
      },
      ['<C-p>'] = {
        c = function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          else
            cmp.complete()
          end
        end,
      },
      ['<C-e>'] = {
        c = cmp.mapping.abort(),
      },
      ['<CR>'] = {
        c = cmp.mapping.confirm({ select = true }),
      },
    }),
    sources = cmp.config.sources({
      { name = 'path', max_item_count = 20 },
      { name = 'cmdline', max_item_count = 30, keyword_length = 1 }
    }),
    window = {
      completion = cmp.config.window.bordered({
        winhighlight = "Normal:CmpPmenu,FloatBorder:CmpPmenuBorder,CursorLine:PmenuSel,Search:None",
        scrollbar = true,
        col_offset = -3,
        side_padding = 1,
      })
    },
    formatting = {
      format = function(entry, vim_item)
        -- Only show item kind for cmdline completion
        vim_item.kind = ' '
        vim_item.menu = ''
        return vim_item
      end,
    },
    completion = {
      completeopt = 'menu,menuone,noinsert',
      autocomplete = { cmp.TriggerEvent.TextChanged },
    }
  })
end

return M
