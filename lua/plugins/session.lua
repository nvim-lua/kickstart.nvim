---@diagnostic disable: undefined-global
return {
  'echasnovski/mini.sessions',
  version = '*',
  event = 'VimEnter',
  config = function()
    local function get_session_name()
      return vim.fn.fnamemodify(vim.fn.getcwd(), ':t')
    end

    -- Cache Go project check per directory
    local go_project_cache = {}
    local function is_go_project()
      local cwd = vim.fn.getcwd()
      if go_project_cache[cwd] == nil then
        -- Single glob with brace expansion
        go_project_cache[cwd] = vim.fn.glob(cwd .. '/{*.go,go.mod,go.work}') ~= ''
      end
      return go_project_cache[cwd]
    end

    require('mini.sessions').setup({
      autoread = false,
      autowrite = true,
      directory = vim.fn.stdpath('data') .. '/sessions',
      file = '',
      force = { read = false, write = true, delete = false },
      hooks = {
        pre = {
          read = function() return not is_go_project() end,
          write = function() return not is_go_project() end,
        },
        -- After successful action
        post = { read = nil, write = nil, delete = nil },
      },
      -- Whether to print session path after action
      verbose = { read = false, write = true, delete = true },
    })

    -- Set up autocommands for auto-saving
    local session_group = vim.api.nvim_create_augroup('mini_sessions', { clear = true })
    vim.api.nvim_create_autocmd('VimLeavePre', {
      group = session_group,
      callback = function()
        local name = get_session_name()
        if name then
          require('mini.sessions').write(name, { force = true })
        end
      end,
    })
  end,
}
