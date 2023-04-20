return function()
    --local python_install_path = vim.fn.exepath('python')
    require('dap-python').setup() -- Debug with default settings.
    
    -- We can set additional custom config by below mechanism as well
    --[[
    table.insert(require('dap').configurations.python,
    {
      type = 'python',
      request = 'launch',
      name = 'My custom launch configuration',
      program = '${file}',
      cwd = vim.fn.getcwd(),
      console= "integratedTerminal",
    })
    --]]
    
    table.insert(require('dap').configurations.python,
    {
        name= "Pytest: Current File",
        type= "python",
        request= "launch",
        module= "pytest",
        args= {
            "${file}",
            "-sv",
            "--log-cli-level=INFO",
            "--log-file=test_out.log"
        },
        console= "integratedTerminal",
      })
    table.insert(require('dap').configurations.python,
      {
        name= "Profile python: Current File",
        type= "python",
        request= "launch",
        module= "cProfile",
        args= {
            "-o",
            "/tmp/profile.dat",
            "${file}"
        },
        console= "integratedTerminal",
      })
end
