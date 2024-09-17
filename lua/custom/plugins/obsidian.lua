return {
  'epwalsh/obsidian.nvim',
  version = '*',
  lazy = false,
  ft = 'markdown',
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  opts = {
    workspaces = {
      {
        name = 'personal',
        path = '/home/martin/Obsidian/vaults/personal',
        default_tags = { 'personal-notes' },
        overrides = {
          notes_subdir = 'vaults/personal/notes/',
        },
      },
      {
        name = 'work',
        path = '/home/martin/Obsidian/vaults/work',
        default_tags = { 'work-notes' },
        overrides = {
          notes_subdir = 'vaults/work/notes/',
        },
      },
      {
        name = 'daily',
        path = '/home/martin/Obsidian/vaults/daily',
        overrides = {
          notes_subdir = 'notes',
        },
      },
    },
    templates = {
      folder = '/home/martin/Obsidian/templates',
      date_format = '%Y-%m-%d',
      time_format = '%H:%M',
    },
    daily_notes = {
      date_format = '%Y-%m-%d',
      alias_format = '%B %-d, %Y',
      default_tags = { 'daily-notes' },
      template = 'daily.md',
    },
    completion = {
      nvim_cmp = true,
      min_chars = 2,
    },
    mappings = {
      ['gf'] = {
        action = function()
          return require('obsidian').util.gf_passthrough()
        end,
        opts = { noremap = false, expr = true, buffer = true },
      },
    },
    new_notes_location = 'notes_subdir',
    note_id_func = function(title)
      local suffix = ''
      local current_time = os.date '%Y-%m-%d-%H%M'
      if title ~= nil then
        suffix = title:gsub(' ', '-'):gsub('[^A-Za-z0-9-]', ''):lower()
      else
        for _ = 1, 4 do
          suffix = suffix .. string.char(math.random(65, 90))
        end
      end
      return current_time .. '-' .. suffix
    end,
  },
  config = function(_, opts)
    require('obsidian').setup(opts)
    -- Load the custom key mappings
    require('obsidian_keymaps').setup_keymaps()
  end,
}
