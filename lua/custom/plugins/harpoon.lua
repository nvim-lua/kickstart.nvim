return {
	'thePrimeagen/harpoon',
	dependencies = { 'nvim-lua/plenary.nvim' },
	config = function ()
		local mark = require('harpoon.mark')
		vim.keymap.set("n", "<leader>ha", mark.add_file, { desc = "[H]arpoon [A]dd file" })

		local ui = require('harpoon.ui')
		vim.keymap.set("n", "<c-e>", ui.toggle_quick_menu, { desc = "harpoon toggle quick menu" })
		vim.keymap.set("n", "<c-h>", function() ui.nav_file(1) end, { desc = "harpoon add nav file 1" })
		vim.keymap.set("n", "<c-t>", function() ui.nav_file(2) end, { desc = "harpoon add nav file 2" })
		vim.keymap.set("n", "<c-n>", function() ui.nav_file(3) end, { desc = "harpoon add nav file 3" })
		vim.keymap.set("n", "<c-s>", function() ui.nav_file(4) end, { desc = "harpoon add nav file 4" })
	end
}
