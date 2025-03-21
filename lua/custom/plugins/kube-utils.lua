return {
  {
    'h4ckm1n-dev/kube-utils-nvim',
    dependencies = { 'nvim-telescope/telescope.nvim' },
    lazy = true,
    event = 'VeryLazy',
    config = function()
      require('kube-utils-nvim').setup()
    end,
  },
}
