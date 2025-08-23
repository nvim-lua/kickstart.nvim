-- [plugins/editor.lua]

return {

    -- -- Autoformat: `conform.nvim`
    -- This plugin provides a non-LSP based way to format your code.
    {
        'stevearc/conform.nvim',
        -- Only load this plugin right before a buffer is written.
        event = { 'BufWritePre' },
        -- Add the `ConformInfo` command for debugging.
        cmd = { 'ConformInfo' },
        -- Set up keybinds for manual formatting.
        keys = {
            {
                -- The leader key followed by 'f' to format the current buffer.
                '<leader>f',
                function()
                require('conform').format { async = true, lsp_format = 'fallback' }
                end,
                mode = '',
                desc = '[F]ormat buffer',
            },
        },
        opts = {
            -- Disable notifications on formatting errors to avoid pop-ups.
            notify_on_error = false,
            -- This function runs before saving a file to check if it should be formatted.
            format_on_save = function(bufnr)
                -- A list of filetypes where auto-formatting on save is disabled.
                local disable_filetypes = { c = true, cpp = true }

                -- Determine if LSP formatting should be used.
                local lsp_format_opt
                if disable_filetypes[vim.bo[bufnr].filetype] then
                    -- If the filetype is in the disabled list, don't use LSP formatting.
                    lsp_format_opt = 'never'
                    else
                        -- Otherwise, use LSP formatting as a fallback.
                        lsp_format_opt = 'fallback'
                        end

                        return {
                            timeout_ms = 500,
                            lsp_format = lsp_format_opt,
                        }
                        end,
                        -- Map filetypes to specific formatters.
                        formatters_by_ft = {
                            lua = { 'stylua' },
                        },
        },
    },

    -- Autocompletion: `nvim-cmp` and its dependencies
    -- This is the core of the autocompletion system.
    {
        'hrsh7th/nvim-cmp',
        -- Only load this plugin when entering insert mode.
        event = 'InsertEnter',
        dependencies = {
            -- `LuaSnip` is the snippet engine.
            {
                'L3MON4D3/LuaSnip',
                -- This build command ensures the `jsregexp` dependency is installed if needed.
                build = (function()
                if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
                    return
                    end
                    return 'make install_jsregexp'
                end)(),
                -- ++ ADDED DEPENDENCY ++
                dependencies = {
                    -- This plugin provides a collection of useful snippets.
                    'rafamadriz/friendly-snippets',
                },
            },
            -- `cmp_luasnip` connects the snippet engine to the autocompletion.
            'saadparwaiz1/cmp_luasnip',
            -- `cmp-nvim-lsp` provides completion items from the language server.
            'hrsh7th/cmp-nvim-lsp',
            -- `cmp-path` provides completion for file paths.
            'hrsh7th/cmp-path',
            -- `lazydev` is used for runtime completion of `lazy.nvim` plugin names.
            'folke/lazydev.nvim',
        },
        config = function()
        -- Get local references to the required modules.
        local cmp = require 'cmp'
        local luasnip = require 'luasnip'
        luasnip.config.setup {}

        -- ++ ADDED SNIPPET LOADING ++
        -- This line tells luasnip to load snippets from plugins like friendly-snippets.
        require("luasnip.loaders.from_vscode").lazy_load()

        -- Set up the `nvim-cmp` plugin.
        cmp.setup {
            -- Define how snippets are expanded.
            snippet = {
                expand = function(args)
                luasnip.lsp_expand(args.body)
                end,
            },
            -- Configure the completion menu.
            completion = { completeopt = 'menu,menuone,noinsert' },
            -- Set up key mappings for various completion actions.
            mapping = cmp.mapping.preset.insert {
                -- Navigate the completion menu.
                ['<C-n>'] = cmp.mapping.select_next_item(),
                ['<C-p>'] = cmp.mapping.select_prev_item(),
                -- Scroll documentation.
                ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                ['<C-f>'] = cmp.mapping.scroll_docs(4),
                -- Confirm the selected completion item.
                ['<C-y>'] = cmp.mapping.confirm { select = true },
                -- Manually trigger completion.
                ['<C-Space>'] = cmp.mapping.complete {},
                -- Jump to the next part of a snippet.
                ['<C-l>'] = cmp.mapping(function()
                if luasnip.expand_or_locally_jumpable() then
                    luasnip.expand_or_jump()
                    end
                    end, { 'i', 's' }),
                    -- Jump to the previous part of a snippet.
                    ['<C-h>'] = cmp.mapping(function()
                    if luasnip.locally_jumpable(-1) then
                        luasnip.jump(-1)
                        end
                        end, { 'i', 's' }),
            },
            -- Define the sources for completion items and their priority.
            sources = {
                {
                    name = 'lazydev',
                    group_index = 0,
                },
                { name = 'nvim_lsp' },
                { name = 'luasnip' },
                { name = 'path' },
            },
        }
        end,
    },

    { -- Linting
        'mfussenegger/nvim-lint',
        event = { 'BufReadPre', 'BufNewFile' },
        config = function()
        local lint = require 'lint'
        lint.linters_by_ft = {}
        vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
            group = vim.api.nvim_create_augroup('lint', { clear = true }),
                                    callback = function()
                                    lint.try_lint()
                                    end,
        })
        end,
    },

    { -- Auto pairs for brackets, quotes, etc.
        'windwp/nvim-autopairs',
        event = 'InsertEnter',
        dependencies = { 'hrsh7th/nvim-cmp' },
        config = function()
        require('nvim-autopairs').setup {}
        local cmp_autopairs = require 'nvim-autopairs.completion.cmp'
        local cmp = require 'cmp'
        cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
        end,
    },

