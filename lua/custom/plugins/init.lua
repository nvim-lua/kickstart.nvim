-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {{
  "lervag/vimtex",
  lazy = false,     -- we don't want to lazy load VimTeX
  -- tag = "v2.15", -- uncomment to pin to a specific release
  init = function()
    -- VimTeX configuration goes here, e.g.
    vim.g.vimtex_view_method = "zathura"
  end
}, 
--[[ {
"iurimateus/luasnip-latex-snippets.nvim",
  config = function()
    require'luasnip-latex-snippets'.setup({use_treesitter=false})
    -- or setup({ use_treesitter = true })
    require("luasnip").config.setup({ enable_autosnippets = true })
  end,

} ]]}
