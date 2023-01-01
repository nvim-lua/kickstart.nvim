local lsp = require("lsp-zero")

lsp.preset("recommended")

lsp.ensure_installed({
	"tsserver",
	"eslint",
	"sumneko_lua",
	"rust_analyzer",
})

-- see documentation of null-null-ls for more configuration options!
local mason_nullls = require("mason-null-ls")
mason_nullls.setup({
	automatic_installation = true,
	automatic_setup = true,
})
mason_nullls.setup_handlers({})

local Remap = require("rahcodes.keymap")
local nnoremap = Remap.nnoremap
local inoremap = Remap.inoremap

-- Setup nvim-cmp.
local cmp = require("cmp")
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = lsp.defaults.cmp_mappings({
	["<C-u>"] = cmp.mapping.scroll_docs(-4),
	["<C-d>"] = cmp.mapping.scroll_docs(4),
	["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
	["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
	["<C-y>"] = cmp.mapping.confirm({ select = true }),
	["<C-Space>"] = cmp.mapping.complete(),
})
lsp.setup_nvim_cmp({
	mapping = cmp_mappings,
})

lsp.on_attach = function(client, bufnr)
	-- Disable LSP server formatting, to prevent formatting twice.
	-- Once by the LSP server, second time by NULL-ls.
	if client.name == "volar" or client.name == "tsserver" then
		client.server_capabilities.documentFormattingProvider = false
		client.server_capabilities.documentFormattingRangeProvider = false
	end

	local opts = { buffer = bufnr, remap = false }

	nnoremap("gd", function()
		vim.lsp.buf.definition()
	end, opts)
	nnoremap("gD", function()
		vim.lsp.buf.definition()
	end, opts)
	nnoremap("K", function()
		vim.lsp.buf.hover()
	end, opts)
	nnoremap("gi", function()
		vim.lsp.buf.implementation()
	end, opts)
	nnoremap("<leader>wa", function()
		vim.lsp.buf.add_workspace_folder()
	end, opts)
	nnoremap("<leader>wr", function()
		vim.lsp.buf.remove_workspace_folder()
	end, opts)
	nnoremap("<leader>wl", function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, opts)
	nnoremap("<leader>vws", function()
		vim.lsp.buf.workspace_symbol()
	end, opts)
	nnoremap("<leader>vd", function()
		vim.diagnostic.open_float()
	end, opts)
	nnoremap("[d", function()
		vim.diagnostic.goto_next()
	end, opts)
	nnoremap("]d", function()
		vim.diagnostic.goto_prev()
	end, opts)
	nnoremap("<leader>ca", function()
		vim.lsp.buf.code_action()
	end, opts)
	nnoremap("<leader>vco", function()
		vim.lsp.buf.code_action({
			filter = function(code_action)
				if not code_action or not code_action.data then
					return false
				end

				local data = code_action.data.id
				return string.sub(data, #data - 1, #data) == ":0"
			end,
			apply = true,
		})
	end, opts)
	nnoremap("<leader>gr", function()
		vim.lsp.buf.references()
	end, opts)
	nnoremap("<leader>rn", function()
		vim.lsp.buf.rename()
	end, opts)
	inoremap("<C-h>", function()
		vim.lsp.buf.signature_help()
	end, opts)
	nnoremap("<leader>f", function()
		vim.lsp.buf.format({ async = true })
	end, opts)
end

lsp.setup()
