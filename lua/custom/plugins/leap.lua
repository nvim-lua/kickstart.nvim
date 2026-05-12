-- flash.nvim: smarter `s`/`S` jump with treesitter-aware selection and
-- remote operations (e.g. `yr<motion>` to yank a remote region).
return {
  'folke/flash.nvim',
  event = 'VeryLazy',
  opts = {},
  keys = {
    { 's', mode = { 'n', 'x', 'o' }, function() require('flash').jump() end,              desc = 'Flash' },
    { 'S', mode = { 'n', 'x', 'o' }, function() require('flash').treesitter() end,        desc = 'Flash Treesitter' },
    { 'r', mode = 'o',               function() require('flash').remote() end,            desc = 'Remote Flash' },
    { 'R', mode = { 'o', 'x' },      function() require('flash').treesitter_search() end, desc = 'Treesitter Search' },
  },
}
