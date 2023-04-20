local dap = require('dap')
return function()
    local python_install_path = vim.fn.exepath('python')
    dap.adapters.python = {
      type = "executable",
      command = python_install_path, -- use "which python" command will give you python installed path
      args = {
        "-m",
        "debugpy.adapter",
      },
    }

    dap.configurations.python = {
      {
        type = "python",
        request = "launch",
        name = "Launch file",
        program = "${file}", -- This configuration will launch the current file if used.
        console= "integratedTerminal",
      },
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
      },
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
      },
    }
  end
