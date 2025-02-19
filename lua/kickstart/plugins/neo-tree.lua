-- Neo-tree is a Neovim plugin to browse the file system
-- Neo-Tree 是一个浏览文件系统的 Neovim 插件
-- https://github.com/nvim-neo-tree/neo-tree.nvim

-- leader [T]oggle [F]ileTree : 开关文件树
-- 文件树内部 `?` 查看帮助

return {
  'nvim-neo-tree/neo-tree.nvim',
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim', -- 一个 Neovim 的 Lua 工具库，NeoTree 依赖它提供一些实用函数。
    'nvim-tree/nvim-web-devicons', -- 为文件和文件夹提供图标，虽然不是必需的，但推荐安装以增强界面。
    'MunifTanjim/nui.nvim', -- 一个用于构建用户界面的 Lua 库，NeoTree 用它来创建其界面组件。
  },
  cmd = 'Neotree', -- 将在执行 :Neotree 命令时加载
  keys = {
    { '\\', ':Neotree reveal<CR>', desc = 'NeoTree reveal', silent = true },
  },
  opts = {
    filesystem = {
      window = {
        mappings = {
          ['\\'] = 'close_window',
        },
      },
    },
  },
}
