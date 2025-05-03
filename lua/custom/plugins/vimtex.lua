return {
  'lervag/vimtex',
  lazy = false,
  config = function()
    vim.g.vimtex_compiler_latexmk = {
      options = {
        '-lualatex',
        '-shell-escape',
        '-verbose',
        '-file-line-error',
        '-synctex=1',
        '-interaction=nonstopmode',
      },
    }
  end,
  init = function()
    vim.g.vimtex_view_general_viewer = 'C:/Users/ricar/AppData/Local/SumatraPDF/SumatraPDF.exe'
    vim.g.vimtex_view_general_options = '-reuse-instance -forward-search @tex @line @pdf'
  end,
}
