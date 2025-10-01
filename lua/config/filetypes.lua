-- Filetype detection configuration
-- This file ensures proper filetype detection for various languages

-- Kotlin filetype detection
vim.filetype.add({
  extension = {
    kt = 'kotlin',
    kts = 'kotlin',
  },
  pattern = {
    ['.*%.kt$'] = 'kotlin',
    ['.*%.kts$'] = 'kotlin',
  },
})

-- Ensure treesitter highlights are applied
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'kotlin', 'java' },
  callback = function()
    vim.treesitter.start()
  end,
})
