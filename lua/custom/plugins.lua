return {
    'tpope/vim-unimpaired',
    'tpope/vim-eunuch',
    -- { 'rafamadriz/friendly-snippets',
    --     init = function ()
    --         require("luasnip.loaders.from_vscode").lazy_load()
    --     end
    -- },
    'fatih/vim-go',
    { 'mickael-menu/zk-nvim',
        init = function ()
            require("zk").setup()
        end
    }
}
