vim.opt.relativenumber = true

vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")

vim.keymap.set('n', '<leader>cc', function() require('dap').continue() end)
vim.keymap.set('n', '<leader>so', function() require('dap').step_over() end)
vim.keymap.set('n', '<leader>si', function() require('dap').step_into() end)
vim.keymap.set('n', '<leader>sO', function() require('dap').step_out() end)
vim.keymap.set('n', '<Leader>b', function() require('dap').toggle_breakpoint() end)
vim.keymap.set('n', '<Leader>B', function() require('dap').set_breakpoint() end)
vim.keymap.set('n', '<Leader>dr', function() require('dap').repl.open() end)
vim.keymap.set('n', '<Leader>dl', function() require('dap').run_last() end)

