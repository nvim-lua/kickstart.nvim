-- Helper function to return a character from a string.
-- @param str {string}
-- @param index {number}
-- @returns {string}
local char_at = function(str, index)
  return string.sub(str, index, index)
end

return char_at
