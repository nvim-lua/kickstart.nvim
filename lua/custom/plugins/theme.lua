return {
  -- Theme inspired by Atom
  'navarasu/onedark.nvim',
  priority = 1000,
  config = function()
    vim.cmd.colorscheme 'onedark'
    local onedark = require('onedark')
    onedark.setup {
      colors = {
        bright_orange = "#ff8800", -- define a new color
        green = '#00ffaa',         -- redefine an existing color
      },
      highlights = {
        ["@string"] = { fmt = 'bold,italic', fg = '$orange' },
        ["@function"] = { sp = '$yellow' },
        ["@function.builtin"] = { fg = '#0059ff' },
        ["@parameter"] = { fg = '$cyan' },
        ["@variable.builtin"] = { fg = '$cyan' },
        ["@type.builtin"] = { fg = '#00ffff' },
        ["@lsp.type.parameter"] = { fg = "$cyan" },
        ["@lsp.typemod.function.defaultLibrary"] = { fg = "$yellow" }
      }
    }

    onedark.load()
  end,
};
