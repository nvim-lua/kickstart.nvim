return {
            "goolord/alpha-nvim",
            dependencies = { "kyazdani42/nvim-web-devicons" },
            config = function()
                require'alpha.themes.dashboard'.section.footer.val = require'alpha.fortune'()
                require'alpha'.setup(require'alpha.themes.dashboard'.opts)
            end,
        }