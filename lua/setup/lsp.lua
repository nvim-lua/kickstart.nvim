vim.lsp.enable {
  'lua_ls',
  'basedpyright',
  'clangd',
  -- 'typos_lsp',
  -- 'ty',  -- removed: redundant with basedpyright, adds diagnostic noise
  'ts_ls',
  'cssls',
  'html',
}

vim.lsp.inlay_hint.enable(true)

local virtual_text_mode = nil
local base_virtual_text = {
  source = 'if_many',
  spacing = 2,
  format = function(diagnostic)
    return diagnostic.message
  end,
}
local diagnostic_underline = { severity = vim.diagnostic.severity.ERROR }

vim.diagnostic.config {
  virtual_text = base_virtual_text,
  underline = diagnostic_underline,
  update_in_insert = false,
  severity_sort = true,
  float = {
    border = 'rounded',
    source = 'if_many',
  },
  signs = vim.g.have_nerd_font and {
    text = {
      [vim.diagnostic.severity.ERROR] = '󰅚 ',
      [vim.diagnostic.severity.WARN] = '󰀪 ',
      [vim.diagnostic.severity.INFO] = '󰋽 ',
      [vim.diagnostic.severity.HINT] = '󰌶 ',
    },
    numhl = {
      [vim.diagnostic.severity.ERROR] = 'ErrorMsg',
      [vim.diagnostic.severity.WARN] = 'WarningMsg',
    } or {},
  },
}

vim.api.nvim_create_user_command('LspToggleDiagnostic', function()
  if virtual_text_mode == nil then
    virtual_text_mode = true
    vim.diagnostic.config {
      virtual_text = {
        current_line = virtual_text_mode,
      },
      underline = false,
    }
  else
    virtual_text_mode = nil
    vim.diagnostic.config {
      virtual_text = base_virtual_text,
      underline = diagnostic_underline,
    }
  end
end, {})

vim.api.nvim_create_user_command('LspToggleInlayHints', function()
  vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end, {})

vim.keymap.set('n', '<leader>ld', '<cmd>LspToggleDiagnostic<CR>', { desc = 'Toggle Lsp Diagnostic Mode' })
vim.keymap.set('n', '<leader>li', '<cmd>LspToggleInlayHints<CR>', { desc = 'Toggle Lsp Inlay Hints' })

-- Extras
local function restart_lsp(client_name)
  if not client_name or client_name == '' then
    vim.notify('restart_lsp: missing client_name', vim.log.levels.WARN)
    return
  end

  -- 1) Collect buffers that had this client and the client configs to reuse
  local target = {} -- [bufnr] = client.config
  local to_stop = {} -- [client_id] = client

  for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_loaded(bufnr) then
      for _, c in ipairs(vim.lsp.get_clients { bufnr = bufnr }) do
        if c.name == client_name then
          target[bufnr] = c.config
          to_stop[c.id] = c
        end
      end
    end
  end

  if vim.tbl_isempty(target) then
    vim.notify(("restart_lsp: no buffers with client '%s'"):format(client_name), vim.log.levels.INFO)
    return
  end

  -- 2) Stop all those clients (force=true)
  for _, client in pairs(to_stop) do
    client:stop(true)
  end

  -- 3) For each buffer, (re)start using the original config.
  --    vim.lsp.start() will *reuse* a running client with same name+root_dir
  --    and will attach this buffer; otherwise it spawns a new one.
  vim.defer_fn(function()
    for bufnr, cfg in pairs(target) do
      if vim.api.nvim_buf_is_valid(bufnr) and vim.api.nvim_buf_is_loaded(bufnr) then
        local conf = vim.deepcopy(cfg) -- don’t mutate the old config
        vim.api.nvim_buf_call(bufnr, function()
          vim.lsp.start(conf)
        end)
      end
    end
  end, 100)
end

vim.api.nvim_create_user_command('LspRestart', function(opts)
  restart_lsp(unpack(opts.fargs))
end, {
  nargs = '?',
})

