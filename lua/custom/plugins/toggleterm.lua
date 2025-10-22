local function clamp(value, min_value, max_value)
    assert(min_value <= max_value, 'min_value must be <= max_value')
    return math.max(min_value, math.min(value, max_value))
end

return {
    {
        'akinsho/toggleterm.nvim',
        version = '*',
        event = 'VeryLazy',
        cmd = {
            'ToggleTerm',
            'ToggleTermToggleAll',
            'TermExec',
            'TermSelect',
            'ToggleTermSendCurrentLine',
            'ToggleTermSendVisualSelection',
        },
        opts = function()
            return {
                size = function(term)
                    if term.direction == 'horizontal' then
                        return clamp(math.floor(vim.o.lines * 0.28), 10, math.floor(vim.o.lines * 0.45))
                    elseif term.direction == 'vertical' then
                        return clamp(math.floor(vim.o.columns * 0.35), 40, math.floor(vim.o.columns * 0.6))
                    end
                    return 20
                end,
                open_mapping = { [[<C-\>]] },
                shade_terminals = true,
                shading_factor = -12,
                start_in_insert = true,
                insert_mappings = true,
                terminal_mappings = true,
                persist_size = true,
                persist_mode = true,
                direction = 'float',
                close_on_exit = true,
                auto_scroll = true,
                float_opts = {
                    border = 'curved',
                    winblend = 0,
                    width = function()
                        return clamp(math.floor(vim.o.columns * 0.9), 80, vim.o.columns - 2)
                    end,
                    height = function()
                        return clamp(math.floor(vim.o.lines * 0.85), 20, vim.o.lines - 2)
                    end,
                    title_pos = 'center',
                },
            }
        end,
        config = function(_, opts)
            local toggleterm = require('toggleterm')
            toggleterm.setup(opts)

            local TERM_FLOAT = 1
            local TERM_HORIZONTAL = 2
            local TERM_VERTICAL = 3

            local function toggle_float()
                toggleterm.toggle(TERM_FLOAT, nil, nil, 'float')
            end

            local function toggle_horizontal()
                toggleterm.toggle(TERM_HORIZONTAL, nil, nil, 'horizontal')
            end

            local function toggle_vertical()
                toggleterm.toggle(TERM_VERTICAL, nil, nil, 'vertical')
            end

            local map = vim.keymap.set

            map({ 'n', 'i', 't' }, '<C-`>', toggle_float, { desc = 'Toggle floating terminal' })
            map('n', '<leader>tf', toggle_float, { desc = '[T]erminal float' })
            map('n', '<leader>th', toggle_horizontal, { desc = '[T]erminal horizontal' })
            map('n', '<leader>tv', toggle_vertical, { desc = '[T]erminal vertical' })
            map('n', '<leader>tt', '<cmd>TermSelect<CR>', { desc = '[T]erminal picker' })
            map('n', '<leader>ts', function()
                vim.cmd.ToggleTermSendCurrentLine(TERM_FLOAT)
            end, { desc = '[T]erminal [s]end line' })

            map('v', '<leader>ts', function()
                vim.cmd.ToggleTermSendVisualSelection(TERM_FLOAT)
            end, { desc = '[T]erminal [s]end selection' })

            local term_augroup = vim.api.nvim_create_augroup('custom-toggleterm', { clear = true })
            vim.api.nvim_create_autocmd('TermOpen', {
                group = term_augroup,
                pattern = 'term://*toggleterm#*',
                callback = function()
                    local term_opts = { buffer = 0, silent = true }
                    vim.keymap.set('t', '<Esc>', [[<C-\><C-n>]], term_opts)
                    vim.keymap.set('t', 'jk', [[<C-\><C-n>]], term_opts)
                    vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], term_opts)
                    vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], term_opts)
                    vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], term_opts)
                    vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], term_opts)
                end,
            })
        end,
    },
}
