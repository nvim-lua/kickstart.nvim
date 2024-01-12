-- File: lua/custom/plugins/vimtex.lua

return {
  'lervag/vimtex',
  config = function()
    -- vimtex configurations
    vim.g.vimtex_compiler_latexmk = {
      build_dir = 'build',
      executable = 'latexmk',
      options = {
        '-pdf',
        '-interaction=nonstopmode',
        '-synctex=1',
      },
    }

    -- Enable automatic compilation on save
    vim.g.vimtex_autocompile = {
      continuous = 1,
      on_insert_leave = 1,
    }

    -- Enable PDF preview using your favorite PDF viewer
    vim.g.vimtex_view_method = 'zathura'
    -- vim.g.vimtex_view_general_viewer = 'okular'
    -- vim.g.vimtex_view_general_options = '--unique file:@pdf\\#src:@line@tex'
  end,
}

