-- nvim v0.12+
vim.pack.add({ { src = 'https://github.com/kdheepak/lazygit.nvim' } })

-- you will most likely also need plenary dependency if you are manually managing packages:
-- vim.pack.add({ { src = 'https://github.com/nvim-lua/plenary.nvim'} })

vim.keymap.set('n', '<leader>gg', '<cmd>LazyGit<CR>', { desc = 'Open LazyGit' } )
