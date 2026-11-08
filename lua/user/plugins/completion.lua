-- [[ Completion: nvim-cmp + LuaSnip ]]
-- See `:help cmp` and `:help ins-completion`.

local cmp = require 'cmp'
local luasnip = require 'luasnip'
luasnip.config.setup {}

-- Snippet collection (friendly-snippets)
require('luasnip.loaders.from_vscode').lazy_load()

cmp.setup {
  window = { -- rounded borders around the completion and documentation windows
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  completion = { completeopt = 'menu,menuone,noinsert' },
  mapping = cmp.mapping.preset.insert {
    -- Select next / previous item
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-j>'] = cmp.mapping.select_next_item(),
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-k>'] = cmp.mapping.select_prev_item(),
    ['<Tab>'] = cmp.mapping.select_next_item(),
    ['<S-Tab>'] = cmp.mapping.select_prev_item(),

    -- Scroll the documentation window
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),

    -- Accept the completion (auto-imports / expands snippets when the server supports it)
    ['<C-y>'] = cmp.mapping.confirm { select = true },
    ['<C-CR>'] = cmp.mapping.confirm { select = true },

    -- Open the completion menu manually
    ['<C-Space>'] = cmp.mapping.complete {},

    -- Jump forward / backward between snippet placeholders
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
  sources = {
    { name = 'lazydev', group_index = 0 }, -- Neovim Lua API completions (Lua files only)
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'buffer' },
    { name = 'path' },
  },
}
