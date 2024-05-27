-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
	{
		"ThePrimeagen/harpoon",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		opts = {
			global_settings = {
				save_on_toggle = true,
				enter_on_sendcmd = true,
			},
		},
		config = function ()
			local harpoon_ui = require("harpoon.ui")
			local harpoon_mark = require("harpoon.mark")

			-- Harpoon keybinds --
			-- Open harpoon ui
			vim.keymap.set("n", "<C-e>", function()
				harpoon_ui.toggle_quick_menu()
			end)

			-- Add current file to harpoon
			vim.keymap.set("n", "<leader>a", function()
				harpoon_mark.add_file()
			end)

			-- Quickly jump to harpooned files
			vim.keymap.set("n", "<leader>1", function()
				harpoon_ui.nav_file(1)
			end)

			vim.keymap.set("n", "<leader>2", function()
				harpoon_ui.nav_file(2)
			end)

			vim.keymap.set("n", "<leader>3", function()
				harpoon_ui.nav_file(3)
			end)

			vim.keymap.set("n", "<leader>4", function()
				harpoon_ui.nav_file(4)
			end)

			vim.keymap.set("n", "<leader>5", function()
				harpoon_ui.nav_file(5)
			end)
		end
	},

	{
		'stevearc/oil.nvim',
		opts = {},
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("oil").setup({
				columns = { "icon" },
				keymaps = {
					["<C-h>"] = false,
					["<M-h>"] = "actions.select_split",
				},
				view_options = {
					show_hidden = true,
				},
			})

			-- Open parent directory in current window
			vim.keymap.set("n", "-", "<CMD>Oil<CR>",{ desc = "Open parent directory" })

			-- Open parent directory in floating window
			vim.keymap.set("n", "<space>-", require("oil").toggle_float)
		end,
	},

	{
		'm4xshen/hardtime.nvim',
		dependecies = { 'MunifTanjim/nui.nvim', 'nvim-lua/plenary.nvim' },
		opts = {
			restriction_mode = 'hint',
		},
	},
}