local function lsp_status()
  local bufnr = vim.api.nvim_get_current_buf()
  local clients = vim.lsp.get_clients { bufnr = bufnr }

  if #clients == 0 then
    print '󰅚 No LSP clients attached'
    return
  end

  print('󰒋 LSP Status for buffer ' .. bufnr .. ':')
  print '─────────────────────────────────'

  for i, client in ipairs(clients) do
    print(string.format('󰌘 Client %d: %s (ID: %d)', i, client.name, client.id))
    print('  Root: ' .. (client.config.root_dir or 'N/A'))
    -- print('  Filetypes: ' .. table.concat(client.config.filetypes or {}, ', '))

    -- Check capabilities
    local caps = client.server_capabilities
    local features = {}
    if caps ~= nil then
      if caps.completionProvider then
        table.insert(features, 'completion')
      end
      if caps.hoverProvider then
        table.insert(features, 'hover')
      end
      if caps.definitionProvider then
        table.insert(features, 'definition')
      end
      if caps.referencesProvider then
        table.insert(features, 'references')
      end
      if caps.renameProvider then
        table.insert(features, 'rename')
      end
      if caps.codeActionProvider then
        table.insert(features, 'code_action')
      end
      if caps.documentFormattingProvider then
        table.insert(features, 'formatting')
      end
    end

    print('  Features: ' .. table.concat(features, ', '))
    print ''
  end
end

vim.api.nvim_create_user_command('LspStatus', lsp_status, { desc = 'Show detailed LSP status' })

local function check_lsp_capabilities()
  local bufnr = vim.api.nvim_get_current_buf()
  local clients = vim.lsp.get_clients { bufnr = bufnr }

  if #clients == 0 then
    print 'No LSP clients attached'
    return
  end

  for _, client in ipairs(clients) do
    print('Capabilities for ' .. client.name .. ':')
    local caps = client.server_capabilities
    if caps ~= nil then
      local capability_list = {
        { 'Completion', caps.completionProvider },
        { 'Hover', caps.hoverProvider },
        { 'Signature Help', caps.signatureHelpProvider },
        { 'Go to Definition', caps.definitionProvider },
        { 'Go to Declaration', caps.declarationProvider },
        { 'Go to Implementation', caps.implementationProvider },
        { 'Go to Type Definition', caps.typeDefinitionProvider },
        { 'Find References', caps.referencesProvider },
        { 'Document Highlight', caps.documentHighlightProvider },
        { 'Document Symbol', caps.documentSymbolProvider },
        { 'Workspace Symbol', caps.workspaceSymbolProvider },
        { 'Code Action', caps.codeActionProvider },
        { 'Code Lens', caps.codeLensProvider },
        { 'Document Formatting', caps.documentFormattingProvider },
        { 'Document Range Formatting', caps.documentRangeFormattingProvider },
        { 'Rename', caps.renameProvider },
        { 'Folding Range', caps.foldingRangeProvider },
        { 'Selection Range', caps.selectionRangeProvider },
      }
      for _, cap in ipairs(capability_list) do
        local status = cap[2] and '✓' or '✗'
        print(string.format('  %s %s', status, cap[1]))
      end
    end
    print ''
  end
end

vim.api.nvim_create_user_command('LspCapabilities', check_lsp_capabilities, { desc = 'Show LSP capabilities' })

