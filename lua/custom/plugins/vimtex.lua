return {
  'lervag/vimtex',
  lazy = false,
  init = function()
    vim.g.vimtex_view_general_viewer = 'C:/Users/ricar/AppData/Local/SumatraPDF/SumatraPDF.exe'
    vim.g.vimtex_view_general_options = '-reuse-instance -forward-search @tex @line @pdf'
  end,
}
