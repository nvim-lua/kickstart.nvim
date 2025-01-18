return {
  "kawre/leetcode.nvim",
  build = ":TSUpdate html", -- if you have `nvim-treesitter` installed
  dependencies = {
    "nvim-telescope/telescope.nvim",
    -- "ibhagwan/fzf-lua",
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
  },
  opts = {
    lang = "python3",
    console = {
      open_on_runcode = true, ---@type boolean

      dir = "row",

      size = {
        width = "90%",
        height = "75%",
      },

      result = {
        size = "60%",
      },

      testcase = {
        virt_text = true,
        size = "40%",
      },
    },

    description = {
      position = "left",
      width = "27%",
      show_stats = true,
    },
  },
}
