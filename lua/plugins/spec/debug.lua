-- Debug Adapter Protocol (DAP) support
return {
  'mfussenegger/nvim-dap',
  dependencies = {
    -- DAP UI
    {
      'rcarriga/nvim-dap-ui',
      dependencies = { 'nvim-neotest/nvim-nio' },
    },
    
    -- Virtual text for debugging
    {
      'theHamsta/nvim-dap-virtual-text',
      opts = {},
    },
  },
  config = function()
    require('plugins.config.debug').setup()
  end,
}