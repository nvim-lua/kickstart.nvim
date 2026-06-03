return {
  {
    name = 'dotnet build',
    builder = function()
      return {
        cmd = { 'dotnet' },
        args = { 'build' },
        components = {
          'default',
          'on_output_quickfix',
          'on_result_diagnostics',
        },
      }
    end,
    condition = {
      filetype = { 'cs' },
    },
  },

  {
    name = 'dotnet run',
    builder = function()
      return {
        cmd = { 'dotnet' },
        args = { 'run' },
        components = {
          'default',
        },
      }
    end,
    condition = {
      filetype = { 'cs' },
    },
  },

  {
    name = 'dotnet test',
    builder = function()
      return {
        cmd = { 'dotnet' },
        args = { 'test' },
        components = {
          'default',
          'on_output_quickfix',
          'on_result_diagnostics',
        },
      }
    end,
    condition = {
      filetype = { 'cs' },
    },
  },

  {
    name = 'dotnet watch run',
    builder = function()
      return {
        cmd = { 'dotnet' },
        args = { 'watch', 'run' },
        components = {
          'default',
        },
      }
    end,
    condition = {
      filetype = { 'cs' },
    },
  },
}
