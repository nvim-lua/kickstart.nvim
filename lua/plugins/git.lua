--[plugins/git.lua]

return {
    { -- Adds git related signs to the gutter, as well as utilities for managing changes
        'lewis6991/gitsigns.nvim',
        opts = {
            -- Basic options for the signs in the gutter
            signs = {
                add = { text = '+' },
                change = { text = '~' },
                delete = { text = '_' },
                topdelete = { text = '‾' },
                changedelete = { text = '~' },
            },
            -- All keymaps are now defined in the on_attach function
            on_attach = function(bufnr)
            local gs = package.loaded.gitsigns
            local function map(mode, l, r, desc)
            vim.keymap.set(mode, l, r, { buffer = bufnr, desc = desc })
            end

            -- Navigation
            map('n', ']c', gs.next_hunk, 'Next Hunk')
            map('n', '[c', gs.prev_hunk, 'Prev Hunk')

            -- Actions
            map({ 'n', 'v' }, '<leader>hs', gs.stage_hunk, 'Stage Hunk')
            map({ 'n', 'v' }, '<leader>hr', gs.reset_hunk, 'Reset Hunk')
            map('n', '<leader>hS', gs.stage_buffer, 'Stage Buffer')
            map('n', '<leader>hu', gs.undo_stage_hunk, 'Undo Stage Hunk')
            map('n', '<leader>hR', gs.reset_buffer, 'Reset Buffer')
            map('n', '<leader>hp', gs.preview_hunk, 'Preview Hunk')
            map('n', '<leader>hb', function() gs.blame_line { full = true } end, 'Blame Line')
            map('n', '<leader>tb', gs.toggle_current_line_blame, 'Toggle Blame Line')
            map('n', '<leader>hd', gs.diffthis, 'Diff This')
            map('n', '<leader>hD', function() gs.diffthis '~' end, 'Diff This ~')
            map('n', '<leader>td', gs.toggle_deleted, 'Toggle Deleted')

            -- Text object
            map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>', 'Select Hunk')
            end,
        },
    },
}
