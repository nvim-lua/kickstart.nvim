-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
        "github/copilot.vim",

        -- lazy.nvim
        {
                "m4xshen/hardtime.nvim",
                dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
                opts = {}
        },
        -- Lua
        {
                "folke/twilight.nvim",
                opts = {
                        -- your configuration comes here
                        -- or leave it empty to use the default settings
                        -- refer to the configuration section below
                }
        },
        "mbbill/undotree",

        { 'numToStr/Comment.nvim', opts = {} },

        {
                "NoahTheDuke/vim-just",
                ft = { "just" },
        },

        'vimwiki/vimwiki',
        'lervag/wiki.vim',
        -- Lua
        {
                "folke/zen-mode.nvim",
                opts = {
                        window = {
                                -- width = 1.0, -- recording full screen
                                width = 55, -- recording shorts screen
                                options = {
                                        signcolumn = "no", -- disable signcolumn
                                        -- number = false, -- disable number column
                                        -- relativenumber = false, -- disable relative numbers
                                        -- cursorline = false, -- disable cursorline
                                        -- cursorcolumn = false, -- disable cursor column
                                        -- foldcolumn = "0", -- disable fold column
                                        -- list = false, -- disable whitespace characters
                                },
                        },
                        plugins = {
                                twilight = { enabled = false },
                                kitty = {
                                        enabled = true,
                                }
                        },
                }
        },
        {
                "ray-x/go.nvim",
                dependencies = {},
                config = function()
                        require("go").setup()
                end,
                event = { "CmdlineEnter" },
                ft = { "go", 'gomod' },
                build = ':lua require("go.install").update_all_sync()' -- if you need to install/update all binaries
        },

        {
                "sainnhe/gruvbox-material",
                lazy = false, -- make sure we load this during startup if it is your main colorscheme
                priority = 1000, -- make sure to load this before all the other start plugins
                config = function()
                        -- load the colorscheme here
                        vim.cmd([[colorscheme gruvbox-material]])
                end,
        },

        -- comes statusline with tmux
        -- 'vimpostor/vim-tpipeline',

        {
                'stevearc/oil.nvim',
                opts = {
                        -- Set to false if you still want to use netrw.
                        default_file_explorer = false,
                },
        },
        {
                "kdheepak/lazygit.nvim",
                cmd = {
                        "LazyGit",
                        "LazyGitConfig",
                        "LazyGitCurrentFile",
                        "LazyGitFilter",
                        "LazyGitFilterCurrentFile",
                },
                -- optional for floating window border decoration
                dependencies = {
                        "nvim-lua/plenary.nvim",
                },
        },
        {
                "mistricky/codesnap.nvim",
                build = "make",
                opts = {
                        mac_window_bar = false,    -- (Optional) MacOS style title bar switch
                        opacity = true,            -- (Optional) The code snap has some opacity by default, set it to false for 100% opacity
                        watermark = "@mbvisti",    -- (Optional) you can custom your own watermark, but if you don't like it, just set it to ""
                        preview_title = "mbv labs", -- (Optional) preview page title
                        editor_font_family = "CaskaydiaCove Nerd Font", -- (Optional) preview code font family
                        watermark_font_family = "Pacifico", -- (Optional) watermark font family
                },
        },
}
