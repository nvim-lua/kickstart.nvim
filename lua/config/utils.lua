-- Function to get the current visual selection
local function get_visual_selection()
  vim.cmd 'noau normal! "vy"'
  local text = vim.fn.getreg 'v'
  vim.fn.setreg('v', {})

  text = string.gsub(text, '\n', '')
  if #text > 0 then
    return text
  else
    return ''
  end
end

-- Function to get the current search query
local function get_search_query()
  local word_under_cursor = vim.fn.expand '<cword>'
  local visual_selection = require('config.utils').get_visual_selection()

  return visual_selection ~= '' and visual_selection or word_under_cursor
end

return {
  get_visual_selection = get_visual_selection,
  get_search_query = get_search_query,
}

