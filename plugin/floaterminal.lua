local terminals = {}

local function create_floating_window(opts)
  local opts = opts or {}

  -- Get editor dimensions
  local width = vim.o.columns
  local height = vim.o.lines

  -- Default size (80% of editor width and centered)
  local win_width = opts.width or math.ceil(width * 0.8)
  local win_height = opts.height or math.ceil(height * 0.8)

  -- Position (centered)
  local row = math.ceil((height - win_height) / 2)
  local col = math.ceil((width - win_width) / 2)

  -- Create a new buffer
  local buf = nil
  if opts.buf and vim.api.nvim_buf_is_valid(opts.buf) then
    buf = opts.buf
  else
    buf = vim.api.nvim_create_buf(false, true)
  end

  -- Set window options
  local win_opts = {
    title = 'Terminal ' .. opts.name,
    relative = 'editor',
    width = win_width,
    height = win_height,
    row = row,
    col = col,
    style = 'minimal',
    border = 'rounded',
  }

  -- Open the floating window
  local win = vim.api.nvim_open_win(buf, true, win_opts)

  return { buf = buf, win = win }
end

local function toggle_terminal(name)
  if not name or name == '' then
    return
  end

  -- Check if terminal exists for the given name
  if terminals[name] and vim.api.nvim_buf_is_valid(terminals[name].buf) then
    if vim.api.nvim_win_is_valid(terminals[name].win) then
      -- If window exists, hide it
      vim.api.nvim_win_hide(terminals[name].win)
      return
    else
      -- Otherwise, reopen the floating terminal
      terminals[name] = create_floating_window { buf = terminals[name].buf, name = name }
      vim.cmd 'normal i'
      return
    end
  end

  -- If it doesn't exist, create a new floating terminal
  terminals[name] = create_floating_window { name = name }
  vim.cmd.terminal()
  vim.cmd 'normal i'
end

local function list_active_terminals()
  local terminal_names = {}

  -- Collect names of active terminals
  for name, _ in pairs(terminals) do
    table.insert(terminal_names, name)
  end

  return terminal_names
end

local function list_terminals()
  local terminal_names = list_active_terminals()
  print(vim.inspect(terminal_names))
  -- If there are active terminals, show them in a Telescope picker
  if #terminal_names > 0 then
    -- show picker with terminals
  else
    vim.notify('No active terminals found', vim.log.levels.INFO)
  end
end

-- Map the keys
vim.keymap.set('n', '<space>t', function()
  vim.ui.input({ prompt = 'Enter terminal name: ' }, function(input)
    if input then
      toggle_terminal(input)
    end
  end)
end, { noremap = true, silent = true })

vim.keymap.set('n', '<space>lt', list_terminals, { noremap = true, silent = true })
