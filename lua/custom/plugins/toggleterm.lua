return {
	'akinsho/toggleterm.nvim',
	version = "*",
	config = function()
		local term = require('toggleterm')

		term.setup {
			size = 20,
			open_mapping = [[<leader>tf]],
			shading_factor = 2,
			direction = 'float',
			float_opts = {
				border = 'curved',
				highlights = {
					border = "Normal",
					background = "Normal",
				}
			},
		}

		vim.keymap.set("n", "<leader>th", "<CMD>ToggleTerm size=10 direction=horizontal<CR>")
		vim.keymap.set("n", "<leader>tv", "<CMD>ToggleTerm size=80 direction=vertical<CR>")
	end
}
