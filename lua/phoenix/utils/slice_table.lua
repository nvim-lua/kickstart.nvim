local checkers = require("phoenix.utils.type-checkers")

-- Returns a shallow copy of a portion of a table into a new table
-- @param obj {table}
-- @param start {number} start value
-- @param finish {number} end value
-- @return {boolean}
local slice_table = function(obj, start, finish)
  if checkers.is_empty(obj) or start == finish then
    return {}
  end

  local output = {}
  local _finish = #obj
  local _start = 1

  if start >= 0 then
    _start = start
  elseif checkers.is_nil(finish) and start < 0 then
    _start = #obj + start + 1
  end

  if finish and finish >= 0 then
    _finish = finish - 1
  elseif finish and finish < 0 then
    _finish = #obj + finish
  end

  for i = _start, _finish do
    table.insert(output, obj[i])
  end

  return output
end

return slice_table