local function lsp_diagnostics_info()
  local bufnr = vim.api.nvim_get_current_buf()
  local diagnostics = vim.diagnostic.get(bufnr)

  local counts = { ERROR = 0, WARN = 0, INFO = 0, HINT = 0 }

  for _, diagnostic in ipairs(diagnostics) do
    local severity = vim.diagnostic.severity[diagnostic.severity]
    counts[severity] = counts[severity] + 1
  end

  print '󰒡 Diagnostics for current buffer:'
  print('  Errors: ' .. counts.ERROR)
  print('  Warnings: ' .. counts.WARN)
  print('  Info: ' .. counts.INFO)
  print('  Hints: ' .. counts.HINT)
  print('  Total: ' .. #diagnostics)
end

vim.api.nvim_create_user_command('LspDiagnostics', lsp_diagnostics_info, { desc = 'Show LSP diagnostics count' })

local function lsp_info()
  local bufnr = vim.api.nvim_get_current_buf()
  local clients = vim.lsp.get_clients { bufnr = bufnr }

  print '═══════════════════════════════════'
  print '           LSP INFORMATION          '
  print '═══════════════════════════════════'
  print ''

  -- Basic info
  print('󰈙 Language client log: ' .. vim.lsp.get_log_path())
  print('󰈔 Detected filetype: ' .. vim.bo.filetype)
  print('󰈮 Buffer: ' .. bufnr)
  print('󰈔 Root directory: ' .. (vim.fn.getcwd() or 'N/A'))
  print ''

  if #clients == 0 then
    print('󰅚 No LSP clients attached to buffer ' .. bufnr)
    print ''
    print 'Possible reasons:'
    print('  • No language server installed for ' .. vim.bo.filetype)
    print '  • Language server not configured'
    print '  • Not in a project root directory'
    print '  • File type not recognized'
    return
  end

  print('󰒋 LSP clients attached to buffer ' .. bufnr .. ':')
  print '─────────────────────────────────'

  for i, client in ipairs(clients) do
    print(string.format('󰌘 Client %d: %s', i, client.name))
    print('  ID: ' .. client.id)
    print('  Root dir: ' .. (client.config.root_dir or 'Not set'))
    -- print('  Command: ' .. table.concat(client.config.cmd or {}, ' '))
    -- print('  Filetypes: ' .. table.concat(client.config.filetypes or {}, ', '))

    -- Server status
    if client:is_stopped() then
      print '  Status: 󰅚 Stopped'
    else
      print '  Status: 󰄬 Running'
    end

    -- Workspace folders
    if client.workspace_folders and #client.workspace_folders > 0 then
      print '  Workspace folders:'
      for _, folder in ipairs(client.workspace_folders) do
        print('    • ' .. folder.name)
      end
    end

    -- Attached buffers count
    local attached_buffers = {}
    for buf, _ in pairs(client.attached_buffers or {}) do
      table.insert(attached_buffers, buf)
    end
    print('  Attached buffers: ' .. #attached_buffers)

    -- Key capabilities
    local caps = client.server_capabilities
    local key_features = {}
    if caps ~= nil then
      if caps.completionProvider then
        table.insert(key_features, 'completion')
      end
      if caps.hoverProvider then
        table.insert(key_features, 'hover')
      end
      if caps.definitionProvider then
        table.insert(key_features, 'definition')
      end
      if caps.documentFormattingProvider then
        table.insert(key_features, 'formatting')
      end
      if caps.codeActionProvider then
        table.insert(key_features, 'code_action')
      end
    end

    if #key_features > 0 then
      print('  Key features: ' .. table.concat(key_features, ', '))
    end

    print ''
  end
  -- Diagnostics summary
  local diagnostics = vim.diagnostic.get(bufnr)
  if #diagnostics > 0 then
    print '󰒡 Diagnostics Summary:'
    local counts = { ERROR = 0, WARN = 0, INFO = 0, HINT = 0 }

    for _, diagnostic in ipairs(diagnostics) do
      local severity = vim.diagnostic.severity[diagnostic.severity]
      counts[severity] = counts[severity] + 1
    end

    print('  󰅚 Errors: ' .. counts.ERROR)
    print('  󰀪 Warnings: ' .. counts.WARN)
    print('  󰋽 Info: ' .. counts.INFO)
    print('  󰌶 Hints: ' .. counts.HINT)
    print('  Total: ' .. #diagnostics)
  else
    print '󰄬 No diagnostics'
  end

  print ''
  print 'Use :LspLog to view detailed logs'
  print 'Use :LspCapabilities for full capability list'
end

-- Create command
vim.api.nvim_create_user_command('LspInfo', lsp_info, { desc = 'Show comprehensive LSP information' })
