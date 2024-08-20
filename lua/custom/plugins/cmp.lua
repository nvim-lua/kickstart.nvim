return {
  -- Autocompletion
  'hrsh7th/nvim-cmp',
  dependencies = {
    -- Snippet Engine & its associated nvim-cmp source
    'L3MON4D3/LuaSnip',
    'saadparwaiz1/cmp_luasnip',

    -- Adds LSP completion capabilities
    'hrsh7th/cmp-nvim-lsp',

    -- Adds a number of user-friendly snippets
    'rafamadriz/friendly-snippets',

    -- Optional sources
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-buffer',
  },
  event = { 'InsertEnter', 'CmdlineEnter' },
  config = function()
    -- Set completion options
    vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }

    -- Import required modules
    local cmp = require('cmp')
    local luasnip = require('luasnip')

    -- Setup luasnip
    luasnip.config.setup({
      history = true,
      updateevents = 'TextChanged,TextChangedI',
    })

    -- Lazy load snippets from friendly-snippets and custom snippets
    require('luasnip.loaders.from_vscode').lazy_load()
    require('luasnip.loaders.from_vscode').load(vim.fn.stdpath('config') .. '/snippets')

    -- Setup nvim-cmp
    cmp.setup({
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
        { name = 'buffer' },
        { name = 'path' },
      }),
      window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      },
      formatting = {
        fields = { 'abbr', 'kind', 'menu' },
        format = function(entry, item)
          local menu_icon = {
            nvim_lsp = 'λ',
            luasnip = '⋗',
            buffer = 'Ω',
            path = '🖫',
          }
          item.menu = menu_icon[entry.source.name] or entry.source.name
          return item
        end,
      },
      mapping = cmp.mapping.preset.insert({
        ['<C-n>'] = cmp.mapping.select_next_item(),
        ['<C-p>'] = cmp.mapping.select_prev_item(),
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
        ['<C-l>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          else
            fallback()
          end
        end, { 'i', 's' }),
        ['<C-h>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { 'i', 's' }),
        ['<C-e>'] = cmp.mapping.abort(),
      }),
    })

    -- Setup for SQL filetype with vim-dadbod-completion
    cmp.setup.filetype('sql', {
      sources = cmp.config.sources({
        { name = 'vim-dadbod-completion' },
        { name = 'buffer' },
      }),
    })
  end,
}

