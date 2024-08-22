-- python-debugging.lua: Debugging Python code with DAP
--

return {
  'mfussenegger/nvim-dap-python',
  keys = {
    {
      '<leader>dPt',
      function()
        require('dap-python').test_method()
      end,
      desc = 'Debug Method',
      ft = 'python',
    },
    {
      '<leader>dPc',
      function()
        require('dap-python').test_class()
      end,
      desc = 'Debug Class',
      ft = 'python',
    },
  },
  config = function()
    local path = require('mason-registry').get_package('debugpy'):get_install_path()
    require('dap-python').setup(os.getenv 'PYENV_ROOT' .. '/versions/3.11.9/bin/python')
  end,
}
