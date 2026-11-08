-- [[ Language servers ]]
-- Uses Neovim's built-in LSP client (vim.lsp.config / vim.lsp.enable).
-- nvim-lspconfig only supplies the base config for each server; the server
-- programs come from the OS package manager (pacman, apt/npm/pipx, Nix).

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('user-lsp-attach', { clear = true }),
  callback = function(event)
    local builtin = require 'user.plugins.telescope'() -- sets telescope up on first use
    local map = function(keys, func, desc)
      vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
    end

    -- Built-in defaults also apply: K (hover), grn (rename), gra (code action),
    -- gri (implementation), grt (type definition), gO (document symbols).
    map('gd', builtin.lsp_definitions, 'Goto Definition')
    map('grr', builtin.lsp_references, 'Goto References')
    map('gI', builtin.lsp_implementations, 'Goto Implementation')
    map('<leader>lD', builtin.lsp_type_definitions, 'Type Definition')
    map('<leader>ls', builtin.lsp_document_symbols, 'Symbols')
    map('<leader>lS', builtin.lsp_dynamic_workspace_symbols, 'Workspace Symbols')
    map('<leader>lr', vim.lsp.buf.rename, 'LSP Rename under cursor')
    map('<leader>la', vim.lsp.buf.code_action, 'Code Action')
    map('gD', vim.lsp.buf.declaration, 'Goto Declaration')

    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if client and client.name == 'clangd' then
      map('gs', '<cmd>LspClangdSwitchSourceHeader<cr>', 'Switch between source/header')
    end

    -- Highlight other uses of the symbol under the cursor
    if client and client.server_capabilities.documentHighlightProvider then
      local highlight_augroup = vim.api.nvim_create_augroup('user-lsp-highlight', { clear = false })
      vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.document_highlight,
      })
      vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.clear_references,
      })
      vim.api.nvim_create_autocmd('LspDetach', {
        group = vim.api.nvim_create_augroup('user-lsp-detach', { clear = true }),
        callback = function(event2)
          vim.lsp.buf.clear_references()
          vim.api.nvim_clear_autocmds { group = 'user-lsp-highlight', buffer = event2.buf }
        end,
      })
    end
  end,
})

-- Completion capabilities from nvim-cmp
local capabilities = vim.tbl_deep_extend('force', vim.lsp.protocol.make_client_capabilities(), require('cmp_nvim_lsp').default_capabilities())

local servers = {
  clangd = { filetypes = { 'c', 'cpp', 'objc', 'objcpp', 'cuda', 'proto' } }, -- C/C++
  lua_ls = { settings = { Lua = { completion = { callSnippet = 'Replace' } } } }, -- Lua
  nil_ls = { settings = { ['nil'] = { formatting = { command = { 'nixpkgs-fmt' } } } } }, -- Nix
  taplo = {}, -- TOML
  yamlls = { settings = { yaml = { format = { enable = true } } } }, -- YAML
  pyright = {}, -- Python: types, completion, navigation
  ruff = { -- Python: linting and quick fixes (hover is left to pyright)
    on_attach = function(client)
      client.server_capabilities.hoverProvider = false
    end,
  },
  bashls = {}, -- Bash (uses shellcheck for diagnostics when installed)
  rust_analyzer = {}, -- Rust
}

vim.lsp.config('*', { capabilities = capabilities })
for name, server in pairs(servers) do
  vim.lsp.config(name, server)
  -- Only enable servers that are installed on this machine
  local cmd = vim.lsp.config[name].cmd
  if type(cmd) ~= 'table' or vim.fn.executable(cmd[1]) == 1 then
    vim.lsp.enable(name)
  end
end
