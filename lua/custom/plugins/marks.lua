return {
  'chentoast/marks.nvim',
  keys = function(_, keys)
    local marks = require 'marks'
    return {
      { 'm',          marks.set,        { desc = '[m]arks set' } },
      { 'gn',         marks.next,       { desc = 'marks: [g]o to [n]ext mark' } },
      { '<leader>mp', marks.preview,    { desc = '[m]arks: [p]review' } },
      { '<leader>md', marks.delete_buf, { desc = '[m]arks: [d]elete all marks' } },
      unpack(keys),
    }
  end,
  opts = {},
}
