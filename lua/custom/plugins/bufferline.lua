return {
            'akinsho/bufferline.nvim', 
            dependencies = {'kyazdani42/nvim-web-devicons'},
            config = function()
                vim.opt.termguicolors = true
                require("bufferline").setup {}
            end
        }