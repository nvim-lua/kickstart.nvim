return {
  'lervag/vimtex',
  lazy = false, -- we don't want to lazy load VimTeX
  init = function()
    vim.g.vimtex_view_method = 'skim'

    vim.g.vimtex_syntax_enabled = 0
    -- vim.g.vimtex_compiler_method = "latexmk"
  end,
}
