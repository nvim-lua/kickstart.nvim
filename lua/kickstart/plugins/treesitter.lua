return {
  -- Highlight, edit, and navigate code
  "nvim-treesitter/nvim-treesitter",
  config = function()
    local filetypes = {
      "angular",
      "bash",
      "c",
      "css",
      "diff",
      "html",
      "lua",
      "luadoc",
      "markdown",
      "markdown_inline",
      "query",
      "typescript",
      "vim",
      "vimdoc",
      "python",
    }
    require("nvim-treesitter").install(filetypes)
    vim.api.nvim_create_autocmd("FileType", {
      pattern = filetypes,
      callback = function()
        vim.treesitter.start()
      end,
    })
  end,
}
