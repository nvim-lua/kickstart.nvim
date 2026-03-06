return {
  'folke/which-key.nvim',
  keys = {
    {
      '<leader>ya',
      function()
        require('custom.location_reference').copy_absolute_location_reference()
      end,
      mode = { 'n', 'x' },
      desc = '[Y]ank [A]bsolute ref',
    },
    {
      '<leader>yr',
      function()
        require('custom.location_reference').copy_relative_location_reference()
      end,
      mode = { 'n', 'x' },
      desc = '[Y]ank [R]elative ref',
    },
    {
      '<leader>yf',
      function()
        require('custom.location_reference').copy_buffer_file_reference()
      end,
      mode = { 'n', 'x' },
      desc = '[Y]ank Buffer [F]ile',
    },
    {
      '<leader>yd',
      function()
        require('custom.location_reference').copy_buffer_directory_reference()
      end,
      mode = { 'n', 'x' },
      desc = '[Y]ank Buffer [D]irectory',
    },
  },
  opts = function(_, opts)
    opts.spec = opts.spec or {}
    table.insert(opts.spec, { '<leader>y', group = '[Y]ank' })
  end,
}
