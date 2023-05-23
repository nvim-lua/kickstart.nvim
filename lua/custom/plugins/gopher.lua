return {
	'olexsmir/gopher.nvim',
	ft = 'go',
	config = function(_, opts)
		require('gopher').setup(opts)

		vim.keymap.set("n",	"<leader>gsj", "<CMD>GoTagAdd json<CR>", { desc = '[G]o add [S]truct [J]SON' })
	end,
	build = function()
		vim.cmd [[silent! GoInstallDeps]]
	end,
}
