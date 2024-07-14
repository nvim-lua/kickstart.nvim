return {
  'amrbashir/nvim-docs-view',
  lazy = true,
  cmd = 'DocsViewToggle',
  opts = {
    position = 'right',
    width = 60,
  },
  keys = {
    {
      '<leader>dt',
      ':DocsViewToggle<enter>',
      desc = 'Toggle Documentation',
      mode = { 'n' },
    },
  },
}
