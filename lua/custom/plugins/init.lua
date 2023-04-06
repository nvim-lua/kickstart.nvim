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
    config = true,
  },
  {
    'phaazon/hop.nvim',
    branch = 'v2',
    config = function()
      require 'hop'.setup {}
    end
  },

  {
    "windwp/nvim-autopairs",
    lazy = true,
    config = function()
      require("nvim-autopairs").setup {}
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
  }
}
