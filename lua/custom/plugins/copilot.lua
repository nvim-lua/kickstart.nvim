return {
    'github/copilot.vim',
    init = function()
      vim.g.copilot_no_tab_map = true
      vim.g.copilot_assume_mapped = true
    end,
    config = function()
      vim.keymap.set('i', '<C-e>', [[copilot#Accept("\<CR>")]], {
        silent = true,
        expr = true,
        script = true,
        replace_keycodes = false,
      })
    end,
  }
