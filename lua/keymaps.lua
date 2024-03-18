vim.keymap.set("n", "<leader>pq", vim.cmd.Ex)

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- move a selection up and down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- not sure
-- vim.keymap.set("n", "J", "mzJ`z")
-- vim.keymap.set("n", "<C-d>", "<C-d>zz")
-- vim.keymap.set("n", "<C-u>", "<C-u>zz")
-- vim.keymap.set("n", "n", "nzzzv")
-- vim.keymap.set("n", "N", "Nzzzv")

-- greatest remap ever, also not sure
-- vim.keymap.set("x", "<leader>p", "\"_dP")

-- This is going to get me cancelled
vim.keymap.set("i", "<C-c>", "<Esc>")

-- thank theprimeagen later
vim.keymap.set('n', '<leader>re', "oif err != nil {<CR>}<ESC>Oreturn err")

-- wiki
vim.keymap.set('n', '<leader>ww', vim.cmd.WikiIndex, { noremap = true, silent = true, desc = "Open Wiki" })
vim.keymap.set('n', '<leader>mj', vim.cmd.WikiJournal, { noremap = true, silent = true, desc = "[M]ake [J]ournal" })
vim.keymap.set('n', '<leader>ji', vim.cmd.WikiJournalIndex,
  { noremap = true, silent = true, desc = "Make [J]ournal [I]ndex" })

-- diffview
vim.keymap.set("n", '<leader>vf', '<cmd>DiffviewFileHistory %<CR>')
vim.keymap.set("n", '<leader>vb', '<cmd>DiffviewFileHistory<CR>')
vim.keymap.set("n", '<leader>vc', '<cmd>DiffviewClose<CR>')

-- zenmode
vim.keymap.set("n", '<leader>zm', '<cmd>ZenMode<CR>')

-- undo tree
vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)

-- copilot
vim.keymap.set('i', "<M-CR>", "copilot#Accept('<CR>')", {
  expr = true,
  replace_keycodes = false
})

vim.keymap.set('i', "<M-]>", "<Plug>(copilot-next)")

vim.keymap.set('i', "<M-[>", "<Plug>(copilot-previous)")

vim.keymap.set('i', "<M-a>", "<Plug>(copilot-accept-word)")

vim.keymap.set('i', "<M-/>", "<Plug>(copilot-suggest)")

-- oil
vim.keymap.set("n", "<leader>o", "<CMD>Oil<CR>", { desc = "Open parent directory" })

-- lazygit
vim.keymap.set("n", "<leader>gg", "<CMD>LazyGit<CR>", { desc = "Open lazygit" })
