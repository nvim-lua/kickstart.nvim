-- tag and quickly switch between buffers
return {
		'thePrimeagen/harpoon',
	config = function()
		local harpoon_mark = require('harpoon.mark')
		local harpoon_ui = require("harpoon.ui")

		vim.keymap.set('n', '<leader>ho', function()
			harpoon_ui.toggle_quick_menu()
		end, { desc = '[O]pen [H]arpoon' })

		vim.keymap.set('n', '<leader>ha', function()
			harpoon_mark.add_file()
		end, { desc = '[A]dd [H]arpoon file' })

		vim.keymap.set('n', '<leader>hr', function()
			harpoon_mark.rm_file()
		end, { desc = '[R]emove [H]arpoon file' })

		vim.keymap.set('n', '<leader>hc', function()
			harpoon_mark.clear_all()
		end, { desc = '[C]lear [H]arpoon files' })

		vim.keymap.set('n', '<leader>hl', function()
			harpoon_ui.nav_next()
		end, { desc = 'Next [H]arpoon file' })

		vim.keymap.set('n', '<leader>hh', function()
			harpoon_ui.nav_prev()
		end, { desc = 'Previous [H]arpoon file' })

		vim.keymap.set('n', '<leader>1', function()
			harpoon_ui.nav_file(1)
		end, { desc = 'Navigate to file [1]' })

		vim.keymap.set('n', '<leader>2', function()
			harpoon_ui.nav_file(2)
		end, { desc = 'Navigate to file [2]' })

		vim.keymap.set('n', '<leader>3', function()
			harpoon_ui.nav_file(3)
		end, { desc = 'Navigate to file [3]' })

		vim.keymap.set('n', '<leader>4', function()
			harpoon_ui.nav_file(4)
		end, { desc = 'Navigate to file [4]' })

		vim.keymap.set('n', '<leader>5', function()
			harpoon_ui.nav_file(5)
		end, { desc = 'Navigate to file [5]' })
	end
}
