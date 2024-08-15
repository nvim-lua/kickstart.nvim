return {
  'epwalsh/obsidian.nvim',
  version = '*', -- recommended, use latest release instead of latest commit
  lazy = false,
  ft = 'markdown',
  -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
  -- event = {
  --   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
  --   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/**.md"
  --   "BufReadPre path/to/my-vault/**.md",
  --   "BufNewFile path/to/my-vault/**.md",
  -- },
  dependencies = {
    -- Required.
    'nvim-lua/plenary.nvim',

    -- see below for full list of optional dependencies 👇
  },
  opts = {
    workspaces = {
      {
        name = 'Artemis',
        path = '~/Documents/Obsidian/Artemis/',
      },
    },

    completion = {
      nvim_cmp = true,
      min_chars = 2,
    },

    mappings = {
      -- Overrides the 'gf' mapping to work on markdown/wiki links within your vault.
      -- ['gf'] = {
      --   action = function()
      --     return require('obsidian').util.gf_passthrough()
      --   end,
      --   opts = { noremap = false, expr = true, buffer = true },
      -- },
      -- Toggle check-boxes.
      ['<leader>ch'] = {
        action = function()
          return require('obsidian').util.toggle_checkbox()
        end,
        opts = { buffer = true },
      },
      -- Smart action depending on context, either follow link or toggle checkbox.
      ['<cr>'] = {
        action = function()
          -- return require('obsidian').util.smart_action()
          vim.cmd 'ObsidianFollowLink'
        end,
        opts = { buffer = true, expr = true },
      },
    },

    notes_subdir = 'Inbox',
    new_notes_location = 'notes_subdir',

    preffered_link_style = 'wiki',
    note_id_func = function(title)
      return title
    end,

    templates = {
      folder = 'Templates',
      date_format = '%Y-%m-%d-%a',
      time_format = '%H:%M',
    },

    daily_notes = {
      folder = 'Daily Notes',
      date_format = '%Y-%m-%d',
      default_tags = { 'dailynote' },
    },

    ui = {
      enable = false, -- set to false to disable all additional syntax features
    },
  },
}
