return {
  { "github/copilot.vim", },
  { "myusuf3/numbers.vim", },
  { "tpope/vim-eunuch", },
  { "tpope/vim-repeat", },
  { "tpope/vim-surround" },
  { "tribela/vim-transparent" },

  {
    "nvim-tree/nvim-web-devicons",
    opts = {}
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
    dependencies = { "justinmk/vim-dirvish", },
  },

  {
    "jose-elias-alvarez/null-ls.nvim",
    lazy = true,
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      -- @see: https://github.com/jay-babu/mason-null-ls.nvim
      -- might want to just use mason-null-ls. not yet sure what the advantage is.
      local null_ls = require("null-ls")
      null_ls.setup({
        sources = {
          null_ls.builtins.formatting.prettierd,
        },
      })
    end
  }
}
