local telescope_builtin = require('telescope.builtin')

vim.keymap.set('n', '<leader>sa',
    function()
        telescope_builtin.find_files({
            hidden = true,
            no_ignore = false,
        })
    end,
    { desc = '[S]earch [A]ll Files (+ hidden)' }
)

vim.keymap.set('n', '<leader>sA',
    function()
        telescope_builtin.find_files({
            hidden = true,
            no_ignore = true,
        })
    end,
    { desc = '[S]earch [A]ll Files (+ hidden & ignored)' }
)

vim.keymap.set('n', '<leader>sk', telescope_builtin.keymaps,
    { desc = '[S]earch [K]eymaps' }
)
