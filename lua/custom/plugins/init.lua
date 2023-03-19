return {
  { "github/copilot.vim", },
  { "myusuf3/numbers.vim", },
  { "tpope/vim-eunuch", },
  { "tpope/vim-repeat", },
  { "tpope/vim-surround" },

  {
    "nvim-tree/nvim-web-devicons",
    opts = {}
  },

  {
    "windwp/nvim-autopairs",
    config = function()
      require("nvim-autopairs").setup {}
    end,
  },

  {
    "kristijanhusak/vim-dirvish-git",
    dependencies = {
      "justinmk/vim-dirvish",
    },
  },
}
