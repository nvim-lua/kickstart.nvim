return {
  'mfussenegger/nvim-dap-python',
  dependencies = {
    'mfussenegger/nvim-dap',
  },
  config = function ()
    require('dap-python').setup('~/.venvs_python/debugpy/bin/python')
  end
}
