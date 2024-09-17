local M = {}

local ls = require("luasnip")
local s = ls.snippet

local in_mathzone = function()
  return vim.fn["vimtex#syntax#in_mathzone"]() == 1
end

local in_text = function()
  return vim.fn["vimtex#syntax#in_mathzone"]() == 0
end

M.in_mathzone = in_mathzone
M.in_text = in_text

-- "as" for "Auto snippet"
local function as(trigger, nodes, opts)
  opts = opts or {}
  -- Add snippetType = "autosnippet" to the first parameter
  if type(trigger) == "table" then
    trigger.snippetType = "autosnippet"
  else
    trigger = { trig = trigger, snippetType = "autosnippet" }
  end
  return s(trigger, nodes, opts)
end

M.as = as

-- "asm" for "Auto snippet math"
function M.asm(trigger, nodes, opts)
  -- Only trigger commands in mathzones
  opts = opts or {}
  opts.condition = in_mathzone
  return as(trigger, nodes, opts)
end
--   Add snippetType = "autosnippet" to the first parameter
--   if type(trigger) == "table" then
--     trigger.snippetType = "autosnippet"
--   else
--     trigger = { trig = trigger, snippetType = "autosnippet" }
--   end
--   return s(trigger, nodes, opts)
-- end

-- "ast" for "Auto snippet text"
function M.ast(trigger, nodes, opts)
  -- Only trigger commands in mathzones
  opts = opts or {}
  opts.condition = in_text
  return as(trigger, nodes, opts)
  --   -- Add snippetType = "autosnippet" to the first parameter
  --   if type(trigger) == "table" then
  --     trigger.snippetType = "autosnippet"
  --   else
  --     trigger = { trig = trigger, snippetType = "autosnippet" }
  --   end
  --   return s(trigger, nodes, opts)
end
--
return M
