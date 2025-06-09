-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  -- Load all plugin files in the custom/plugins directory
  { import = "custom.plugins.copilot" },
  { import = "custom.plugins.copilot-chat" },
  { import = "custom.plugins.tab_keymaps" },
  { import = "custom.plugins.code_runner" },
  { import = "custom.plugins.sniprun" },
  { import = "custom.plugins.harpoon" },
  { import = "custom.plugins.lazygit" },
  { import = "custom.plugins.toggleterm" },
  { import = "custom.plugins.comment" },
  { import = "custom.plugins.leetcode" },
  -- { import = "custom.plugins.telescope_fix" },
  { import = "custom.plugins.catppuccin" },
}
