require('neo-tree').setup({
    event_handlers = {
        {
            -- On opening a file this event listener closes the Neotree window
            event = "file_opened",
            handler = function()
                vim.cmd("Neotree toggle")
            end,
            id = "file_opened_event_handler"
        }
    }
})
vim.keymap.set('n', '<C-n>', ':Neotree filesystem reveal left toggle<CR>', { desc = 'Toggles explorer tab'})
vim.keymap.set('n', '<leader>gs', ':Neotree float git_status<cr>', { desc = 'Shows git status' })
--vim.keymap.set('n', '<leader>b', ':Neotree toggle show buffers right<cr>')
