return {
  'akinsho/git-conflict.nvim',
  version = '*',
  opts = {
    default_mappings = false, -- disable buffer local mapping created by this plugin
    default_commands = true, -- disable commands created by this plugin
    disable_diagnostics = true, -- This will disable the diagnostics in a buffer whilst it is conflicted
    highlights = {
      incoming = 'DiffText',
      current = 'DiffAdd',
    },
  },
  config = function()
    require('git-conflict').setup()
  end,
}

--[[
Mappings:
  ]x - move to the next conflict
  [x - move to the previous conflict
  co - choose the current change
  ci - choose the incoming change
  cb - choose both changes
  c0 - choose none of the changes
--]]
