-- Colorscheme: https://github.com/catppuccin/nvim

vim.pack.add { { src = 'https://github.com/catppuccin/nvim', name = 'catppuccin' } }

---@diagnostic disable-next-line: missing-fields
require('catppuccin').setup {
  flavour = 'mocha', -- latte, frappe, macchiato, mocha
  no_italic = false,
  styles = {
    comments = {}, -- Disable italics in comments
  },
  integrations = {
    gitsigns = true,
    nvimtree = true,
    telescope = { enabled = true },
    which_key = true,
    mini = { enabled = true },
  },
}

vim.cmd.colorscheme 'catppuccin'
