local M = {}

local ls = require("luasnip")
local sn = ls.snippet_node
local i = ls.insert_node
local s = ls.snippet
local isn = ls.indent_snippet_node
local t = ls.text_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local events = require("luasnip.util.events")
local ai = require("luasnip.nodes.absolute_indexer")
local fmt = require("luasnip.extras.fmt").fmt
local m = require("luasnip.extras").m
local lambda = require("luasnip.extras").l
local postfix = require("luasnip.extras.postfix").postfix

ls.config.setup{
  -- Allow autotrigger snippets
  enable_autosnippets = true,
  -- For equivalent of UltiSnips visual selection
  store_selection_keys = "<Tab>",
  -- Event on which to check for exiting a snippet's region
  region_check_events = 'InsertEnter',
  delete_check_events = 'InsertLeave',
}

function M.get_ISO_8601_date()
  return os.date("%Y-%m-%d")
end

function M.get_visual(args, parent)
  if (#parent.snippet.env.LS_SELECT_RAW > 0) then
    return sn(nil, i(1, parent.snippet.env.LS_SELECT_RAW))
  else
    return sn(nil, i(1, ''))
  end
end

return M
