return {
	'thePrimeagen/harpoon',
	dependencies = { 'nvim-lua/plenary.nvim' },
	config = function ()
		local mark = require('harpoon.mark')
		vim.keymap.set("n", "<leader>ha", mark.add_file)

		local ui = require('harpoon.ui')
		vim.keymap.set("n", "<c-e>", ui.toggle_quick_menu)
		vim.keymap.set("n", "<c-h>", function() ui.nav_file(1) end)
		vim.keymap.set("n", "<c-t>", function() ui.nav_file(2) end)
		vim.keymap.set("n", "<c-n>", function() ui.nav_file(3) end)
		vim.keymap.set("n", "<c-s>", function() ui.nav_file(4) end)
	end
}
