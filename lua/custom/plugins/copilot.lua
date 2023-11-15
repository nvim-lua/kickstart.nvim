return {
	"github/copilot.vim",
	config = function()
		vim.api.nvim_set_keymap("i", "<C-l>", 'copilot#Accept("<CR>")', { silent = true, expr = true })
		vim.keymap.set('i', '<C-j>', '<Plug>(copilot-next)', { noremap = false })
		vim.keymap.set('i', '<C-k>', '<Plug>(copilot-previous)', { noremap = false })
		vim.keymap.set('i', '<M-.>', '<Plug>(copilot-suggest)', { noremap = false })
	end
}
