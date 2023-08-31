return {
  {
    "jackMort/ChatGPT.nvim",
    config = function()
      require("chatgpt").setup(
        {
          api_key_cmd = "pass show azure/hypera/oai/token",
          api_host_cmd = "pass show azure/hypera/oai/url",
          predefined_chat_gpt_prompts =
          "https://raw.githubusercontent.com/julianobarbosa/custom-gpt-prompts/main/prompt.csv"
        }
      )
    end,
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim"
    }
  }
}
-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
