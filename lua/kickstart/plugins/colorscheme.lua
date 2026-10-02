vim.pack.add {{
  src = "https://github.com/catppuccin/nvim",
  name = "catppuccin",
}}

require("catppuccin").setup {
  no_italics = true,
}

if vim.o.background == "dark" then
  vim.cmd.colorscheme "catppuccin-mocha"
else
  vim.cmd.colorscheme "catppuccin-latte"
end

