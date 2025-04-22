require('nvim-tree').setup {
  sort = {
    sorter = 'case_sensitive',
    folders_first = true,
    files_first = false,
  },
  view = {
    width = 30,
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = true,
  },
}
