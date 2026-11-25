-- https://github.com/nvim-neo-tree/neo-tree.nvim

return {
  'nvim-neo-tree/neo-tree.nvim',
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    'MunifTanjim/nui.nvim',
  },
  lazy = false,
  keys = {
    { '\\', ':Neotree reveal<CR>', desc = 'NeoTree reveal', silent = true },
  },
  opts = {
    filesystem = {
      use_libuv_file_watcher = true,
      filtered_items = {
        always_show = {
          '.gitignore',
          '.gitlab-ci.yml',
          '.env',
        },
      },
      window = {
        mappings = {
          ['\\'] = 'close_window',
        },
      },
    },
  },
  config = function(_, opts)
    require('neo-tree').setup(opts)
    -- Refresh git status when git changes happen outside the tree (stage, commit, checkout, ...)
    local function refresh()
      local events = require 'neo-tree.events'
      events.fire_event(events.GIT_EVENT)
    end
    vim.api.nvim_create_autocmd({ 'FocusGained', 'ShellCmdPost', 'TermClose' }, { callback = refresh })
    vim.api.nvim_create_autocmd('User', { pattern = { 'GitSignsUpdate', 'GitSignsChanged' }, callback = refresh })
  end,
}
