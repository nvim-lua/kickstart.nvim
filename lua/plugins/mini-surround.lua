return {
  'echasnovski/mini.surround',
  version = '*',
  event = 'VeryLazy',
  config = function()
    require('mini.surround').setup({
      -- Use mappings from centralized keymaps
      mappings = require('core.keymaps').mini_surround_keymaps
    })
  end,
}
