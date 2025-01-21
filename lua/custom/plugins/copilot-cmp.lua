if true then
  return {}
else
  return {
    'zbirenbaum/copilot-cmp',
    config = function()
      require('copilot_cmp').setup()
    end,
    opts = {
      filetypes = {
        ['.'] = false,
        go = true,
      },
    },
  }
end
