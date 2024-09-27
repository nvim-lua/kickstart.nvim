if true then
  return {}
end
return {
  'zbirenbaum/copilot-cmp',
  config = function()
    require('copilot_cmp').setup()
  end,
  opts = {
<<<<<<< HEAD
    filetypes = {
      ['.'] = false,
      go = true,
    },
=======
    filetypes = { ['.'] = false },
>>>>>>> 605d213 (disable copilot)
  },
}
