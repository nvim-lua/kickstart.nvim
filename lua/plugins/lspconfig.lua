-- Configuration for language servers
local function keymaps(bufnr)
	local keymap = function(keys, func, desc)
		if desc then
			desc = 'LSP: ' .. desc
		end

		vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
	end

	keymap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
	keymap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

	keymap('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
	keymap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
	keymap('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
	keymap('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
	keymap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
	keymap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

	keymap('K', vim.lsp.buf.hover, 'Hover Documentation')
	keymap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

	-- Lesser used LSP functionality
	keymap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
	keymap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
	keymap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
	keymap('<leader>wl', function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, '[W]orkspace [L]ist Folders')
end

return {
	-- LSP Configuration & Plugins
	'neovim/nvim-lspconfig',
	dependencies = {
		{ 'williamboman/mason.nvim', config = true },
		'williamboman/mason-lspconfig.nvim',

		-- Useful status updates for LSP
		{ 'j-hui/fidget.nvim',       opts = {} },

		-- Additional lua configuration, makes nvim stuff amazing!
		'folke/neodev.nvim',
	},
	config = function()
		local on_attach = function(_, bufnr)
			keymaps(bufnr)

			-- Create a command `:Format` local to the LSP buffer
			vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
				vim.lsp.buf.format()
			end, { desc = 'Format current buffer with LSP' })
		end

		-- mason-lspconfig requires that these setup functions are called in this order
		-- before setting up the servers.
		require('mason').setup()
		require('mason-lspconfig').setup()

		-- Enable the following language servers
		local servers = {
			lua_ls = {
				Lua = {
					workspace = { checkThirdParty = false },
					telemetry = { enable = false },
				},
			},
			rust_analyzer = { filetypes = { 'rust', 'rs' } },
			svelte = { filetypes = { 'svelte' } },
			tsserver = {},
		}

		-- Setup neovim lua configuration
		require('neodev').setup()

		-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
		local capabilities = vim.lsp.protocol.make_client_capabilities()
		capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

		-- Ensure the servers above are installed
		local mason_lspconfig = require 'mason-lspconfig'

		mason_lspconfig.setup {
			ensure_installed = vim.tbl_keys(servers),
		}

		mason_lspconfig.setup_handlers {
			function(server_name)
				require('lspconfig')[server_name].setup {
					capabilities = capabilities,
					on_attach = on_attach,
					settings = servers[server_name],
					filetypes = (servers[server_name] or {}).filetypes,
				}
			end,
		}
	end
}
