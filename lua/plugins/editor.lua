-- [plugins/editing.lua]

return {
    { -- Autoformat
        'stevearc/conform.nvim',
        event = { 'BufWritePre' },
        cmd = { 'ConformInfo' },
        keys = {
            {
                '<leader>f',
                function()
                require('conform').format { async = true, lsp_format = 'fallback' }
                end,
                mode = '',
                desc = '[F]ormat buffer',
            },
        },
        opts = {
            notify_on_error = false,
            format_on_save = function(bufnr)
                local disable_filetypes = { c = true, cpp = true }
                if disable_filetypes[vim.bo[bufnr].filetype] then
                    return
                    end
                    return { timeout_ms = 500, lsp_format = 'fallback' }
                    end,
                    formatters_by_ft = {
                        lua = { 'stylua' },
                    },
        },
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

    { -- Adds indentation guides to all lines
        'lukas-reineke/indent-blankline.nvim',
        main = 'ibl',
        opts = {},
    },

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
}
