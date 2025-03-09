return {
  'rgroli/other.nvim',
  lazy = false,
  config = function()
    require('other-nvim').setup {
      mappings = {
        'golang',
        { pattern = '/app/(.*)/(.*).rb', target = { { context = 'test', target = '/spec/%1/%2_spec.rb' } } },
        { pattern = '(.+)/spec/(.*)/(.*)_spec.rb', target = { { target = '%1/app/%2/%3.rb' } } },
      },
    }
  end,
  keys = {
    {
      '<leader>to',
      function()
        require('other-nvim').open()
      end,
      mode = 'n',
    },
    {
      '<leader>tO',
      function()
        require('other-nvim').openVSplit()
      end,
      mode = 'n',
    },
  },
}
