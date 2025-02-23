return {
  'echasnovski/mini.sessions',
  version = '*',
  event = "VimEnter",
  config = function()
    require('mini.sessions').setup({
      -- Whether to read latest session if Neovim opened without file arguments
      autoread = false,
      -- Whether to write current session before quitting Neovim
      autowrite = true,
      -- Directory where global sessions are stored (use `''` to disable)
      directory = vim.fn.stdpath('data') .. '/sessions',
      -- File for local session (use `''` to disable)
      file = '',
      -- Whether to force possibly harmful actions (meaning depends on function)
      force = { read = false, write = true, delete = false },
      -- Hook functions for actions. Default `nil` means 'do nothing'.
      hooks = {
        -- Before successful action
        pre = {
          read = function()
            -- Skip session operations for Go projects
            local current_dir = vim.fn.getcwd()
            local has_go_files = vim.fn.glob(current_dir .. "/*.go") ~= "" or
                                vim.fn.glob(current_dir .. "/go.mod") ~= "" or
                                vim.fn.glob(current_dir .. "/go.work") ~= ""
            
            if has_go_files then
              return false -- Skip for Go projects
            end
            return true
          end,
          write = function()
            -- Skip session operations for Go projects
            local current_dir = vim.fn.getcwd()
            local has_go_files = vim.fn.glob(current_dir .. "/*.go") ~= "" or
                                vim.fn.glob(current_dir .. "/go.mod") ~= "" or
                                vim.fn.glob(current_dir .. "/go.work") ~= ""
            
            if has_go_files then
              return false -- Skip for Go projects
            end
            return true
          end,
        },
        -- After successful action
        post = { read = nil, write = nil, delete = nil },
      },
      -- Whether to print session path after action
      verbose = { read = false, write = true, delete = true },
    })
  end
}
