local opts = { noremap = true, silent = true }

-- Keymaps
-- Paste over selection
vim.keymap.set('v', '<leader>p', '"_dP', opts)
-- Y copy from cursor to end of line
vim.keymap.set('n', 'Y', 'y$', opts)
-- Keep cursor centered when scrolling search matches
vim.keymap.set('n', 'n', 'nzzzv', opts)
vim.keymap.set('n', 'N', 'Nzzzv', opts)
vim.keymap.set('n', 'J', 'mzJ`z', opts)
-- Undo breakpoints
vim.keymap.set('i', ',', ',<c-g>u', opts)
vim.keymap.set('i', '.', '.<c-g>u', opts)
vim.keymap.set('i', '!', '!<c-g>u', opts)
vim.keymap.set('i', '?', '?<c-g>u', opts)
-- Jumplist mutations
vim.keymap.set('n', '<expr> k', '(v:count > 5 ? "m\'" . v:count : "") . \'k\'', opts)
vim.keymap.set('n', '<expr> j', '(v:count > 5 ? "m\'" . v:count : "") . \'j\'', opts)
-- Moving text
vim.keymap.set('v', 'J', ':m \'>+1<CR>gv=gv',  opts)
vim.keymap.set('v', 'K', ':m \'>-2<CR>gv=gv',  opts)
vim.keymap.set('n', '<leader>j', ':m .+1<CR>==',  opts)
vim.keymap.set('n', '<leader>k', ':m .-2<CR>==',  opts)

vim.keymap.set('n', '<space>ft', '<cmd>:Format<CR>',  opts)
-- GIT
-- Fugitive git bindings
vim.keymap.set('n', '<leader>ga', ':Git add %:p<CR><CR>', opts)
vim.keymap.set('n', '<leader>gs', ':Git<CR>', opts)
vim.keymap.set('n', '<leader>gc', ':Git commit -v -q<CR>', opts)
vim.keymap.set('n', '<leader>gt', ':Git commit -v -q %:p<CR>', opts)
vim.keymap.set('n', '<leader>d', ':Gdiff<CR>', opts)
vim.keymap.set('n', '<leader>dm', ':Gdiffsplit!<CR>', opts)
vim.keymap.set('n', '<leader>ge', ':Gedit<CR>', opts)
vim.keymap.set('n', '<leader>gr', ':Gread<CR>', opts)
vim.keymap.set('n', '<leader>gw', ':Gwrite<CR><CR>', opts)
vim.keymap.set('n', '<leader>gl', ':silent! Glog<CR>:bot copen<CR>', opts)
vim.keymap.set('n', '<leader>gp', ':Ggrep<space>', opts)
vim.keymap.set('n', '<leader>gm', ':Gmove<space>', opts)
vim.keymap.set('n', '<leader>gb', ':Git branch<Space>', opts)
vim.keymap.set('n', '<leader>go', ':Git checkout<Space>', opts)
vim.keymap.set('n', '<leader>gps', ':Git push<CR>', opts)
vim.keymap.set('n', '<leader>gpl', ':Dispatch! git pull<CR>', opts)
-- Interactive merge conflict SPAVE-mv to trigger from git status menu
vim.keymap.set('n', '<leader>gj', ':diffget //3<Space>', opts)
vim.keymap.set('n', '<leader>gf', ':diffget //2<Space>', opts)
-- TELESCOPE
vim.keymap.set('n', '<leader>rg', require('telescope.builtin').live_grep, opts)
vim.keymap.set('n', '<leader>pw', require('telescope.builtin').grep_string, opts)
vim.keymap.set('n', '<leader>pf', require('telescope.builtin').find_files, opts)
vim.keymap.set('n', '<leader>pg', require('telescope.builtin').git_files, opts)
vim.keymap.set('n', '<leader>pb', require('telescope.builtin').buffers, opts)
vim.keymap.set('n', '<leader>m', require('telescope.builtin').man_pages, opts)
vim.keymap.set('n', '<leader>pc', require('telescope.builtin').current_buffer_fuzzy_find, opts)
vim.keymap.set('n', '<leader>tg', require('telescope.builtin').live_grep, opts)
vim.keymap.set('n', '<leader>gl', require('telescope.builtin').git_bcommits, opts)
vim.keymap.set('n', '<leader>gk', require('telescope.builtin').git_commits, opts)
-- kenesis
vim.keymap.set('n', '<leader>th', require('telescope.builtin').grep_string, opts)
vim.keymap.set('n', '<leader>tj', require('telescope.builtin').find_files, opts)
vim.keymap.set('n', '<leader>tk', require('telescope.builtin').git_files, opts)
vim.keymap.set('n', '<leader>tm', require('telescope.builtin').buffers, opts)
vim.keymap.set('n', '<leader>t;', require('telescope.builtin').help_tags, opts)
vim.keymap.set('n', '<leader>tl', require('telescope.builtin').current_buffer_fuzzy_find, opts)
-- for debugger
-- vim.keymap.set('n', '<Leader>tp', '<Cmd>:Telescope dap list_breakpoints<CR>', opts)
-- vim.keymap.set('n', '<Leader>tc', '<Cmd>:Telescope dap commands<CR>', opts)

-- Harpoon
vim.keymap.set('n', '<space>ha', '<cmd>lua require("harpoon.mark").add_file()<CR>', opts)
vim.keymap.set('n', '<space>hj', '<cmd>lua require("harpoon.ui").toggle_quick_menu()<CR>', opts)
vim.keymap.set('n', '<space>hn', '<cmd>lua require("harpoon.ui").nav_next()<CR>', opts)
vim.keymap.set('n', '<space>hp', '<cmd>lua require("harpoon.ui").nav_prev()<CR>', opts)
vim.keymap.set('n', '<space>h1', '<cmd>lua require("harpoon.ui").nav_file(1)<CR>', opts)
vim.keymap.set('n', '<space>h2', '<cmd>lua require("harpoon.ui").nav_file(2)<CR>', opts)
vim.keymap.set('n', '<space>h3', '<cmd>lua require("harpoon.ui").nav_file(3)<CR>', opts)
vim.keymap.set('n', '<space>h4', '<cmd>lua require("harpoon.ui").nav_file(4)<CR>', opts)

vim.keymap.set('n', '<space>sn', '<cmd>:PackerSync<CR>', opts)

-- DEBUG
vim.keymap.set('n', '<F5>', '<Cmd>lua require("dap").continue()<CR>', opts)
vim.keymap.set('n', '<F10>', '<Cmd>lua require("dap").step_over()<CR>', opts)
vim.keymap.set('n', '<F11>', '<Cmd>lua require("dap").step_into()<CR>', opts)
vim.keymap.set('n', '<F12>', '<Cmd>lua require("dap").step_out()<CR>', opts)
vim.keymap.set('n', '<Leader>b', '<Cmd>lua require("dap").toggle_breakpoint()<CR>', opts)
vim.keymap.set('n', '<Leader>B', '<Cmd>lua require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))<CR>', opts)
vim.keymap.set('n', '<Leader>lp', '<Cmd>lua require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: "))<CR>', opts)
vim.keymap.set('n', '<Leader>dr', '<Cmd>lua require("dap").repl.open()<CR>', opts)
vim.keymap.set('n', '<Leader>dl', '<Cmd>lua require("dap").run_last()<CR>', opts)
vim.keymap.set('n', '<Leader>dc', '<Cmd>lua require("dapui").close()<CR>', opts)

--unbinds
-- vim.keymap.set('n', 'b', '<Nop>', opts)
