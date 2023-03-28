return {
  'hrsh7th/cmp-nvim-lsp',
  config = function()
    local cmp = require 'cmp'
    local config = cmp.get_config()
    table.insert(config.sources, {
      name = 'nvim_lsp',
    })
    cmp.setup(config)
  end,
}