--     { -- Adds indentation guides to all lines
--         'lukas-reineke/indent-blankline.nvim',
--         main = 'ibl',
--         opts = {},
--     },

    -- Detect tabstop and shiftwidth automatically
    'tpope/vim-sleuth',

    { -- Collection of small, useful plugins
        'echasnovski/mini.nvim',
        config = function()
        require('mini.ai').setup { n_lines = 500 }
        require('mini.surround').setup()
        end,
    },

    { -- Keybinding helper
        'folke/which-key.nvim',
        event = 'VimEnter',
        opts = {
            icons = {
                mappings = vim.g.have_nerd_font,
                keys = vim.g.have_nerd_font and {} or {
                    Up = '<Up> ', Down = '<Down> ', Left = '<Left> ', Right = '<Right> ',
                    C = '<C-…> ', M = '<M-…> ', D = '<D-…> ', S = '<S-…> ',
                    CR = '<CR> ', Esc = '<Esc> ', ScrollWheelDown = '<ScrollWheelDown> ',
                    ScrollWheelUp = '<ScrollWheelUp> ', NL = '<NL> ', BS = '<BS> ',
                    Space = '<Space> ', Tab = '<Tab> ',
                    F1 = '<F1>', F2 = '<F2>', F3 = '<F3>', F4 = '<F4>', F5 = '<F5>',
                    F6 = '<F6>', F7 = '<F7>', F8 = '<F8>', F9 = '<F9>', F10 = '<F10>',
                    F11 = '<F11>', F12 = '<F12>',
                },
            },
            spec = {
                { '<leader>c', group = '[C]ode', mode = { 'n', 'x' } },
                { '<leader>d', group = '[D]ocument' },
                { '<leader>r', group = '[R]ename' },
                { '<leader>s', group = '[S]earch' },
                { '<leader>w', group = '[W]orkspace' },
                { '<leader>t', group = '[T]oggle' },
                { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } },
            },
        },
    },

    { -- Trouble.nvim: pretty diagnostics & quickfix
        'folke/trouble.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        opts = {},
        cmd = "Trouble",
        keys = {
            { "<leader>xx", "<cmd>Trouble diagnostics toggle<CR>", desc = "Diagnostics (Trouble)" },
            { "<leader>xq", "<cmd>Trouble qflist toggle<CR>", desc = "Quickfix (Trouble)" },
        },
    },

    { -- Testing framework
        'vim-test/vim-test',
        config = function()
        vim.keymap.set("n", "<leader>tn", ":TestNearest<CR>", { desc = "Run nearest test" })
        vim.keymap.set("n", "<leader>tf", ":TestFile<CR>", { desc = "Run file tests" })
        vim.keymap.set("n", "<leader>tl", ":TestLast<CR>", { desc = "Run last test" })
        vim.keymap.set("n", "<leader>ts", ":TestSuite<CR>", { desc = "Run test suite" })
        end,
    },

    { -- Todo-comments: highlight and search TODO/FIX
        'folke/todo-comments.nvim',
        dependencies = { 'nvim-lua/plenary.nvim' },
        opts = {},
        event = "VimEnter",
        config = function()
        require("todo-comments").setup()
        vim.keymap.set("n", "<leader>st", "<cmd>TodoTelescope<CR>", { desc = "Search TODOs" })
        end,
    },

    { -- Commenting
        'tpope/vim-commentary',
        -- usage: `gcc` (line), `gc` (visual selection)
    },

}
