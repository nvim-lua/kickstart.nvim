-- Shared utilities for kickstart plugin files
local M = {}

--- GitHub URL shorthand: gh('user/repo') -> 'https://github.com/user/repo'
---@param repo string
---@return string
function M.gh(repo)
  return 'https://github.com/' .. repo
end

return M
