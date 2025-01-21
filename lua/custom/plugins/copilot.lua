if true then
  return {}
else
  return {
    'zbirenbaum/copilot.lua',
    opts = {
      suggestion = { enabled = false },
      panel = { enabled = false },
      filetypes = {
        ['.'] = false,
        go = true,
      },
    },
  }
end
