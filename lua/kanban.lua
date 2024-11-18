-- kanban.lua
local api = vim.api
local fn = vim.fn

-- Create the kanban structure
local Kanban = {
  boards = {
    {
      title = 'TODO',
      tasks = {},
    },
    {
      title = 'IN PROGRESS',
      tasks = {},
    },
    {
      title = 'DONE',
      tasks = {},
    },
  },
  config_file = fn.stdpath 'data' .. '/kanban.json',
}

-- Utility functions for JSON handling
local function encode_json(data)
  return fn.json_encode(data)
end

local function decode_json(str)
  return fn.json_decode(str)
end

-- Save kanban state to file
function Kanban:save()
  local file = io.open(self.config_file, 'w')
  if file then
    file:write(encode_json(self.boards))
    file:close()
  end
end

-- Load kanban state from file
function Kanban:load()
  local file = io.open(self.config_file, 'r')
  if file then
    local content = file:read '*all'
    file:close()
    self.boards = decode_json(content)
  end
end

-- Create a new task
function Kanban:add_task(board_idx, task)
  if self.boards[board_idx] then
    table.insert(self.boards[board_idx].tasks, task)
    self:save()
    self:render()
  end
end

-- Move task between boards
function Kanban:move_task(from_board, task_idx, to_board)
  if self.boards[from_board] and self.boards[to_board] then
    local task = table.remove(self.boards[from_board].tasks, task_idx)
    if task then
      table.insert(self.boards[to_board].tasks, task)
      self:save()
      self:render()
    end
  end
end

-- Delete task
function Kanban:delete_task(board_idx, task_idx)
  if self.boards[board_idx] then
    table.remove(self.boards[board_idx].tasks, task_idx)
    self:save()
    self:render()
  end
end

-- Render the kanban board
function Kanban:render()
  -- Clear buffer
  api.nvim_buf_set_lines(0, 0, -1, false, {})

  local lines = {}
  local max_height = 0

  -- Calculate maximum height
  for _, board in ipairs(self.boards) do
    local height = #board.tasks + 3 -- Title + border + tasks
    if height > max_height then
      max_height = height
    end
  end

  -- Create board headers
  local headers = {}
  local separators = {}
  for _, board in ipairs(self.boards) do
    table.insert(headers, '| ' .. board.title .. ' |')
    table.insert(separators, string.rep('-', #board.title + 4))
  end

  -- Add headers
  table.insert(lines, table.concat(headers, ' '))
  table.insert(lines, table.concat(separators, ' '))

  -- Add tasks
  for i = 1, max_height - 3 do
    local row = {}
    for b, board in ipairs(self.boards) do
      local task = board.tasks[i] or ''
      local width = #headers[b] - 2
      task = task .. string.rep(' ', width - #task)
      table.insert(row, '|' .. task .. '|')
    end
    table.insert(lines, table.concat(row, ' '))
  end

  -- Set lines in buffer
  api.nvim_buf_set_lines(0, 0, -1, false, lines)
end

-- Commands
vim.cmd [[
  command! -nargs=1 KanbanAddTodo lua require'kanban':add_task(1, <q-args>)
  command! -nargs=1 KanbanAddProgress lua require'kanban':add_task(2, <q-args>)
  command! -nargs=1 KanbanAddDone lua require'kanban':add_task(3, <q-args>)
  command! -nargs=+ KanbanMove lua require'kanban':move_task(<f-args>)
  command! -nargs=+ KanbanDelete lua require'kanban':delete_task(<f-args>)
  command! KanbanLoad lua require'kanban':load()
  command! KanbanRender lua require'kanban':render()
]]

return Kanban
