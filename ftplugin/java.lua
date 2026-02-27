local home = os.getenv 'HOME'
local workspace_path = home .. '/.local/share/nvim/jdtls-workspace/'
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
local workspace_dir = workspace_path .. project_name
local status, jdtls = pcall(require, 'jdtls')
if not status then
  return
end
-- Add nvim-cmp capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
local cmp_status, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
if cmp_status then
  capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
end
local extendedClientCapabilities = jdtls.extendedClientCapabilities
local config = {
  cmd = {
    'java',
    '-Declipse.application=org.eclipse.jdt.ls.core.id1',
    '-Dosgi.bundles.defaultStartLevel=4',
    '-Declipse.product=org.eclipse.jdt.ls.core.product',
    '-Dlog.protocol=true',
    '-Dlog.level=ALL',
    '-Xmx1g',
    '--add-modules=ALL-SYSTEM',
    '--add-opens',
    'java.base/java.util=ALL-UNNAMED',
    '--add-opens',
    'java.base/java.lang=ALL-UNNAMED',
    '-javaagent:' .. home .. '/.local/share/nvim/mason/packages/jdtls/lombok.jar',
    '-jar',
    vim.fn.glob(home .. '/.local/share/nvim/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_*.jar'),
    '-configuration',
    home .. '/.local/share/nvim/mason/packages/jdtls/config_linux',
    '-data',
    workspace_dir,
  },
  root_dir = require('jdtls.setup').find_root { '.git', 'mvnw', 'gradlew', 'pom.xml', 'build.gradle' },
  capabilities = capabilities,
  settings = {
    java = {
      signatureHelp = { enabled = true },
      extendedClientCapabilities = extendedClientCapabilities,
      maven = {
        downloadSources = true,
      },
      referencesCodeLens = {
        enabled = true,
      },
      references = {
        includeDecompiledSources = true,
      },
      inlayHints = {
        parameterNames = {
          enabled = 'all',
        },
      },
      format = {
        enabled = false,
      },
    },
  },
  init_options = {
    bundles = {},
  },
}
require('jdtls').start_or_attach(config)

-- Existing keymaps
vim.keymap.set('n', '<leader>co', "<Cmd>lua require'jdtls'.organize_imports()<CR>", { desc = 'Organize Imports' })
vim.keymap.set('n', '<leader>crv', "<Cmd>lua require('jdtls').extract_variable()<CR>", { desc = 'Extract Variable' })
vim.keymap.set('v', '<leader>crv', "<Esc><Cmd>lua require('jdtls').extract_variable(true)<CR>", { desc = 'Extract Variable' })
vim.keymap.set('n', '<leader>crc', "<Cmd>lua require('jdtls').extract_constant()<CR>", { desc = 'Extract Constant' })
vim.keymap.set('v', '<leader>crc', "<Esc><Cmd>lua require('jdtls').extract_constant(true)<CR>", { desc = 'Extract Constant' })
vim.keymap.set('v', '<leader>crm', "<Esc><Cmd>lua require('jdtls').extract_method(true)<CR>", { desc = 'Extract Method' })

-- NEW: Generator keymaps for constructors, getters, and setters
-- This opens the selection dialog instead of auto-applying
vim.keymap.set('n', '<leader>cgs', function()
  require('jdtls').organize_imports()
  vim.lsp.buf.code_action {
    filter = function(action)
      return string.match(action.title, 'Generate Getters and Setters')
    end,
    apply = false, -- Changed to false to show picker
  }
end, { desc = 'Generate Getters and Setters' })

vim.keymap.set('n', '<leader>cgg', function()
  vim.lsp.buf.code_action {
    filter = function(action)
      return string.match(action.title, 'Generate Getter')
    end,
    apply = false,
  }
end, { desc = 'Generate Getter' })

vim.keymap.set('n', '<leader>cgS', function()
  vim.lsp.buf.code_action {
    filter = function(action)
      return string.match(action.title, 'Generate Setter')
    end,
    apply = false,
  }
end, { desc = 'Generate Setter' })

vim.keymap.set('n', '<leader>cgc', function()
  vim.lsp.buf.code_action {
    filter = function(action)
      return string.match(action.title, 'Generate Constructor')
    end,
    apply = false,
  }
end, { desc = 'Generate Constructor' })

vim.keymap.set('n', '<leader>cgt', function()
  vim.lsp.buf.code_action {
    filter = function(action)
      return string.match(action.title, 'Generate toString')
    end,
    apply = false,
  }
end, { desc = 'Generate toString()' })

vim.keymap.set('n', '<leader>cgh', function()
  vim.lsp.buf.code_action {
    filter = function(action)
      return string.match(action.title, 'Generate hashCode')
    end,
    apply = false,
  }
end, { desc = 'Generate hashCode() and equals()' })

-- Alternative: Use general code action picker for all options
vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { desc = 'Code Actions' })
