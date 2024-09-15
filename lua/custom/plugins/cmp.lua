return {
  -- Autocompletion
  'hrsh7th/nvim-cmp',
  dependencies = {
    -- Snippet Engine & its associated nvim-cmp source
    { 'L3MON4D3/LuaSnip', lazy = true },
    { 'saadparwaiz1/cmp_luasnip', lazy = true },

    -- Adds LSP completion capabilities
    { 'hrsh7th/cmp-nvim-lsp' },

    -- Adds a number of user-friendly snippets
    { 'rafamadriz/friendly-snippets', lazy = true },

    -- Optional sources for path and buffer completion
    { 'hrsh7th/cmp-path', lazy = true },
    { 'hrsh7th/cmp-buffer', lazy = true },

    -- Optional: additional completions for cmdline and git
    { 'hrsh7th/cmp-cmdline', lazy = true },
    { 'petertriho/cmp-git', lazy = true }, -- Git completions for commit messages

    -- Optional: icons for completion menu
    { 'onsails/lspkind-nvim', lazy = true }, -- Adds nice icons to completion
  },
  event = { 'InsertEnter', 'CmdlineEnter' },
  config = function()
    local cmp = require('cmp')
    local luasnip = require('luasnip')
    local lspkind = require('lspkind')

    -- Set completion options
    vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }

    local cmp_mappings = {
      ['<C-n>'] = cmp.mapping.select_next_item(),
      ['<C-p>'] = cmp.mapping.select_prev_item(),
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(), -- Trigger completion
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Confirm selection
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
      ['<C-e>'] = cmp.mapping.abort(), -- Abort completion
    }

    -- Setup LuaSnip configuration
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
          luasnip.lsp_expand(args.body) -- Expand snippets
        end,
      },
      sources = cmp.config.sources({
        { name = 'nvim_lsp' }, -- LSP completions
        { name = 'luasnip' }, -- Snippet completions
        { name = 'path' }, -- Path completions
        { name = 'buffer' }, -- Buffer completions
      }),
      window = {
        completion = cmp.config.window.bordered(), -- Border for completion window
        documentation = cmp.config.window.bordered(), -- Border for documentation window
      },
      formatting = {
        fields = { 'abbr', 'kind', 'menu' },
        format = lspkind.cmp_format({ -- Use lspkind for icons
          with_text = true,
          menu = {
            nvim_lsp = '[LSP]',
            luasnip = '[Snip]',
            buffer = '[Buffer]',
            path = '[Path]',
            cmdline = '[Cmd]',
            git = '[Git]',
          },
        }),
      },
      mapping = cmp.mapping.preset.insert(cmp_mappings),
    })

    -- Setup for SQL filetype with vim-dadbod-completion
    cmp.setup.filetype('sql', {
      sources = cmp.config.sources({
        { name = 'vim-dadbod-completion' },
        { name = 'buffer' },
      }),
    })

    -- Setup for markdown with buffer-only completions
    cmp.setup.filetype('markdown', {
      sources = cmp.config.sources({
        { name = 'buffer' },
      }),
    })

    -- Setup for cmdline '/' (search) and ':' (command) mode
    cmp.setup.cmdline('/', {
      mapping = cmp.mapping.preset.cmdline(cmp_mappings),
      sources = {
        { name = 'buffer' },
      },
    })

    cmp.setup.cmdline(':', {
      mapping = cmp.mapping.preset.cmdline(cmp_mappings),
      sources = cmp.config.sources({
        { name = 'path' },
        { name = 'cmdline' },
      }),
    })

    -- Setup git commit message completion
    cmp.setup.filetype('gitcommit', {
      sources = cmp.config.sources({
        { name = 'git' },
        { name = 'buffer' },
      }),
    })
  end,
}
