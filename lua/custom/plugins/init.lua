-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
    {
        'alexghergh/nvim-tmux-navigation',
        config = function()

            local nvim_tmux_nav = require('nvim-tmux-navigation')

            nvim_tmux_nav.setup {
                disable_when_zoomed = true -- defaults to false
            }

            vim.keymap.set('n', "<C-h>", nvim_tmux_nav.NvimTmuxNavigateLeft, { desc = 'Navigate Left' })
            vim.keymap.set('n', "<C-j>", nvim_tmux_nav.NvimTmuxNavigateDown, { desc = 'Navigate Down' })
            vim.keymap.set('n', "<C-k>", nvim_tmux_nav.NvimTmuxNavigateUp, { desc = 'Navigate Up' })
            vim.keymap.set('n', "<C-l>", nvim_tmux_nav.NvimTmuxNavigateRight, { desc = 'Navigate Right' })
            vim.keymap.set('n', "<C-\\>", nvim_tmux_nav.NvimTmuxNavigateLastActive, { desc = 'Navigate Last Active' })
            vim.keymap.set('n', "<C-Space>", nvim_tmux_nav.NvimTmuxNavigateNext, { desc = 'Navigate Next' })

        end
    },
    {
        'nvim-tree/nvim-tree.lua',
        config = function()
            vim.g.loaded_netrw = 1
            vim.g.loaded_netrwPlugin = 1
            -- set termguicolors to enable highlight groups
            vim.opt.termguicolors = true

            -- empty setup using defaults
            require("nvim-tree").setup({
                view = {
                    side = 'left',
                    width = 40
                }
            })
            vim.keymap.set('n', '<C-n>', ':NvimTreeFindFileToggle<CR>', { desc = 'Toggle File Tree' })
        end
    }
}
