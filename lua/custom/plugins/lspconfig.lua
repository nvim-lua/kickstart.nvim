local lspconfig = require('lspconfig')

return {
  'neovim/nvim-lspconfig',
  config = function()
    -- Configure Python LSP (pylsp)
    lspconfig.pylsp.setup {
      settings = {
        pylsp = {
          plugins = {
            mypy = {
              enabled = true,
              live_mode = false,
            },
            pylint = {
              enabled = true,
            },
            pyflakes = {
              enabled = false,  -- Disable pyflakes if pylint is used
            },
          },
        },
      },
    }

  end,
}

