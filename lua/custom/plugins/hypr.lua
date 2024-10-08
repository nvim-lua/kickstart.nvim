local hypr = {
  vim.filetype.add {
    pattern = { ['.*/hypr/.*%.conf'] = 'hyprlang' },
  },
}

return hypr
