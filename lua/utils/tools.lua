local M = {}

-- Helper function to find the executable in path, prioritizing non-mason paths
function M.find_executable(executable)
  -- First try with PATH environment variable
  local paths = vim.split(vim.env.PATH, ':', { plain = true })
  for _, dir in ipairs(paths) do
    if dir ~= '' and not string.find(dir, 'mason') then
      local path = dir .. '/' .. executable
      if vim.fn.filereadable(path) == 1 and vim.fn.executable(path) == 1 then
        return path
      end
    end
  end

  -- Fallback to mason path if needed
  local path = vim.fn.exepath(executable)
  return path ~= '' and path or nil
end

-- Function to detect python venv path
function M.get_python_venv_path()
  -- Get the directory of the current file
  local current_file = vim.api.nvim_buf_get_name(0)
  local current_dir = vim.fn.fnamemodify(current_file, ':h')

  -- Function to find git root
  local function find_git_root(path)
    local git_dir = vim.fn.finddir('.git', path .. ';')
    if git_dir ~= '' then
      return vim.fn.fnamemodify(git_dir, ':h')
    end
    return nil
  end

  -- Search paths in order: current directory, git root, user path
  local search_paths = {
    current_dir,
    find_git_root(current_dir),
    vim.fn.expand '~',
  }

  -- Check each search path for .venv
  for _, path in ipairs(search_paths) do
    if path then
      local venv_path = path .. '/.venv'
      if vim.fn.isdirectory(venv_path) == 1 then
        return venv_path .. '/bin'
      end
    end
  end

  -- Check for VIRTUAL_ENV environment variable (set by direnv or manually)
  local virtual_env = vim.env.VIRTUAL_ENV
  if virtual_env and virtual_env ~= '' then
    return virtual_env .. '/bin'
  end

  -- Default to system path
  return nil
end

-- Helper function to find executable in both venv and system PATH
function M.find_tool(tool_name)
  -- First check virtual env path
  local venv_path = M.get_python_venv_path()
  if venv_path then
    local tool_path = venv_path .. '/' .. tool_name
    if vim.fn.filereadable(tool_path) == 1 then
      return tool_path
    end
  end

  -- Fall back to executable in PATH
  return M.find_executable(tool_name)
end

-- Get LSP capabilities with cmp support
function M.get_lsp_capabilities()
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  local ok, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
  if ok then
    capabilities = vim.tbl_deep_extend('force', capabilities, cmp_nvim_lsp.default_capabilities())
  end
  return capabilities
end

-- Get LSP root directory for current buffer
function M.get_lsp_root()
  local buf = vim.api.nvim_get_current_buf()
  local clients = vim.lsp.get_clients { bufnr = buf }

  for _, client in ipairs(clients) do
    if client.config.root_dir then
      return client.config.root_dir
    end
  end

  -- Fallback to git root or current working directory
  local current_file = vim.api.nvim_buf_get_name(buf)
  local current_dir = vim.fn.fnamemodify(current_file, ':h')

  local git_root = vim.fs.dirname(vim.fs.find({ '.git' }, { path = current_dir, upward = true })[1])
  if git_root then
    return git_root
  end

  return vim.fn.getcwd()
end

return M
