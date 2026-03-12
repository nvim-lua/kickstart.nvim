return {
  'jiaoshijie/undotree',
  dependencies = 'nvim-lua/plenary.nvim',
  config = true,
  keys = {
    {
      '<leader>tu',
      function()
        -- load the plugin only when using it's keybinding
        require('undotree').toggle()
      end,
      desc = '[T]oggle [U]ndotree',
    },
  },
}
