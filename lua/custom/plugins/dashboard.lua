return {
    {
        'nvimdev/dashboard-nvim',
        event = 'VimEnter',
        config = function()
            require('dashboard').setup {
 --               config = {
 --                   shortcut = {
 --                       -- action can be a function type
 --                       { desc = string, group = 'highlight group', key = 'shortcut key', action = 'action when you press key' },
 --                   },
 --                   packages = { enable = true }, -- show how many plugins neovim loaded
 --                   -- limit how many projects list, action when you press key or enter it will run this action.
 --                   -- action can be a functino type, e.g.
 --                   -- action = func(path) vim.cmd('Telescope find_files cwd=' .. path) end
 --                   project = { enable = true, limit = 8, icon = 'your icon', label = '', action = 'Telescope find_files cwd=' },
 --                   mru = { limit = 10, icon = 'your icon', label = '', cwd_only = false },
 --                   footer = {},             -- footer
 --               }
            }
        end,
        dependencies = { { 'nvim-tree/nvim-web-devicons' } }
    }
}
