-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  "nvim-treesitter/playground",
  "nvim-treesitter/nvim-treesitter-context",
  "theprimeagen/harpoon",
  "mbbill/undotree",
  "windwp/nvim-autopairs",
  "RRethy/vim-illuminate",
  "ahmedkhalf/project.nvim",
  "famiu/bufdelete.nvim",

  {
    "folke/trouble.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
  }
}
