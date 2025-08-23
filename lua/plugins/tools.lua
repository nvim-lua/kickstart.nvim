-- [plugins/tools.lua]

return {

    { -- Fuzzy Finder (files, lsp, etc)
        'nvim-telescope/telescope.nvim',
        event = 'VimEnter',
        branch = '0.1.x',
        dependencies = {
            'nvim-lua/plenary.nvim', -- Required
            { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make', cond = function() return vim.fn.executable 'make' == 1 end }, -- Suggested: native sorter
            { 'nvim-telescope/telescope-ui-select.nvim' }, -- Optional: better UI
            { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font }, -- Optional: icons
        },
        config = function()
        require('telescope').setup {
            defaults = {
                mappings = {
                    i = {
                        ['<C-j>'] = "move_selection_next",
                        ['<C-k>'] = "move_selection_previous",
                    },
                },
            },
            extensions = {
                ['ui-select'] = {
                    require('telescope.themes').get_dropdown(),
                },
            },
        }
        -- Load extensions if installed
        pcall(require('telescope').load_extension, 'fzf')
        pcall(require('telescope').load_extension, 'ui-select')

        local builtin = require 'telescope.builtin'
        vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
        vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
        vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
        vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
        vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
        vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
        vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
        vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
        vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
        vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })
        end,
    },

    { -- Telescope frecency (smart recent files)
        'nvim-telescope/telescope-frecency.nvim',
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = function()
        require("telescope").load_extension("frecency")
        vim.keymap.set("n", "<leader>fr", "<cmd>Telescope frecency<CR>", { desc = "[F]ile [R]ecency" })
        end,
    },

    { -- Treesitter for better syntax highlighting
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
        main = 'nvim-treesitter.configs',
        opts = {
            ensure_installed = {
                'bash', 'c', 'diff', 'html', 'lua', 'luadoc',
                'markdown', 'markdown_inline', 'query', 'vim', 'vimdoc'
            },
            auto_install = true,
            highlight = { enable = true, additional_vim_regex_highlighting = { 'ruby' } },
            indent = { enable = true, disable = { 'ruby' } },
        },
    },

    -- neo-tree.lua
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'v3.x',
    dependencies = {
        'nvim-lua/plenary.nvim',
        'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
        'MunifTanjim/nui.nvim',
    },
    cmd = 'Neotree',
    keys = {
        {
            '<leader>e',
            function()
            require('neo-tree.command').execute { toggle = true, dir = vim.loop.cwd() }
            end,
            desc = 'Explorer NeoTree (Current Dir)',
        },
        {
            '<leader>E',
            function()
            require('neo-tree.command').execute { toggle = true, dir = vim.fn.stdpath 'config' }
            end,
            desc = 'Explorer NeoTree (Config Dir)',
        },
    },
    opts = {
        close_if_last_window = true, -- Close Neo-tree if it is the last window left
        popup_border_style = 'rounded',
        filesystem = {
            filtered_items = {
                visible = true,
                hide_dotfiles = false,
                hide_gitignored = true,
            },
            follow_current_file = {
                enabled = true, -- This will find and focus the file in the tree when you open a buffer.
            },
            hijack_netrw_behavior = 'open_current', -- Or 'disabled' if you prefer to keep netrw for directories.
        },
        window = {
            mappings = {
                ['<space>'] = 'none', -- Disable space for opening folders, allowing for custom mappings
                ['l'] = 'open',
                ['h'] = 'close_node',
                ['S'] = 'open_split',
                ['s'] = 'open_vsplit',
            },
        },
    },


    { -- Oil.nvim: directory navigation as buffers
        'stevearc/oil.nvim',
        opts = {},
        config = function(_, opts)
        require("oil").setup(opts)
        vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory with oil" })
        end,
    },

    { -- Harpoon: quick file navigation
        'ThePrimeagen/harpoon',
        branch = 'harpoon2',
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = function()
        local harpoon = require("harpoon")
        harpoon:setup()

        vim.keymap.set("n", "<leader>ha", function() harpoon:list():add() end, { desc = "Harpoon add file" })
        vim.keymap.set("n", "<leader>hh", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = "Harpoon menu" })
        vim.keymap.set("n", "<leader>h1", function() harpoon:list():select(1) end, { desc = "Harpoon to file 1" })
        vim.keymap.set("n", "<leader>h2", function() harpoon:list():select(2) end, { desc = "Harpoon to file 2" })
        vim.keymap.set("n", "<leader>h3", function() harpoon:list():select(3) end, { desc = "Harpoon to file 3" })
        vim.keymap.set("n", "<leader>h4", function() harpoon:list():select(4) end, { desc = "Harpoon to file 4" })
        end,
    },

    {
        "folke/snacks.nvim",
        priority = 1000,
        lazy = false,
        opts = {
            -- Core utilities
            bigfile = { enabled = true }, -- handle large files gracefully
            quickfile = { enabled = true }, -- speed up startup with file args
            scope = { enabled = true }, -- treesitter/indent-based scope detection
            util = { enabled = true }, -- core utility functions

            -- UI / Experience
            dashboard = { enabled = true }, -- Will be configured in config function
            explorer = { enabled = true }, -- Snacks explorer (you still keep neo-tree)
            indent = { enabled = true }, -- replaces indent-blankline.nvim
            input = { enabled = true }, -- nicer vim.ui.input
            picker = { enabled = true }, -- universal picker (you still keep telescope)
            notifier = { enabled = true }, -- pretty notifications
            scroll = { enabled = true }, -- smooth scrolling
            statuscolumn = { enabled = true }, -- sign/number column
            words = { enabled = true }, -- highlight LSP references / word navigation

            -- Productivity
            terminal = { win = { style = "float" } }, -- floating terminal
            scratch = { enabled = true }, -- persistent scratch buffers
            zen = { enabled = true }, -- zen mode (distraction free)
            git = { enabled = true }, -- git helpers
            gitbrowse = { enabled = true }, -- open in GitHub/GitLab/Bitbucket
            lazygit = { enabled = true }, -- replaces kdheepak/lazygit.nvim
            rename = { enabled = true }, -- LSP-aware file rename
        },
        config = function(_, opts)
        -- Load dashboard config and merge it
        local dashboard_config = require("dashboard")
        -- FIX: Access the .config table from the required module
        opts.dashboard = dashboard_config.config

        local snacks = require("snacks")
        snacks.setup(opts)

        -- === Keymaps ===
        -- Dashboard
        vim.keymap.set("n", "<leader>db", function() snacks.dashboard.open() end, { desc = "Open [D]ash[B]oard" })

        -- Explorer (in addition to neo-tree)
        vim.keymap.set("n", "<leader>xx", function() snacks.explorer.open() end, { desc = "Open Snacks E[x]plorer" })

        -- Terminal
        vim.keymap.set("n", "<leader>tt", function() snacks.terminal.toggle() end, { desc = "Toggle [T]erminal" })

        -- Scratch Buffer
        vim.keymap.set("n", "<leader>sc", function() snacks.scratch.open() end, { desc = "Open [S]cratch buffer" })

        -- Zen Mode
        vim.keymap.set("n", "<leader>zn", function() snacks.zen.toggle() end, { desc = "Toggle [Z]en mode" })

        -- LazyGit
        vim.keymap.set("n", "<leader>gg", function() snacks.lazygit.open() end, { desc = "Open [G]it: LazyGit" })

        -- Git Browse (open repo/commit/branch in browser)
        vim.keymap.set("n", "<leader>gb", function() snacks.gitbrowse.open() end, { desc = "[G]it [B]rowse in browser" })

        -- Word navigation (LSP references / matches)
        vim.keymap.set("n", "<leader>ww", function() snacks.words.jump_next() end, { desc = "Jump to next [W]ord reference" })
        vim.keymap.set("n", "<leader>wW", function() snacks.words.jump_prev() end, { desc = "Jump to prev [W]ord reference" })
        end,
    },

    { -- Debugging (DAP)
        'mfussenegger/nvim-dap',
        dependencies = {
            'williamboman/mason.nvim',
            'rcarriga/nvim-dap-ui',
        },
        config = function()
        local dap = require 'dap'
        local dapui = require 'dapui'
        dapui.setup()
        dap.listeners.after.event_initialized['dapui_config'] = function() dapui.open() end
        dap.listeners.before.event_terminated['dapui_config'] = function() dapui.close() end
        dap.listeners.before.event_exited['dapui_config'] = function() dapui.close() end
        end,
        keys = {
            { '<leader>db', function() require('dap').toggle_breakpoint() end, desc = 'DAP: Toggle Breakpoint' },
            { '<leader>dc', function() require('dap').continue() end, desc = 'DAP: Continue' },
            { '<leader>di', function() require('dap').step_into() end, desc = 'DAP: Step Into' },
            { '<leader>do', function() require('dap').step_over() end, desc = 'DAP: Step Over' },
            { '<leader>dO', function() require('dap').step_out() end, desc = 'DAP: Step Out' },
            { '<leader>dr', function() require('dap').repl.open() end, desc = 'DAP: Open REPL' },
        },
    },
}
