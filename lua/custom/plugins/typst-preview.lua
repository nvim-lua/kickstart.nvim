return {
  'chomosuke/typst-preview.nvim',
  ft = 'typst',
  version = '1.*',
  opts = {
    port = 56643,
    dependencies_bin = { ['tinymist'] = 'tinymist' },
  },
}
