local M = {}

local find_buffer_by_type = function(type)
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    local ft = vim.api.nvim_buf_get_option(buf, "filetype")
    if ft == type then return buf end
  end
  return -1
end

local toggle_neotree = function(toggle_command)
  if find_buffer_by_type "neo-tree" > 0 then
    require("neo-tree.command").execute { action = "close" }
  else
    toggle_command()
  end
end

function M.toggle_explorer_cwd()
  toggle_neotree(function() require("neo-tree.command").execute { action = "focus", reveal = true, dir = vim.uv.cwd() } end)
end

function M.toggle_explorer_root()
  toggle_neotree(function() require("neo-tree.command").execute { action = "focus", reveal = true } end)
end

return M

