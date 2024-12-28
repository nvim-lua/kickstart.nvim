-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
    {
        'OXY2DEV/markview.nvim',
        lazy = false, -- Recommended
        -- ft = "markdown" -- If you decide to lazy-load anyway
  
        dependencies = {
            'nvim-treesitter/nvim-treesitter',
            'nvim-tree/nvim-web-devicons',
        },

        opts = {
            initial_state = false,
        },
        config = function(_, opts)
            require('markview').setup(opts)
  
            local splitToggle_state = false
            vim.keymap.set('n', '<C-ö>', function()
                if not splitToggle_state then
                    -- The split toggle will not work unless markview is disabled in the initial window beforehand
                    vim.cmd 'Markview disableAll'
                    vim.cmd 'Markview splitEnable'
                    splitToggle_state = true
                else
                    vim.cmd 'Markview splitDisable'
                    splitToggle_state = false
                end
            end, { silent = true, desc = 'Toggle Markview split view' })
        end,
    },
}
