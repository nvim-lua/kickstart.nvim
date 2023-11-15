-- return {
-- 	'fatih/vim-go',
-- }
return {
	"ray-x/go.nvim",
	dependencies = { -- optional packages
		"ray-x/guihua.lua",
		"neovim/nvim-lspconfig",
		"nvim-treesitter/nvim-treesitter",
	},
	config = function()
		require("go").setup({
			-- lsp_codelens = true,
			-- lsp_cfg = true,
			-- log_path = "/tmp/gonvim.log",
			-- verbose = true,
			run_in_floaterm = true,

			-- lsp_on_client_start = function(client, bufnr)
			-- 	require('config.keymap').go_on_attach(client, bufnr)
			-- 	require('lsp_signature').on_attach()
			--
			-- 	local nmap = function(keys, func, desc)
			-- 		if desc then
			-- 			desc = 'LSP: ' .. desc
			-- 		end
			--
			-- 		vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
			-- 	end
			-- 	-- nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
			-- 	-- vim.lsp.codelens.refresh()
			-- end,
		})

		local gofmt = require("go.format")

		vim.keymap.set('n', 'gF', gofmt.goimport, { desc = 'Go Import' })
	end,
	event = { "CmdlineEnter" },
	ft = { "go", 'gomod' },
	build = ':lua require("go.install").update_all_sync()' -- if you need to install/update all binaries
}
-- return {}
