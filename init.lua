-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Install package manager
--    https://github.com/folke/lazy.nvim
--    `:help lazy.nvim.txt` for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

local opts = {
  git = { log = { '--since=3 days ago' } },
  ui = { custom_keys = { false } },
  checker = { enabled = false },
  colorscheme = "monokai",
}

require('lazy').setup({
  -- Git related plugins
  'tpope/vim-fugitive',
  'tpope/vim-rhubarb',

  -- Detect tabstop and shiftwidth automatically
  'tpope/vim-sleuth',
  { import = 'custom.plugins' },
}, opts)

require('config.options')
require('config.mappings')

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})


-- [[ Configure LSP ]]
--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(_, bufnr)
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
  nmap('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
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

  -- Enable auto-formatting on save
  vim.api.nvim_command([[
    augroup AutoFormatOnSave
      autocmd!
      autocmd BufWritePre * :Format
    augroup END
  ]])
end
-- NOTE: Next Step on Your Neovim Journey: Add/Configure additional "plugins" for kickstart
-- Enable the following language servers
--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
--
--  Add any additional override configuration in the following tables. They will be passed to
--  the `settings` field of the server config. You must look up that documentation yourself.
--
--  If you want to override the default filetypes that your language server will attach to you can
--  define the property 'filetypes' to the map in question.

-- Function to find the nearest venv path in parent directories.
local function find_nearest_venv(starting_path)
  local current_path = starting_path
  while current_path do
    local venv_path = current_path .. '/venv/bin/python'
    if vim.fn.filereadable(venv_path) == 1 then
      return venv_path
    end
    local parent_path = vim.fn.fnamemodify(current_path, ':h')
    if parent_path == current_path then
      break
    end
    current_path = parent_path
  end
  return nil
end

-- Get the path of the current file.
local current_file = vim.fn.expand('%:p')

-- Get the venv path for the current project directory.
local venv_path = find_nearest_venv(current_file)

if venv_path then
  -- Use the venv path as your Python interpreter.
  vim.g.python3_host_prog = venv_path
else
  -- Fallback to a system-wide Python interpreter.
  vim.g.python3_host_prog = '/usr/bin/python3'
end

local servers = {
  clangd = {},
  gopls = {
    settings = {
      plugins = {
        revive = {},
      },
      gopls = {
        completeUnimported = true,
        usePlaceholders = true,
        analysis = {
          unusedarams = true,
        },
      },
    },
  },
  pylsp = {
    settings = {
      pylsp = {
        plugins = {
          pycodestyle = {
            ignore = { 'W391' },
            maxLineLength = 79
          },
          flake8 = {},
          black = {
            lineLength = 79,
            -- Configure Black to split lines without specifying a target version
            blackArgs = {
              "--line-length",
              "79",
              "--exclude",
              "venv",
              "--exclude",
              "env",
              "--exclude",
              ".git",
              "--exclude",
              ".hg",
            },
          },
          mypy = {
            enabled = true,
            command = 'mypy',
            args = {},
            diagnostics = true,
          },
          isort = {
            profile = 'black',
          },
        },
        python = {
          -- Specify the path to your Python interpreter
          pythonPath = "/usr/bin/python3",
          analysis = {
            autoSearchPaths = true,
            diagnosticMode = 'openFilesOnly',
            useLibraryCodeForTypes = true,
            typeCheckingMode = 'on',
          },
        },
      },
    },
  },
  -- rust_analyzer = {},
  -- tsserver = {},
  -- html = { filetypes = { 'html', 'twig', 'hbs'} },

  lua_ls = {
    Lua = {
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
    },
  },
}

-- Setup neovim lua configuration
require('neodev').setup()

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
-- Setup Mason condifuration
local mason = require 'mason'

mason.setup {
  ui = {
    icons = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗",
    },
  },
}
-- Ensure the servers above are installed
local mason_lspconfig = require 'mason-lspconfig'

mason_lspconfig.setup {
  ensure_installed = vim.tbl_keys(servers)
}

mason_lspconfig.setup_handlers {
  function(server_name)
    require('lspconfig')[server_name].setup {
      capabilities = capabilities,
      on_attach = on_attach,
      settings = servers[server_name],
      filetypes = (servers[server_name] or {}).filetypes,
    }
  end
}

-- Setup Linters
local mason_tool_installer = require("mason-tool-installer")

mason_tool_installer.setup({
  ensure_installed = {
    "prettier",
    "stylua",
    "isort",
    "black",
    "flake8",
    "mypy",
    "revive",
  },
})
