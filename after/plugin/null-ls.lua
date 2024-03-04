local setup, null_ls = pcall(require, 'null-ls')
if not setup then
  return
end

local formatting = null_ls.builtins.formatting
-- local diagnostics = null_ls.builtins.diagnostics
local conditional = function(fn)
  local utils = require('null-ls.utils').make_conditional_utils()
  return fn(utils)
end

local lsp_formatting = function(bufnr)
  vim.lsp.buf.format {
    timeout_ms = 2000,
    filter = function(client)
      -- apply whatever logic you want (in this example, we'll only use null-ls)
      return client.name ~= 'tsserver'
    end,
    bufnr = bufnr,
  }
end

local augroup = vim.api.nvim_create_augroup('LspFormatting', {})

-- local my_rubocop_formatter = require("rahcodes.null-ls.rubocop")
local rubocop = null_ls.builtins.formatting.rubocop

null_ls.setup {
  debug = false,
  sources = {
    formatting.prettier,
    -- formatting.stylua,
    null_ls.builtins.code_actions.gitsigns,
    -- setting eslint_d only if we have a ".eslintrc.js" file in the project
    -- diagnostics.eslint_d.with {
    --   condition = function(utils)
    --     return utils.root_has_file { '.eslintrc', '.eslintrc.js', '.eslintrc.json' }
    --   end,
    -- },

    -- Here we set a conditional to call the rubocop formatter. If we have a Gemfile in the project, we call "bundle exec rubocop", if not we only call "rubocop".
    conditional(function(utils)
      return utils.root_has_file 'Gemfile'
          and rubocop.with {
            command = 'bundle',
            args = vim.list_extend({ 'exec', 'rubocop' }, rubocop._opts.args),
          }
        or rubocop
    end),

    -- Same as above, but with diagnostics.rubocop to make sure we use the proper rubocop version for the project
    conditional(function(utils)
      return utils.root_has_file 'Gemfile'
          and null_ls.builtins.diagnostics.rubocop.with {
            command = 'bundle',
            args = vim.list_extend({ 'exec', 'rubocop' }, null_ls.builtins.diagnostics.rubocop._opts.args),
          }
        or null_ls.builtins.diagnostics.rubocop
    end),
  },
  -- format on save
  on_attach = function(client, bufnr)
    if client.supports_method 'textDocument/formatting' then
      vim.api.nvim_clear_autocmds { group = augroup, buffer = bufnr }
      vim.api.nvim_create_autocmd('BufWritePre', {
        group = augroup,
        buffer = bufnr,
        callback = function()
          lsp_formatting(bufnr)
        end,
      })
    end
  end,
}
