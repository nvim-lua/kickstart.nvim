return {
  'epwalsh/obsidian.nvim',
  version = "*",
  lazy = true,
  -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
  event = {
  -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
  -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
  -- refer to `:h file-pattern` for more examples
    "BufReadPre $XDG_DOCUMENTS_DIR/obsidian/*/*.md",
    "BufNewFile $XDG_DOCUMENTS_DIR/obsidian/*/*.md",
  },
  dependencies = {
    'nvim-lua/plenary.nvim'
  },
}
