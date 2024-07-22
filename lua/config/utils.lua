return {
  -- Function to get the current visual selection
  get_visual_selection = function()
    vim.cmd 'noau normal! "vy"'
    local text = vim.fn.getreg 'v'
    vim.fn.setreg('v', {})

    text = string.gsub(text, '\n', '')
    if #text > 0 then
      return text
    else
      return ''
    end
  end,

  -- Function to get the current search query
  get_search_query = function()
    local word_under_cursor = vim.fn.expand '<cword>'
    local visual_selection = require('config.utils').get_visual_selection()

    return visual_selection ~= '' and visual_selection or word_under_cursor
  end,
}
