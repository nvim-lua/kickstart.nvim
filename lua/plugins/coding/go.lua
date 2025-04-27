---@diagnostic disable: undefined-global
return {
  "ray-x/go.nvim",
  dependencies = {
    "ray-x/guihua.lua",
    "neovim/nvim-lspconfig",
    "nvim-treesitter/nvim-treesitter",
  },
  config = function()
    require("go").setup({
      lsp_cfg = false,
      gofmt = false,
      goimports = false,
      linter = "golangci-lint",
      test_runner = "go",
      test_flags = { "-v" },
      dap_debug = true,
      dap_debug_gui = true,
    })
  end,
  event = { "CmdlineEnter" },
  ft = { "go", "gomod" },
  build = ':lua require("go.install").update_all_sync()',
}
