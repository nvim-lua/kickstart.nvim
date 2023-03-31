return {
  {
    "mfussenegger/nvim-dap",
  },

  {
    "rcarriga/nvim-dap-ui",
      requires = {'mfussenegger/nvim-dap'},
      config = function ()
        require('dapui').setup({})
      end
  },
  {
    "theHamsta/nvim-dap-virtual-text",
  },
  {
    "nvim-telescope/telescope-dap.nvim",
  },
  {
    "mfussenegger/nvim-dap-python",
  }
}
