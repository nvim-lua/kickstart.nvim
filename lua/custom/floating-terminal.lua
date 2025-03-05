local M = {}

local state = {
  floating = {
    buf = -1,
    win = -1,
    job_id = -1,
  },
}

local function create_floating_term(opts)
  opts = opts or {}

  local width = math.floor(vim.o.columns * 0.8)
  local height = math.floor(vim.o.lines * 0.8)
  local row = math.floor((vim.o.lines - height) / 2)
  local col = math.floor((vim.o.columns - width) / 2)

  local buf = nil
  if not opts.buf or not vim.api.nvim_buf_is_valid(opts.buf) then
    buf = vim.api.nvim_create_buf(false, true)
  else
    buf = opts.buf
  end

  local win_config = {
    relative = 'editor',
    width = width,
    height = height,
    row = row,
    col = col,
    style = 'minimal',
    border = 'rounded',
  }

  local win = vim.api.nvim_open_win(buf, true, win_config)
  return { buf = buf, win = win }
end

-- Function for checking if a file exists, just check that you can open it for reading
local function file_exists(filepath)
  local f = io.open(filepath, 'r')
  if f then
    f:close()
    return true
  end
  return false
end

M.toggle_terminal = function()
  if state.floating.win == -1 or not vim.api.nvim_win_is_valid(state.floating.win) then
    state.floating = create_floating_term { buf = state.floating.buf }
    if vim.bo[state.floating.buf].buftype ~= 'terminal' then
      state.floating.job_id = vim.fn.termopen(vim.o.shell)

      if file_exists '.envrc' then
        vim.defer_fn(function()
          if state.floating.job_id then
            vim.fn.chansend(state.floating.job_id, 'direnv reload\n')
          end
        end, 100)
      end
    end
  else
    vim.api.nvim_win_hide(state.floating.win)
    state.floating.win = -1
  end
end

-- Custom command for opening and closing floating terminal
vim.api.nvim_create_user_command('FloatingTerminal', M.toggle_terminal, {})
vim.keymap.set({ 'n', 't' }, '<leader>tt', M.toggle_terminal)

return M
