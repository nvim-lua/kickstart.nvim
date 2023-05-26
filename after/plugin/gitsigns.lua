require('gitsigns').setup {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
    on_attach = function(bufnr)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        map('n', ']c', function()
            if vim.wo.diff then return ']c' end
            vim.schedule(function() gs.next_hunk() end)
            return '<Ignore>'
        end, { expr = true, desc = "gitsigns: next hunk" })

        map('n', '[c', function()
            if vim.wo.diff then return '[c' end
            vim.schedule(function() gs.prev_hunk() end)
            return '<Ignore>'
        end, { expr = true, desc = "gitsigns: prev hunk" })

        -- Actions
        map('n', '<leader>hs', gs.stage_hunk,
            { desc = "gitsigns: stage hunk" })
        map('n', '<leader>hr', gs.reset_hunk,
            { desc = "gitsigns: reset hunk" })
        map('v', '<leader>hs', function()
                gs.stage_hunk { vim.fn.line("."), vim.fn.line("v") }
            end,
            { desc = "gitsigns: stage hunk (selection)" })
        map('v', '<leader>hr', function()
                gs.reset_hunk { vim.fn.line("."), vim.fn.line("v") }
            end,
            { desc = "gitsigns: reset hunk (selection)" })
        map('n', '<leader>hS', gs.stage_buffer,
            { desc = "gitsigns: stage buffer" })
        map('n', '<leader>hu', gs.undo_stage_hunk,
            { desc = "gitsigns: undo stage hunk" })
        map('n', '<leader>hR', gs.reset_buffer,
            { desc = "gitsigns: reset buffer" })
        map('n', '<leader>hp', gs.preview_hunk,
            { desc = "gitsigns: preview hunk" })
        map('n', '<leader>hb', function()
                gs.blame_line { full = true }
            end,
            { desc = "gitsigns: blame line" })
        map('n', '<leader>tb', gs.toggle_current_line_blame,
            { desc = "gitsigns: toggle current line blame" })
        map('n', '<leader>hd', gs.diffthis,
            { desc = "gitsigns: diff" })
        map('n', '<leader>hD', function()
                gs.diffthis('~')
            end,
            { desc = "gitsigns: diff (parent)" })
        map('n', '<leader>td', gs.toggle_deleted,
            { desc = "gitsigns: toggle deleted" })

        -- Text object
        map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
    end,
}

