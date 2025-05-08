return {
  {
    'lervag/vimtex',
    lazy = false,
    -- tag = "v2.15", -- uncomment to pin to a specific release
    config = function()
      --global vimtex settings
      vim.g.vimtex_imaps_enabled = 0 --i.e., disable them
      --vimtex_view_settings
      vim.g.vimtex_view_method = 'general' -- change this, depending on what you want to use..sumatraPDF, or skim, or zathura, or...
      vim.g.vimtex_view_general_options = '-reuse-instance -forward-search @tex @line @pdf'
      --quickfix settings
      vim.g.vimtex_quickfix_open_on_warning = 0 --  don't open quickfix if there are only warnings
      vim.g.vimtex_quickfix_ignore_filters =
        { 'Underfull', 'Overfull', 'LaTeX Warning: .\\+ float specifier changed to', 'Package hyperref Warning: Token not allowed in a PDF string' }
      --remove Warning
      vim.g.vimtex_syntax_enabled = 0
      -- Preview with PDF Viewer
      vim.g.vimtex_view_enabled = 1
      --  Use Zathura as the VimTeX PDF viewer
      vim.g.vimtex_view_method = 'zathura'
    end,
  },
}
