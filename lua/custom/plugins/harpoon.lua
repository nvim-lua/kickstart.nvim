return {
	-- Jumping between windows
	'ThePrimeagen/harpoon',
	dependencies = {
		'nvim-lua/plenary.nvim'
	},

	config = function ()
		require("harpoon").setup()
		-- Harpoon keymaps
		vim.keymap.set('n', '<C-a>', require('harpoon.mark').add_file, { desc = "Add file to harpoon list" })
		vim.keymap.set('n', '<C-e>', require('harpoon.ui').toggle_quick_menu, { desc = "Toggle harpoon quick menu" })
		vim.keymap.set('n', '<leader>1', function() require('harpoon.ui').nav_file(1) end, { desc = "Navigate to file at posistion 1" })
		vim.keymap.set('n', '<leader>2', function() require('harpoon.ui').nav_file(2) end, { desc = "Navigate to file at posistion 2" })
		vim.keymap.set('n', '<leader>3', function() require('harpoon.ui').nav_file(3) end, { desc = "Navigate to file at posistion 3" })
		vim.keymap.set('n', '<leader>4', function() require('harpoon.ui').nav_file(4) end, { desc = "Navigate to file at posistion 4" })
		vim.keymap.set('n', '<leader>5', function() require('harpoon.ui').nav_file(5) end, { desc = "Navigate to file at posistion 5" })
		vim.keymap.set('n', '<leader>6', function() require('harpoon.ui').nav_file(6) end, { desc = "Navigate to file at posistion 6" })
		vim.keymap.set('n', '<leader>7', function() require('harpoon.ui').nav_file(7) end, { desc = "Navigate to file at posistion 7" })
		vim.keymap.set('n', '<leader>8', function() require('harpoon.ui').nav_file(8) end, { desc = "Navigate to file at posistion 8" })
		vim.keymap.set('n', '<leader>9', function() require('harpoon.ui').nav_file(9) end, { desc = "Navigate to file at posistion 9" })
	end,
}
