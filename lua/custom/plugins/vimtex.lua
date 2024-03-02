-- File: lua/custom/plugins/vimtex.lua

return {
  'lervag/vimtex',
  config = function()
    -- vimtex configurations
    vim.g.vimtex_compiler_latexmk = {
      build_dir = 'build',
      executable = 'latexmk',
      options = {
        '-pdflua',
        '-interaction=nonstopmode',
        '-synctex=1',
        '-file-line-error',
        '-verbose',
      },
    }

    -- Enable automatic compilation on save
    vim.g.vimtex_autocompile = {
      callback = 1,
      continuous = 1,
      on_insert_leave = 1,
    }

    -- Turn off VimTeX indentation
    -- vim.g.vimtex_indent_enabled = 0

    -- Disable default mappings; I'll define my own
    -- vim.g.vimtex_mappings_enabled = 0

    -- Disable insert mode mappings (in favor of a dedicated snippet engine)
    -- vim.g.vimtex_imaps_enabled = 0

    -- Disable syntax conceal
    vim.g.vimtex_syntax_conceal_disable = 0

    -- Default is 500 lines and gave me lags on missed key presses
    vim.g.vimtex_delim_stopline = 50

    -- VimTeX toggle delimeter configuration
    vim.g.vimtex_delim_toggle_mod_list = {
      {'\\left', '\\right'},
      {'\\big', '\\big'},
    }
    
    -- Don't open quickfix for warning messages if no errors are present
    vim.g.vimtex_quickfix_open_on_warning = 0  

    --Disable some compilation warning messages
    vim.g.vimtex_quickfix_ignore_filters = {
      'LaTeX hooks Warning',
      'Underfull \\hbox',
      'Overfull \\hbox',
      'LaTeX Warning: .+ float specifier changed to',
      'Package siunitx Warning: Detected the "physics" package:',
      'Package hyperref Warning: Token not allowed in a PDF string',
      'Fatal error occurred, no output PDF file produced!',
    }

    -- Enable PDF preview using your favorite PDF viewer
    vim.g.vimtex_view_method = 'zathura_simple'
    -- vim.g.vimtex_view_general_viewer = 'okular'
    -- vim.g.vimtex_view_general_options = '--unique file:@pdf\\#src:@line@tex'
    -- Define the VimtexHookZathura function

end,
}

