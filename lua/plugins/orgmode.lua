return {
  'nvim-orgmode/orgmode',
  event = 'VeryLazy',
  ft = { 'org' },
  config = function()
    -- Setup orgmode
    require('orgmode').setup {
      org_agenda_files = '~/orgfiles/**/*',
      org_default_notes_file = '~/orgfiles/refile.org',
      org_capture_templates = {
        x = {
          description = 'Journal Personal',
          datetree = {
            tree_type = 'day',
          },
          template = '\n**** %?\nEntered on %U\n',
          target = '~/OrgMode-Personal/002-Areas/journal.org',
        },
        j = {
          description = 'Journal Inmar',
          datetree = {
            tree_type = 'day',
          },
          template = '\n**** %?\nEntered on %U\n',
          target = '~/OrgMode-Inmar/OrgRoamRoot/002-Areas/journal.org',
        },
        -- Setup 1:1 capture templates
        s = {
          description = 'Sandeep 1:1',
          datetree = {
            tree_type = 'day',
          },
          template = '**** %?\nEntered on %U\n',
          target = '~/OrgMode-Inmar/OrgRoamRoot/002-Areas/OneOnOne/sandeep1on1.org',
        },
        d = {
          description = 'Debbie 1:1',
          datetree = {
            tree_type = 'day',
          },
          template = '**** %?\nEntered on %U\n',
          target = '~/OrgMode-Inmar/OrgRoamRoot/002-Areas/OneOnOne/debbie1on1.org',
        },
        b = {
          description = 'Billy 1:1',
          datetree = {
            tree_type = 'day',
          },
          template = '**** %?\nEntered on %U\n',
          target = '~/OrgMode-Inmar/OrgRoamRoot/002-Areas/OneOnOne/billy1on1.org',
        },
        t = {
          description = 'Taylor 1:1',
          datetree = {
            tree_type = 'day',
          },
          template = '**** %?\nEntered on %U\n',
          target = '~/OrgMode-Inmar/OrgRoamRoot/002-Areas/OneOnOne/taylor1on1.org',
        },
        a = {
          description = 'Asha 1:1',
          datetree = {
            tree_type = 'day',
          },
          template = '**** %?\nEntered on %U\n',
          target = '~/OrgMode-Inmar/OrgRoamRoot/002-Areas/OneOnOne/asha1on1.org',
        },
        g = {
          description = 'Gerald 1:1',
          datetree = {
            tree_type = 'day',
          },
          template = '**** %?\nEntered on %U\n',
          target = '~/OrgMode-Inmar/OrgRoamRoot/002-Areas/OneOnOne/gerald1on1.org',
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
