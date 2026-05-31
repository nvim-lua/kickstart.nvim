local machine = require('machine')

local function set_python_path(path)
  local clients = vim.lsp.get_clients {
    bufnr = vim.api.nvim_get_current_buf(),
    name = 'basedpyright',
  }
  for _, client in ipairs(clients) do
    client.config.settings = vim.tbl_deep_extend('force', client.config.settings or {}, { python = { pythonPath = path } })
    if client.settings then
      client.settings.python = vim.tbl_deep_extend('force', client.settings.python or {}, { pythonPath = path })
    end
    client.notify('workspace/didChangeConfiguration', { settings = client.config.settings })
  end
end

local function is_ue_project()
  local ok, unreal_nvim = pcall(require, 'unreal-nvim')
  if ok and unreal_nvim.find_uproject and unreal_nvim.find_uproject() then
    return true
  end
  return vim.fn.glob(vim.fn.getcwd() .. '/*.uproject') ~= ''
end

local function get_python_path()
  local venv_path = os.getenv 'VIRTUAL_ENV'
  if venv_path then
    return venv_path .. '/scripts/python.exe'
  end
  if is_ue_project() then
    local ue_python = machine.get('ue_python', nil)
    if ue_python then return ue_python end
  end
  local python_on_path = vim.fn.exepath('python')
  return python_on_path ~= '' and python_on_path or 'python'
end

local function get_current_ue_python_stub()
  local ok, unreal_nvim = pcall(require, 'unreal-nvim')
  if not ok then return '' end
  local ue_project = unreal_nvim.find_uproject()
  if ue_project then
    local ue_folder = ue_project:match '^(.*[\\/])'
    return ue_folder .. 'Intermediate\\PythonStub'
  end
  return ''
end

local function get_ue_python_plugins()
  local ok, unreal_nvim = pcall(require, 'unreal-nvim')
  if not ok then return {} end
  local folders = {}
  local ue_project = unreal_nvim.find_uproject()
  if ue_project then
    local ue_folder = ue_project:match '^(.*[\\/])'
    local ue_plugins = ue_folder .. 'Plugins\\'
    local handle = vim.uv.fs_scandir(ue_plugins)
    if not handle then return folders end
    while true do
      local name, t = vim.uv.fs_scandir_next(handle)
      if not name then break end
      if t == 'directory' then
        local plugin_folder = ue_plugins .. name .. '\\Content\\Python'
        local stat = vim.uv.fs_stat(plugin_folder)
        if stat ~= nil and stat.type == 'directory' then
          table.insert(folders, plugin_folder)
        end
      end
    end
  end
  return folders
end

-- Called lazily at server start, not at file load time
local function get_extra_paths()
  local paths = {
    get_current_ue_python_stub(),
    'C:/venvs/python_extras/Lib/site-packages',
  }
  vim.list_extend(paths, get_ue_python_plugins())
  return paths
end

return {
  cmd = { machine.get('basedpyright', vim.fn.exepath('basedpyright-langserver')), '--stdio' },
  filetypes = { 'python' },
  root_markers = {
    'pyproject.toml',
    'setup.py',
    'setup.cfg',
    'requirements.txt',
    'Pipfile',
    'pyrightconfig.json',
    '.git',
  },
  before_init = function(_, config)
    -- Settings are computed here, after plugins are loaded
    config.settings = vim.tbl_deep_extend('force', config.settings or {}, {
      python = {
        pythonPath = get_python_path(),
      },
      basedpyright = {
        disableOrganizeImports = true,
        analysis = {
          diagnosticSeverityOverrides = {
            reportUnannotatedClassAttribute = false,
            reportUnusedCallResult = false,
            reportAny = false,
          },
          autoImportCompletions = true,
          autoSearchPaths = true,
          useLibraryCodeForTypes = true,
          diagnosticMode = 'openFilesOnly',
          extraPaths = get_extra_paths(),
        },
      },
    })
  end,
  on_attach = function(client, bufnr)
    vim.api.nvim_buf_create_user_command(bufnr, 'LspPyrightOrganizeImports', function()
      client:exec_cmd {
        command = 'basedpyright.organizeimports',
        arguments = { vim.uri_from_bufnr(bufnr) },
      }
    end, { desc = 'Organize Imports' })

    vim.api.nvim_buf_create_user_command(bufnr, 'LspPyrightSetPythonPath', function(opts)
      set_python_path(opts.args)
    end, {
      desc = 'Reconfigure basedpyright with the provided python path',
      nargs = 1,
      complete = 'file',
    })

    vim.keymap.set('n', '<leader>pi', '<cmd>LspPyrightOrganizeImports<CR>', { buffer = bufnr, desc = '[P]ython Organize [I]mports' })
  end,
}
