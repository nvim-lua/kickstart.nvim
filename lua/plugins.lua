return require('packer').startup(function(use)

    -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  use({
    "kylechui/nvim-surround",
    tag = "*", -- Use for stability; omit to use `main` branch for the latest features
    config = function()
        require("nvim-surround").setup({
            -- Configuration here, or leave empty to use defaults
        })
    end
  })

  use 'junegunn/vim-easy-align'

end)
