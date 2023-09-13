local capabilities = vim.lsp.protocol.make_client_capabilities()
local path = {}

path.data_dir = vim.fn.stdpath('cache') .. '/nvim-jdtls'
local data_dir = path.data_dir .. '/' .. vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')

local jdtls_install = require('mason-registry')
    .get_package('jdtls')
    :get_install_path()

path.java_agent = jdtls_install .. '/lombok.jar'
path.launcher_jar = vim.fn.glob(jdtls_install .. '/plugins/org.eclipse.equinox.launcher_*.jar')
path.platform_config = jdtls_install .. '/config_mac'


-- See `:help vim.lsp.start_client` for an overview of the supported `config` options.
local config = {
	-- The command that starts the language server
	-- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
	cmd = {

		-- 💀
		-- 'java', -- or '/path/to/java17_or_newer/bin/java'
		-- depends on if `java` is in your $PATH env variable and if it points to the right version.
		'/Library/Java/JavaVirtualMachines/temurin-19.jdk/Contents/Home/bin/java',
		-- '/Library/Java/JavaVirtualMachines/jdk1.8.0_181.jdk/Contents/Home/bin/java',
		-- '/Library/Java/JavaVirtualMachines/temurin-17.jdk/Contents/Home/bin/java',

		'-Declipse.application=org.eclipse.jdt.ls.core.id1',
		'-Dosgi.bundles.defaultStartLevel=4',
		'-Declipse.product=org.eclipse.jdt.ls.core.product',
		'-Dlog.protocol=true',
		'-Dlog.level=ALL',
		'-javaagent:' .. path.java_agent,
		'-Xmx1g',
		'--add-modules=ALL-SYSTEM',
		'--add-opens', 'java.base/java.util=ALL-UNNAMED',
		'--add-opens', 'java.base/java.lang=ALL-UNNAMED',

		-- 💀
		-- '-jar', '/path/to/jdtls_install_location/plugins/org.eclipse.equinox.launcher_VERSION_NUMBER.jar',
		'-jar', path.launcher_jar,
		-- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^                                       ^^^^^^^^^^^^^^
		-- Must point to the                                                     Change this to
		-- eclipse.jdt.ls installation                                           the actual version


		-- 💀
		-- '-configuration', '/path/to/jdtls_install_location/config_SYSTEM',
		'-configuration', path.platform_config,
		-- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^        ^^^^^^
		-- Must point to the                      Change to one of `linux`, `win` or `mac`
		-- eclipse.jdt.ls installation            Depending on your system.


		-- 💀
		-- See `data directory configuration` section in the README
		-- '-data', '/path/to/unique/per/project/workspace/folder'
		'-data', data_dir,
	},

	-- 💀
	-- This is the default if not provided, you can remove it. Or adjust as needed.
	-- One dedicated LSP server & client will be started per unique root_dir
	-- root_dir = require('jdtls.setup').find_root({'.git', 'mvnw', 'gradlew', 'pom.xml', 'build.gradle'}),
	root_dir = vim.fs.dirname(vim.fs.find({ '.git', 'mvnw', 'gradlew', 'pom.xml', 'build.gradle' }, { upward = true })
		[1]),
	-- Here you can configure eclipse.jdt.ls specific settings
	-- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
	-- for a list of options
	settings = {
		java = {
			home = '/Library/Java/JavaVirtualMachines/jdk1.8.0_181.jdk/Contents/Home',
			eclipse = {
				downloadSources = true,
			},
			maven = {
				downloadSources = true,
			},
			configuration = {
				updateBuildConfiguration = "interactive",
				runtimes = {
					name = 'JavaSE-1.8',
					path = '/Library/Java/JavaVirtualMachines/jdk1.8.0_181.jdk/Contents/Home',
					default = true,
				},
				-- runtimes = {
				--  name = 'JavaSE-19',
				--  path = '/Library/Java/JavaVirtualMachines/temurin-19.jdk',
				--  default = true,
				-- },
			},
			import = {
				gradle = {
					enabled = true,
					java = {
						home = '/Library/Java/JavaVirtualMachines/jdk1.8.0_181.jdk/Contents/Home',
					},
				}
			}
		}
	},

	-- Language server `initializationOptions`
	-- You need to extend the `bundles` with paths to jar files
	-- if you want to use additional eclipse.jdt.ls plugins.
	--
	-- See https://github.com/mfussenegger/nvim-jdtls#java-debug-installation
	--
	-- If you don't plan on using the debugger or other eclipse.jdt.ls plugins you can remove this
	init_options = {
		bundles = {}
	},
	on_attach = function(client, bufnr)
		-- Diagnostic keymaps
		-- vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
		-- vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
		-- vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
		-- vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

		-- [[ Configure LSP ]]
		--  This function gets run when an LSP connects to a particular buffer.
		-- local on_attach = function(_, bufnr)
		-- NOTE: Remember that lua is a real programming language, and as such it is possible
		-- to define small helper and utility functions so you don't have to repeat yourself
		-- many times.
		--
		-- In this case, we create a function that lets us more easily define mappings specific
		-- for LSP related items. It sets the mode, buffer and description for us each time.
		local nmap = function(keys, func, desc)
			if desc then
				desc = 'LSP: ' .. desc
			end

			vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
		end

		nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
		nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

		nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
		nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
		nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
		nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
		nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
		nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

		-- See `:help K` for why this keymap
		nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
		nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

		-- Lesser used LSP functionality
		nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
		nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
		nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
		nmap('<leader>wl', function()
			print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
		end, '[W]orkspace [L]ist Folders')

		-- Create a command `:Format` local to the LSP buffer
		vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
			vim.lsp.buf.format()
		end, { desc = 'Format current buffer with LSP' })
		-- end
	end
}

-- This starts a new client & server,
-- or attaches to an existing client & server depending on the `root_dir`.
require('jdtls').start_or_attach(config)

-- local opts = {
--   noremap = true,
--   silent = true,
-- }
-- vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)
-- vim.api.nvim_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
-- vim.api.nvim_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
-- vim.api.nvim_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
-- vim.api.nvim_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
-- vim.api.nvim_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
-- vim.api.nvim_set_keymap('n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
-- vim.api.nvim_set_keymap('n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
-- vim.api.nvim_set_keymap('n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
-- vim.api.nvim_set_keymap('n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
-- vim.api.nvim_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
-- vim.api.nvim_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
-- vim.api.nvim_set_keymap('n', '<leader>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
-- vim.api.nvim_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next<CR>', opts)
-- vim.api.nvim_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev<CR>', opts)
-- -- vim.api.nvim_set_keymap('n', '<leader>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
-- vim.api.nvim_set_keymap('n', '<leader>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
-- vim.api.nvim_set_keymap('n', '<leader>lg', '<cmd>lua vim.lsp.buf.formatting_sync(nil, 1000)<CR>', opts)
--
-- vim.api.nvim_set_keymap('n', '<leader>lA', '<cmd>lua vim.lsp.buf.code_action()<CR>', { silent = true })
-- vim.api.nvim_set_keymap('n', '<leader>lA', '<cmd>lua require(\'jdtls\').code_action()<CR>', { silent = true })
