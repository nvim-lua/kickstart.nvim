return { 'gzagatti/vim-leuven-theme',
            config = function()
                vim.opt.termguicolors = true
                vim.opt.guicursor = 'a:blinkon0-Cursor,i-ci:ver100'
                -- vim.cmd([[ colorscheme leuven ]])
            end
        }