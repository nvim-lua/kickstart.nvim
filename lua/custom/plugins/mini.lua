-- Mini 全家桶
return {
  'echasnovski/mini.nvim',
  config = function()
    -- 可视化显示缩进范围
    require('mini.indentscope').setup()

    -- 自动配对
    require('mini.pairs').setup()

    -- 启动界面
    require('mini.starter').setup()

    -- 小地图
    local map = require 'mini.map'

    map.setup {
      integrations = {
        map.gen_integration.builtin_search(),
        map.gen_integration.gitsigns(),
        map.gen_integration.diagnostic(),
      },
      symbols = {
        encode = map.gen_encode_symbols.dot '4x2',
      },
    }

    vim.keymap.set('n', '<Leader>tm', map.toggle, { desc = '[T]oggle [M]ap' })

    vim.cmd [[autocmd User MiniStarterOpened
    \ lua vim.keymap.set(
    \   'n',
    \   '<CR>',
    \   '<Cmd>lua MiniStarter.eval_current_item(); MiniMap.open()<CR>',
    \   { buffer = true }
    \ )]]
  end,
}
