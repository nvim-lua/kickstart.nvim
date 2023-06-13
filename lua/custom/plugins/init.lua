return {
  { "github/copilot.vim", },
  { "myusuf3/numbers.vim", },
  { "tpope/vim-eunuch", },
  { "tpope/vim-repeat", },
  { "tpope/vim-surround" },
  { "tribela/vim-transparent" },

  {
    "killtheliterate/nvim-reveal",
    dev = false,
    config = function()
      require('nvim-reveal').setup {}
    end
  },

  {
    'norcalli/nvim-base16.lua',
    lazy = false,
    priority = 1000,
    config = function()
      local base16 = require 'base16'

      base16(base16.themes[vim.env.BASE16_THEME or "3024"], true)
    end,
  },

  {
    "nvim-tree/nvim-web-devicons",
    lazy = true
  },

  {
    "danymat/neogen",
    dependencies = "nvim-treesitter/nvim-treesitter",
    config = function()
      require('neogen').setup {}
      vim.keymap.set('n', '<leader>nf', ":Neogen func<CR>", { noremap = true, desc = '[D]ocument [F]unction' })
    end,
  },

  {
    'ggandor/leap.nvim',
    dependencies = { "tpope/vim-repeat" },
    config = function()
      require('leap').add_default_mappings()
    end
  },

  {
    'phaazon/hop.nvim',
    cond = false,
    branch = 'v2',
    config = function()
      local hop = require('hop')
      local directions = require('hop.hint').HintDirection

      hop.setup {}

      vim.keymap.set(
        '',
        '<leader>h',
        function() hop.hint_char1({ direction = directions.AFTER_CURSOR }) end,
        { remap = true, desc = '[H]opChar1 forwards' }
      )

      vim.keymap.set(
        '',
        '<leader>H',
        function() hop.hint_char1({ direction = directions.BEFORE_CURSOR }) end,
        { remap = true, desc = '[H]opChar1 backwards' }
      )
    end
  },

  {
    "windwp/nvim-autopairs",
    lazy = true,
    config = function()
      require("nvim-autopairs").setup {}

      local cmp_autopairs = require('nvim-autopairs.completion.cmp')
      local cmp = require('cmp')
      cmp.event:on(
        'confirm_done',
        cmp_autopairs.on_confirm_done()
      )
    end,
  },

  {
    "kristijanhusak/vim-dirvish-git",
    dependencies = { "justinmk/vim-dirvish" },
  },

  {
    "folke/trouble.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("trouble").setup {}

      vim.keymap.set("n", "<leader>xx", "<cmd>TroubleToggle<cr>",
        { silent = true, noremap = true }
      )

      vim.keymap.set("n", "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>",
        { silent = true, noremap = true }
      )

      vim.keymap.set("n", "<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>",
        { silent = true, noremap = true }
      )

      vim.keymap.set("n", "<leader>xl", "<cmd>TroubleToggle loclist<cr>",
        { silent = true, noremap = true }
      )

      vim.keymap.set("n", "<leader>xq", "<cmd>TroubleToggle quickfix<cr>",
        { silent = true, noremap = true }
      )

      vim.keymap.set("n", "gR", "<cmd>TroubleToggle lsp_references<cr>",
        { silent = true, noremap = true }
      )
    end
  },

  {
    "jose-elias-alvarez/null-ls.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local null_ls = require("null-ls")

      null_ls.setup({
        sources = {
          null_ls.builtins.code_actions.eslint_d,
          null_ls.builtins.diagnostics.codespell,
          null_ls.builtins.diagnostics.eslint_d,
          null_ls.builtins.formatting.prettierd,
          -- null_ls.builtins.formatting.tidy,
        },
      })
    end
  },

  {
    "jay-babu/mason-null-ls.nvim",
    cond = false,
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason.nvim",
      "jose-elias-alvarez/null-ls.nvim",
    },
    config = function()
      require("mason-null-ls").setup({
        ensure_installed = {},
        automatic_installation = true,
        automatic_setup = false,
      })
    end,
  },

  {
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'JoosepAlviste/nvim-ts-context-commentstring',
    },
    config = function()
      require('nvim-treesitter.configs').setup {
        ensure_installed = {
          'css',
          'html',
          'javascript',
          'lua',
          'python',
          'scss',
          'tsx',
          'typescript',
          'vim',
        },

        context_commentstring = {
          enable = true,
          enable_autocmd = false,
        }
      }

      require('Comment').setup {
        pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
      }
    end
  },
}
