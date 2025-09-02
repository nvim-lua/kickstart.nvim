-- Bootstrap lazy.nvim
require 'core.bootstrap'

-- Core settings (must be before plugins)
require 'core.options'
require 'core.keymaps'
require 'core.autocmds'

-- Load plugins via lazy.nvim
require('lazy').setup('plugins.spec', {
  change_detection = { enabled = true, notify = false },
  performance = {
    rtp = {
      disabled_plugins = {
        'gzip',
        'tarPlugin',
        'tohtml',
        'tutor',
        'zipPlugin',
      },
    },
  },
})
