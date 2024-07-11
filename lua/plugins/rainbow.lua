return {
  {
    'HiPhish/rainbow-delimiters.nvim',
    config = function(_, opts)
      require('rainbow-delimiters.setup').setup(opts)
    end,
  },
}
