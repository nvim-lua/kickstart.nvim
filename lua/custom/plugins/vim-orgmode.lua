return {
  'nvim-orgmode/orgmode',
  dependencies = {
    { 'nvim-treesitter/nvim-treesitter', lazy = true },
  },
  -- ADD THIS BACK LATER - SOMETHING WRONG, SO DOESNT START
  -- event = 'VeryLazy',
  config = function()
    -- Load treesitter grammar for org
    require('orgmode').setup_ts_grammar()

    -- Setup treesitter
    require('nvim-treesitter.configs').setup({
      highlight = {
        enable = true,
      },
      ensure_installed = { 'org' },
    })

    -- Setup orgmode
    require('orgmode').setup({
      org_agenda_files = '~/documents/orgfiles/**/*',
      org_default_notes_file = '~/documents/orgfiles/refile.org',
    })
  end,
}
