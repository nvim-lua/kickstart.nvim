local servers = {
  -- clangd = {},
  -- gopls = {},
  -- pyright = {},
  -- rust_analyzer = {},
  tsserver = {},

  lua_ls = {
    Lua = {
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
    },
  },
}

-- Setup neovim lua configuration
require('neodev').setup()

-- nvim-cmp supports additional completion capabilities,
-- so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- Ensure the servers above are installed
local mason_lspconfig = require 'mason-lspconfig'

mason_lspconfig.setup {
  ensure_installed = vim.tbl_keys(servers),
}

local lspKeymaps = require('core.keymaps.async.language-servers')

local on_attach = function(_, bufnr)
  lspKeymaps(bufnr)
end

mason_lspconfig.setup_handlers {
  function(server_name)
    require('lspconfig')[server_name].setup {
      capabilities = capabilities,
      on_attach = on_attach,
      settings = servers[server_name],
    }
  end,
}

-- Tsserver run organize imports command
local function organize_imports()
  local params = {
    command = "_typescript.organizeImports",
    arguments = { vim.api.nvim_buf_get_name(0) },
    title = ""
  }
  vim.lsp.buf.execute_command(params)
end

local tsserverKeymaps = require('core.keymaps.async.tsserver')

local tsserver_on_attach = function(_, bufnr)
  lspKeymaps(bufnr)

  tsserverKeymaps(bufnr, {
    organize_imports = organize_imports
  })
end

require('lspconfig').tsserver.setup {
  on_attach = tsserver_on_attach,
  capabilities = capabilities,
  init_options = {
    preferences = {
      disableSuggestions = true
    }
  },
  commands = {
    OrganizeImports = {
      organize_imports,
      description = "Organize Imports"
    }
  }
}
