return {
  {
    'nvim-orgmode/orgmode',
    event = 'VeryLazy',
    ft = { 'org' },
    config = function()
      require('orgmode').setup {
        org_agenda_files = '~/vault/projects/**/*',
        org_default_notes_file = '~/vault/projects/refile.org',
      }
    end,
  },
  {
    'renerocksai/telekasten.nvim',
    dependencies = { 'nvim-telescope/telescope.nvim' },
  },
  {
    --'MeanderingProgrammer/render-makrdown.nvim',
    --dependecies = { 'nvim-treesitter/nvim-treesitter', 'nvim-mini/mini.nvim' },
    --@module 'render-markdown'
  },
}
