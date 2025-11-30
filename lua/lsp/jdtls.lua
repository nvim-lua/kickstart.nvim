local M = {}

function M.setup()
  local home = os.getenv 'HOME'
  local workspace_path = home .. '/.local/share/nvim/jdtls-workspace/'
  local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
  local workspace_dir = workspace_path .. project_name

  local status, jdtls = pcall(require, 'jdtls')
  if not status then
    vim.notify('jdtls not found!', vim.log.levels.ERROR)
    return
  end

  local extendedClientCapabilities = jdtls.extendedClientCapabilities

  -- Root markers for Java project
  local root_markers = { '.git', 'mvnw', 'gradlew', 'pom.xml', 'build.gradle' }

  local function find_root_dir()
    local parent_dir = vim.fn.fnamemodify(vim.fn.getcwd(), ':h')
    local root = jdtls.setup.find_root(root_markers, parent_dir)
    if not root or root == '' then
      root = jdtls.setup.find_root(root_markers)
    end
    return root or vim.fn.getcwd()
  end

  -- Java executable (Java 25, macOS)
  local java_exe = '/Library/Java/JavaVirtualMachines/temurin-25.jdk/Contents/Home/bin/java'

  local config = {
    cmd = {
      java_exe,
      '-Declipse.application=org.eclipse.jdt.ls.core.id1',
      '-Dosgi.bundles.defaultStartLevel=4',
      '-Declipse.product=org.eclipse.jdt.ls.core.product',
      '-Dlog.protocol=true',
      '-Dlog.level=ALL',
      '-Xmx2g',
      '--add-modules=ALL-SYSTEM',
      '--add-opens',
      'java.base/java.util=ALL-UNNAMED',
      '--add-opens',
      'java.base/java.lang=ALL-UNNAMED',
      '-javaagent:' .. home .. '/.local/share/nvim/mason/packages/jdtls/lombok.jar',
      '-jar',
      vim.fn.glob(home .. '/.local/share/nvim/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_*.jar'),
      '-configuration',
      home .. '/.local/share/nvim/mason/packages/jdtls/config_mac',
      '-data',
      workspace_dir,
    },

    root_dir = find_root_dir(),

    settings = {
      java = {
        signatureHelp = { enabled = true },
        extendedClientCapabilities = extendedClientCapabilities,
        maven = { downloadSources = true },
        referencesCodeLens = { enabled = true },
        references = { includeDecompiledSources = true },
        inlayHints = { parameterNames = { enabled = 'all' } },
        format = { enabled = false },
        saveActions = { organizeImports = false },
      },
    },

    init_options = {
      bundles = {},
    },
  }

  -- Start or attach jdtls
  jdtls.start_or_attach(config)

  --------------------------------------------------------------------
  -- Keymaps
  --------------------------------------------------------------------
  local opts = { noremap = true, silent = true }

  vim.keymap.set('n', '<leader>jo', "<Cmd>lua require'jdtls'.organize_imports()<CR>", { desc = 'Organize Imports' })
  vim.keymap.set('n', '<leader>jrv', "<Cmd>lua require('jdtls').extract_variable()<CR>", { desc = 'Extract Variable' })
  vim.keymap.set('v', '<leader>jrv', "<Esc><Cmd>lua require('jdtls').extract_variable(true)<CR>", { desc = 'Extract Variable' })
  vim.keymap.set('n', '<leader>jrc', "<Cmd>lua require('jdtls').extract_constant()<CR>", { desc = 'Extract Constant' })
  vim.keymap.set('v', '<leader>jrc', "<Esc><Cmd>lua require('jdtls').extract_constant(true)<CR>", { desc = 'Extract Constant' })
  vim.keymap.set('v', '<leader>jrm', "<Esc><Cmd>lua require('jdtls').extract_method(true)<CR>", { desc = 'Extract Method' })
  vim.keymap.set('n', 'nd', vim.lsp.buf.definition, { desc = 'Go to Definition' })
  vim.keymap.set('n', 'nD', vim.lsp.buf.declaration, { desc = 'Go to Declaration' })
  vim.keymap.set('n', 'nr', vim.lsp.buf.references, { desc = 'References' })
  vim.keymap.set('n', 'ni', vim.lsp.buf.implementation, { desc = 'Go to Implementation' })
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, { desc = 'Hover Documentation' })
  vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { desc = 'Rename Symbol' })
  vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { desc = 'Code Action' })
end

return M
