-- return {
-- 	"github/copilot.vim",
-- 	config = function()
-- 		vim.api.nvim_set_keymap("i", "<C-l>", 'copilot#Accept("<CR>")', { silent = true, expr = true })
-- 		vim.keymap.set('i', '<C-j>', '<Plug>(copilot-next)', { noremap = false })
-- 		vim.keymap.set('i', '<C-k>', '<Plug>(copilot-previous)', { noremap = false })
-- 		vim.keymap.set('i', '<M-.>', '<Plug>(copilot-suggest)', { noremap = false })
-- 	end
-- }

return {
	"zbirenbaum/copilot.lua",
	cmd = "Copilot",
	event = "InsertEnter",
	config = function()
		require("copilot").setup({
			panel = {
				enabled = true,
				auto_refresh = true,
				keymap = {
					jump_prev = "[[",
					jump_next = "]]",
					accept = "<CR>",
					refresh = "gr",
					open = "<M-CR>"
				},
				layout = {
					position = "bottom", -- | top | left | right
					ratio = 0.4
				},
			},
			suggestion = {
				enabled = true,
				auto_trigger = true,
				debounce = 75,
				keymap = {
					accept = "<M-l>",
					accept_word = false,
					accept_line = false,
					next = "<M-]>",
					prev = "<M-[>",
					dismiss = "<C-]>",
				},
			},
			filetypes = {
				yaml = true,
				markdown = true,
				help = false,
				gitcommit = true,
				gitrebase = false,
				hgcommit = false,
				terraform = true,
				go = true,
				html = true,
				templ = true,
				javascript = true,
				svn = false,
				cvs = false,
				["."] = true,
			},
			copilot_node_command = 'node', -- Node.js version must be > 18.x
			server_opts_overrides = {},
		})
	end,
}
