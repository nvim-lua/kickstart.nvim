return {
  'preservim/vim-wordy',
  config = function()
    vim.g.wordy_ring = {
      'weak',
      { 'being', 'passive-voice' },
      'business-jargon',
      'weasel',
      'puffery',
      { 'problematic', 'redundant' },
      { 'colloquial', 'idiomatic', 'similies' },
      'art-jargon',
      { 'contractions', 'opinion', 'vague-time', 'said-synonyms' },
      'adjectives',
      'adverbs',
    }

    vim.api.nvim_set_keymap('n', '<F8>', ':<C-u>NextWordy<CR>', { silent = true })
    vim.api.nvim_set_keymap('x', '<F8>', ':<C-u>NextWordy<CR>', { silent = true })
    vim.api.nvim_set_keymap('i', '<F8>', '<C-o>:NextWordy<CR>', { silent = true })
  end,
  ft = { 'markdown', 'mkd', 'textile', 'tex', 'text' },
}
