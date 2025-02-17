return {
  'mrloop/telescope-git-branch.nvim',
  config = function()
    require('telescope').load_extension 'git_branch'
  end,
}
