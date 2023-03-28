return {
  'hrsh7th/cmp-copilot',
  dependencies = { 'zbirenbaum/copilot.lua', 'github/copilot.vim' },
  config = function()
    local cmp = require 'cmp'
    local config = cmp.get_config()
    table.insert(config.sources, {
      name = 'copilot',
    })
    cmp.setup(config)
  end,
}
