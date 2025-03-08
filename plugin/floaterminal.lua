local state = {
  floating = {
    buf = -1,
    win = -1,
  },
}
-- Create a floating window with a terminal
function create_floating_terminal(opts)
  -- Get the width and height of the current screen
  local width = vim.o.columns
  local height = vim.o.lines

  -- Define the size of the floating window (you can adjust this to your needs)
  local win_width = opts.width or math.floor(width * 0.6) -- 60% of screen width
  local win_height = opts.height or math.floor(height * 0.5) -- 50% of screen height

  -- Center the window
  local row = math.floor((height - win_height) / 2)
  local col = math.floor((width - win_width) / 2)

  local buf = nil
  if vim.api.nvim_buf_is_valid(opts.buf) then
    buf = opts.buf
  else
    buf = vim.api.nvim_create_buf(false, true) -- Create an empty buffer
  end

  -- Define the border highlight group (adjust this to the color you prefer)
  local border_color = 'ColorColumn' -- Change to any highlight group of your choice

  -- Define window options
  local windowOptions = {
    relative = 'editor',
    width = win_width,
    height = win_height,
    col = col,
    row = row,
    style = 'minimal', -- We don't need any status line or title
    border = 'rounded',
  }

  -- Open the floating window with a terminal

  local win = vim.api.nvim_open_win(buf, true, windowOptions) -- Open the floating window

  -- Open a terminal inside the buffer
  return { buf = buf, win = win }
end

local toggleTerminal = function()
  if not vim.api.nvim_win_is_valid(state.floating.win) then
    state.floating = create_floating_terminal { buf = state.floating.buf }
    if vim.bo[state.floating.buf].buftype ~= 'terminal' then
      vim.cmd.terminal()
    end
  else
    vim.api.nvim_win_hide(state.floating.win)
  end
end
vim.api.nvim_create_user_command('Floaterminal', toggleTerminal, {})
-- Key mapping to open the floating terminal
vim.keymap.set({ 'n', 't' }, '<leader>tt', toggleTerminal)
