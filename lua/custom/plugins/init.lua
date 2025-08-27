-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
-- Bootstrap lazy.nvim

return {
  { 'folke/snacks.nvim', opts = { image = { enabled = true } } },
  {
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'v3.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'MunifTanjim/nui.nvim',
      'nvim-tree/nvim-web-devicons', -- optional, but recommended
    },
    opts = {
      window = {
        mappings = {
          ['P'] = { -- toggle preview window
            'toggle_preview',
            config = { use_float = true, use_snacks_image = true, use_image_nvim = true },
          },
        },
      },
    },
    lazy = false, -- neo-tree will lazily load itself
  },

  {
    'ray-x/go.nvim',
    dependencies = {
      'ray-x/guihua.lua', -- required UI library
      'nvim-treesitter/nvim-treesitter',
      'neovim/nvim-lspconfig',
    },
    ft = { 'go', 'gomod' },
    config = function()
      require('go').setup {
        lsp_cfg = true, -- auto-setup gopls
        lsp_on_attach = function(client, bufnr)
          -- Auto format on save
          if client.server_capabilities.documentFormattingProvider then
            vim.api.nvim_create_autocmd('BufWritePre', {
              group = vim.api.nvim_create_augroup('GoFormat', { clear = true }),
              buffer = bufnr,
              callback = function()
                vim.lsp.buf.format { async = false }
              end,
            })
          end
        end,
      }
    end,
  },

  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    config = true,
  },

  -- ⬇️ Your gitsigns with blame-on-cursor
  {
    'lewis6991/gitsigns.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      local util = require 'gitsigns.util'
      require('gitsigns').setup {
        watch_gitdir = { interval = 1000, follow_files = true },
        numhl = true,
        linehl = false,
        word_diff = false,
        attach_to_untracked = true,

        current_line_blame = true,
        current_line_blame_opts = {
          virt_text = true,
          virt_text_pos = 'right_align', -- 'eol' | 'overlay' | 'right_align'
          delay = 500,
          ignore_whitespace = false,
          virt_text_priority = 100,
          use_focus = true,
        },
        current_line_blame_formatter = function(_, info)
          return {
            { '|| ', '@lsp.type.variable' },
            { info.author, '@lsp.type.comment' },
            { ' • ', '@lsp.type.variable' },
            { util.expand_format('<author_time:%R>', info), '@lsp.type.operator' },
            { ' • ', '@lsp.type.variable' },
            { info.summary or '', '@lsp.type.string' }, -- commit message
          }
        end,

        update_debounce = 200,
        max_file_length = 40000,
        preview_config = {
          border = 'rounded',
          style = 'minimal',
          relative = 'cursor',
          row = 0,
          col = 1,
        },
      }
    end,
  },
}
