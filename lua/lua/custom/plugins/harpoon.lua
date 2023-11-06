return {
	'ThePrimeagen/harpoon',
	config = function()
		local mark = require("harpoon.mark")
		local ui = require("harpoon.ui")

		vim.keymap.set('n', "<leader>aa", mark.add_file, { desc = 'add file to list' })
		vim.keymap.set('n', "<leader>al", ui.toggle_quick_menu, { desc = 'quick list' })
		vim.keymap.set('n', "<leader>ap", ui.nav_prev)
		vim.keymap.set('n', "<leader>an", ui.nav_next)

		vim.keymap.set('n', "<C-n>", function()
			ui.nav_file(1)
		end)
		vim.keymap.set('n', "<C-m>", function()
			ui.nav_file(2)
		end)

		vim.keymap.set('n', "<C-,>", function()
			ui.nav_file(3)
		end)

		vim.keymap.set('n', "<C-.>", function()
			ui.nav_file(4)
		end)
	end,
}
