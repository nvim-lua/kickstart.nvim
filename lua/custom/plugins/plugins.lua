return {
  -- Other plugins in here
  {
    'nvim-tree/nvim-web-devicons',
  },
  {
    'stevearc/oil.nvim',
    opts = {},
    dependencies = { 'nvim-tree/nvim-web-devicons' }, -- optional icons
    keys = {
      { '<leader>e', '<cmd>Oil<CR>', desc = 'Open file explorer (Oil)' },
    },
  },
  {
    'ThePrimeagen/harpoon',
    branch = 'harpoon2',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('harpoon'):setup()
    end,
  },
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',
    },
    config = function()
      local cmp = require 'cmp'
      local luasnip = require 'luasnip'

      cmp.setup {
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert {
          ['<Tab>'] = cmp.mapping.select_next_item(),
          ['<S-Tab>'] = cmp.mapping.select_prev_item(),
          ['<CR>'] = cmp.mapping.confirm { select = true },
          ['<C-Space>'] = cmp.mapping.complete(),
        },
        sources = cmp.config.sources {
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
          { name = 'buffer' },
          { name = 'path' },
        },
      }
    end,
  },
  {
    'nvim-tree/nvim-tree.lua',
    version = '*', -- recommended
    lazy = false,
    dependencies = {
      'nvim-tree/nvim-web-devicons', -- optional, for file icons
    },
    opts = {
      view = {
        side = 'left',
        width = 30,
        float = { enable = false },
      },
      sync_root_with_cwd = true,
      respect_buf_cwd = true,
      update_focused_file = { enable = true, update_root = true },
      renderer = {
        group_empty = true,
        indent_width = 2,
      },
      actions = { open_file = { resize_window = true } },
    },
    init = function()
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1
    end,
    -- Other nvim-tree options can go here
    -- For example, to automatically close on file selection:
    -- auto_close = true,
    -- To show hidden files:
    -- hide_dotfiles = false,
  },
}
