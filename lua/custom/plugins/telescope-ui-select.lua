return {
  'nvim-telescope/telescope-ui-select.nvim',
  config = function()
    require('telescope').setup({
      extensions = {
        ['ui-select'] = {
          require('telescope.themes').get_dropdown {
          }
        }
      }
    })
    require('telescope').load_extension('ui-select')
  end,
  keys = { { '<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction' } },
}
