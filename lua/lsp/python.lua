local tools = require 'utils.tools'

-- Get LSP capabilities with cmp support
local capabilities = tools.get_lsp_capabilities()

-- Setup multiple Python LSP servers using autocmd (not via vim.lsp.enable)
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'python',
  callback = function()
    -- Stop any unwanted Python LSPs that may have been auto-started
    local unwanted_lsps = { 'pylsp', 'pyright', 'mypy' }
    local clients = vim.lsp.get_clients { bufnr = 0 }

    for _, client in ipairs(clients) do
      for _, unwanted in ipairs(unwanted_lsps) do
        if client.name == unwanted then
          vim.lsp.stop_client(client.id, true)
          vim.notify('Stopped unwanted LSP: ' .. client.name, vim.log.levels.INFO)
        end
      end
    end

    -- Common root directory lookup for all Python LSPs
    local current_file = vim.api.nvim_buf_get_name(0)
    local file_dir = vim.fs.dirname(current_file)
    local root_dir = vim.fs.dirname(
      vim.fs.find(
        { 'pyproject.toml', 'setup.py', 'setup.cfg', 'requirements.txt', 'Pipfile', 'pyrightconfig.json', 'ruff.toml', '.ruff.toml' },
        { path = file_dir, upward = true }
      )[1]
    )

    local pyright_path = tools.find_tool 'basedpyright-langserver'
    local ruff_path = tools.find_tool 'ruff'
    local jedi_path = tools.find_tool 'jedi-language-server'
    local python3_path = tools.find_tool 'python3'

    -- Setup pyright (hover and type checking)
    -- https://docs.basedpyright.com/dev/
    if pyright_path then
      local pyright_capabilities = vim.tbl_deep_extend('force', capabilities, {})

      vim.lsp.start {
        name = 'basedpyright',
        cmd = { pyright_path, '--stdio' },
        root_dir = root_dir,
        capabilities = pyright_capabilities,
        settings = {
          basedpyright = {
            analysis = {
              autoImportCompletion = true,
              autoSearchPaths = true,
              diagnosticMode = 'openFilesOnly',
              typeCheckingMode = 'off', -- 'basic',
              useLibraryCodeForTypes = true,
              inlayHints = {
                callArgumentNames = true,
              },
            },
            pythonPath = python3_path,
            extraPaths = vim.list_extend(
              vim.fn.isdirectory(root_dir .. '/python') == 1 and { root_dir .. '/python' } or {},
              vim.split(vim.env.PYTHONPATH or '', ':')
            ),
          },
        },
        handlers = {
          ['textDocument/publishDiagnostics'] = function() end,
        },
      }
    end

    -- Setup ruff (linting and formatting)
    if ruff_path then
      local ruff_capabilities = vim.tbl_deep_extend('force', capabilities, {})
      ruff_capabilities.textDocument.completion = nil
      ruff_capabilities.hoverProvider = false

      vim.lsp.start {
        name = 'ruff',
        cmd = { ruff_path, 'server' },
        root_dir = root_dir,
        capabilities = ruff_capabilities,
        handlers = {
          ['textDocument/hover'] = function() end,
          ['textDocument/completion'] = function() end,
        },
      }
    end

    -- Setup jedi language server (completions)
    if jedi_path then
      local jedi_capabilities = vim.tbl_deep_extend('force', capabilities, {})
      jedi_capabilities.hoverProvider = false

      vim.lsp.start {
        name = 'jedi_language_server',
        cmd = { jedi_path },
        root_dir = root_dir,
        capabilities = jedi_capabilities,
        init_options = {
          diagnostics = {
            enable = false,
            didOpen = false,
            didChange = false,
            didSave = false,
          },
        },
        handlers = {
          ['textDocument/publishDiagnostics'] = function() end,
          ['textDocument/hover'] = function() end,
        },
      }
    end
  end,
})

-- Return empty config since we handle Python LSP manually via autocmd above
return {}
