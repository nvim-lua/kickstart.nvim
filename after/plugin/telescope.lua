vim.keymap.set('n', '<leader>sa',
    function()
        require('telescope.builtin').find_files({
            hidden = true,
            no_ignore = false,
        })
    end,
    { desc = '[S]earch [A]ll Files (+ hidden)' }
)

vim.keymap.set('n', '<leader>sA',
    function()
        require('telescope.builtin').find_files({
            hidden = true,
            no_ignore = true,
        })
    end,
    { desc = '[S]earch [A]ll Files (+ hidden & ignored)' }
)
