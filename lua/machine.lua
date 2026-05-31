-- machine.lua
-- Loads machine-specific paths from machine.json in the config directory.
-- Copy machine.json.template to machine.json and fill in your paths.
local M = {}

local _cache = nil

local function load()
  local path = vim.fn.stdpath('config') .. '/machine.json'
  local f = io.open(path, 'r')
  if not f then return {} end
  local content = f:read('*a')
  f:close()
  local ok, data = pcall(vim.fn.json_decode, content)
  return (ok and type(data) == 'table') and data or {}
end

--- Get a machine-specific path by key.
--- Falls back to `fallback` if the key is missing or empty.
---@param key string
---@param fallback string|nil
---@return string|nil
function M.get(key, fallback)
  if not _cache then _cache = load() end
  local val = _cache[key]
  if val and val ~= '' then return val end
  return fallback
end

return M
