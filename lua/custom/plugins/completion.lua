-- ~/.config/nvim/lua/custom/plugins/completion.lua

return {
  -- Completion framework
  {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    config = function()
      local cmp = require 'cmp'
      cmp.setup {
        snippet = {
          expand = function(args)
            vim.fn['vsnip#anonymous'](args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert {
          ['<C-p>'] = cmp.mapping.select_prev_item(),
          ['<C-n>'] = cmp.mapping.select_next_item(),
          ['<C-d>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.abort(),
          ['<CR>'] = cmp.mapping.confirm { select = true },
          ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif vim.fn == 1 then
              vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<Plug>(vsnip-expand-or-jump)', true, true, true), '')
            else
              fallback()
            end
          end, { 'i', 's' }),
          ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif vim.fn['vsnip#jumpable'](-1) == 1 then
              vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<Plug>(vsnip-jump-prev)', true, true, true), '')
            else
              fallback()
            end
          end, { 'i', 's' }),
        },
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'vsnip' },
        }, {
          { name = 'buffer' },
        }),
      }
    end,
  },

  -- LSP completion source
  { 'hrsh7th/cmp-nvim-lsp', after = 'nvim-cmp' },

  -- Buffer completion source
  { 'hrsh7th/cmp-buffer', after = 'nvim-cmp' },

  -- Path completion source
  { 'hrsh7th/cmp-path', after = 'nvim-cmp' },

  -- Snippet completion source
  { 'hrsh7th/cmp-vsnip', after = 'nvim-cmp' },

  -- Snippet engine
  { 'hrsh7th/vim-vsnip', event = 'InsertEnter' },
}
