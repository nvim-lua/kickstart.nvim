local dap = require('dap')
return function()
    dap.adapters.python = {
      type = "executable",
      command = "/usr/local/bin/python", -- use "which python" command and provide the python path
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
            "--log-file=tc_medusa.log"
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
