-- Maven Runner - UI for running Maven phases and goals
return {
  "mfussenegger/nvim-jdtls",
  keys = {
    {
      "<leader>m",
      function()
        require("custom.maven").show_menu()
      end,
      desc = "Maven: Show Menu",
      ft = "java",
    },
    {
      "<leader>mr",
      function()
        require("custom.maven").run_last()
      end,
      desc = "Maven: Run Last Command",
      ft = "java",
    },
  },
}
