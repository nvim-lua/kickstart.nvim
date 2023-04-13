    
    
-- Unless you are still migrating, remove the deprecated commands from v1.x
vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])

return {
  "nvim-neo-tree/neo-tree.nvim",
  version = "*",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
    "MunifTanjim/nui.nvim",
  },
  config = function ()
    require('neo-tree').setup{
       filesystem = {
          filtered_items = {
            visible = true, -- when true, they will just be displayed differently than normal items
            hide_dotfiles = true,
            hide_hidden = true,
            hide_gitignored = true,
            always_show = { -- remains visible even if other settings would normally hide it
              ".vscode",
              ".jenkinsfiles"
            },
            never_show = {
              ".git",
              ".github"
            }
          }
      }
    }
  end,
  vim.keymap.set('n', '<C-b>', '<Cmd>Neotree toggle<CR>')
}
