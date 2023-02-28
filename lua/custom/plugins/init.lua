-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
	{
		'mbbill/undotree',
		keys = {
			{ "<leader>ut", "<Cmd>UndotreeToggle<CR>", desc = "Undotree Toggle" },
		},
	},

	{
		"windwp/nvim-autopairs",
		config = function()
			require("nvim-autopairs").setup {}
			-- If you want insert `(` after select function or method item
			local cmp_autopairs = require('nvim-autopairs.completion.cmp')
			local cmp = require('cmp')
			cmp.event:on(
				'confirm_done',
				cmp_autopairs.on_confirm_done()
			)
		end
	},

	-- Better escape: press jj or jk to get out of insert mode
	{
		"max397574/better-escape.nvim",
		config = function()
			require("better_escape").setup {
				mapping = { "jk", "jj" }, -- a table with mappings to use
				timeout = vim.o.timeoutlen, -- the time in which the keys must be hit in ms. Use option timeoutlen by default
				clear_empty_lines = false, -- clear line after escaping if there is only whitespace
				keys = "<Esc>", -- keys used for escaping, if it is a function will use the result everytime
				-- example(recommended)
				-- keys = function()
				--   return vim.api.nvim_win_get_cursor(0)[2] > 1 and '<esc>l' or '<esc>'
				-- end,
			}
		end,
	},

	{
		"axieax/urlview.nvim",
		config = function()
			require("urlview").setup({
				-- Prompt title (`<context> <default_title>`, e.g. `Buffer Links:`)
				default_title = "Links:",
				-- Default picker to display links with
				-- Options: "native" (vim.ui.select) or "telescope"
				default_picker = "native",
				-- Set the default protocol for us to prefix URLs with if they don't start with http/https
				default_prefix = "https://",
				-- Command or method to open links with
				-- Options: "netrw", "system" (default OS browser), "clipboard"; or "firefox", "chromium" etc.
				-- By default, this is "netrw", or "system" if netrw is disabled
				default_action = "netrw",
				-- Ensure links shown in the picker are unique (no duplicates)
				unique = true,
				-- Ensure links shown in the picker are sorted alphabetically
				sorted = true,
				-- Minimum log level (recommended at least `vim.log.levels.WARN` for error detection warnings)
				log_level_min = vim.log.levels.INFO,
				-- Keymaps for jumping to previous / next URL in buffer
				jump = {
					prev = "[u",
					next = "]u",
				},
			})
		end,

		keys = {
			{ "<leader>ul", "<Cmd>UrlView<CR>", desc = "View buffer URLs" },
		},
	},
}
