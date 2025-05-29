return {
  'nvimdev/lspsaga.nvim',
  config = function()
    require('lspsaga').setup({
      lightbulb = {
        enabled = true,
        sign = true,
        virtual_text = false,
        sign_priority = 20,
      },
    })
  end,
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
    'nvim-tree/nvim-web-devicons',
  },
}
