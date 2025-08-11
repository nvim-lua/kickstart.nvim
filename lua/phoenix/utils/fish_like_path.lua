local slice_table = require("phoenix.utils.slice_table")
local char_at = require("phoenix.utils.char_at")

local shrink_path = function(path)
  if char_at(path, 1) == "." then
    return char_at(path, 1) .. char_at(path, 2)
  else
    return char_at(path, 1)
  end
end

local substitute_home = function(path)
  return vim.fn.substitute(path, vim.fn.expand("$HOME"), "~", "")
end

local fish_like_path = function(path, level)
  if path == "" then
    return "[No Name]"
  end

  local paths = vim.fn.split(substitute_home(path), "/")

  if #paths == 0 then
    return "/"
  elseif #paths == 1 then
    if paths[1] == "~" then
      return "~/"
    else
      return path
    end
  end

  local after = slice_table(paths, -level)
  local before = slice_table(paths, 1, -level)

  for key, value in pairs(before) do
    before[key] = shrink_path(value)
  end

  return vim.fn.join(before, "/") .. "/" .. vim.fn.join(after, "/")
end

return fish_like_path
