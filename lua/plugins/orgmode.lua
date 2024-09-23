return {
  'nvim-orgmode/orgmode',
  event = 'VeryLazy',
  ft = { 'org' },
  config = function()
    -- Setup orgmode
    require('orgmode').setup {
      org_agenda_files = {
        '~/Library/Mobile Documents/iCloud~md~obsidian/Documents/MarcsDailyNotes/**/*',
      },
      org_default_notes_file = '~/Library/Mobile Documents/iCloud~md~obsidian/Documents/MarcsDailyNotes/inbox/refile.org',
      org_capture_templates = {
        t = {
          description = 'Todo',
          datetree = {
            tree_type = 'day',
          },
          template = '**** TODO %?\n     Entered on: %U\n',
          target = '~/Library/Mobile Documents/iCloud~md~obsidian/Documents/MarcsDailyNotes/tasks/tasks.org',
        },
      },
    }

    -- NOTE: If you are using nvim-treesitter with ~ensure_installed = "all"~ option
    -- add ~org~ to ignore_install
    -- require('nvim-treesitter.configs').setup({
    --   ensure_installed = 'all',
    --   ignore_install = { 'org' },
    -- })
  end,
}
