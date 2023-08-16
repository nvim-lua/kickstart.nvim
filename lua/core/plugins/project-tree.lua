local setup = require "core.setup.async.project-tree"

return {
  {
    'nvim-tree/nvim-tree.lua',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    init = function()
      setup()
    end
  }
}
