return {
  {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter', -- Load when entering insert mode
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      { -- LuaSnip and its potential build step
        'L3MON4D3/LuaSnip',
        -- Follow latest V2 release.
        version = 'v2.*',
        -- tag = '<your-desired-luasnip-tag>', -- Removed tag specification
        -- install jsregexp (optional!:).
        build = (function()
          -- Build Step is needed for regex support in snippets. This step is optional.
          -- Remove the below condition to build Luasnip with regex support on Mac and Linux.
          if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
            return
          end
          return 'make install_jsregexp'
        end)(),
      },
      'saadparwaiz1/cmp_luasnip', -- Snippet source for nvim-cmp
      -- Add other cmp sources if needed, e.g.:
      -- 'hrsh7th/cmp-cmdline',
    },
    config = function()
      local cmp = require 'cmp'
      local luasnip = require 'luasnip'
      luasnip.config.setup {} -- Setup luasnip first

      local function toggle_path_completion()
        local config = cmp.get_config()
        local snippet = config.snippet
        local completion = config.completion
        local mapping = config.mapping

        local path_enabled = vim.tbl_any(function(src)
          return src.name == 'path'
        end, config.sources)

        local new_sources = {
          { name = 'lazydev', group_index = 0 },
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
        }

        if not path_enabled then
          table.insert(new_sources, { name = 'path' })
        end

        cmp.setup {
          snippet = snippet,
          completion = completion,
          mapping = mapping,
          sources = new_sources,
        }

        print('Path completion ' .. (path_enabled and 'disabled' or 'enabled'))
      end

      -- Configure nvim-cmp
      cmp.setup {
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body) -- Expand snippets using luasnip
          end,
        },
        completion = {
          -- Set completeopt to have a better completion experience
          -- :help completeopt
          -- menuone: popup even when there's only one match
          -- noinsert: Do not insert text until a selection is made
          -- noselect: Do not select the first item by default
          completeopt = 'menu,menuone,noinsert',
        },
        -- Key Mappings for completion
        mapping = cmp.mapping.preset.insert {
          ['<C-n>'] = cmp.mapping.select_next_item(), -- Select next item
          ['<C-p>'] = cmp.mapping.select_prev_item(), -- Select previous item
          ['<C-b>'] = cmp.mapping.scroll_docs(-4), -- Scroll documentation back
          ['<C-f>'] = cmp.mapping.scroll_docs(4), -- Scroll documentation forward
          ['<C-y>'] = cmp.mapping.confirm { select = true }, -- Confirm selection
          ['<C-Space>'] = cmp.mapping.complete {}, -- Trigger completion manually

          -- Handle snippet jumping
          ['<C-l>'] = cmp.mapping(function()
            if luasnip.expand_or_locally_jumpable() then
              luasnip.expand_or_jump()
            end
          end, { 'i', 's' }), -- Jump forward in snippet
          ['<C-h>'] = cmp.mapping(function()
            if luasnip.locally_jumpable(-1) then
              luasnip.jump(-1)
            end
          end, { 'i', 's' }), -- Jump backward in snippet
        },
        -- Completion sources
        sources = cmp.config.sources {
          { name = 'nvim_lsp' }, -- LSP symbols
          { name = 'luasnip' }, -- Snippets
          { name = 'buffer' }, -- Words from current buffer
          { name = 'path' }, -- Filesystem paths
        },
        -- Add other cmp setup options from your old config if any
      }

      vim.keymap.set('n', '<leader>tp', toggle_path_completion, { desc = '[T]oggle [p]ath completion' })
    end, -- End of config function
  },
}
