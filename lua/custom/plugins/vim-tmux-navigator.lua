return {
    -- Seamless navigation between tmux panes and vim splits
    'christoomey/vim-tmux-navigator',
    config = function()
        -- disable netrw for nvim-tree
        vim.g.loaded_netrw = 1
        vim.g.loaded_netrwPlugin = 1
    end,
}
