return {
  'kylechui/nvim-surround',
  config = function()
    require('nvim-surround').setup {
      keymaps = {
        insert = '<C-g>s',
        insert_line = '<C-g>S',
        normal = 'ys',
        normal_cur = 'yss',
        normal_line = 'yS',
        normal_cur_line = 'ySS',
        visual = 'vs',
        visual_line = 'vS',
        delete = 'ds',
        change = 'cs',
        change_line = 'cS',
      },
    }
  end,
}
