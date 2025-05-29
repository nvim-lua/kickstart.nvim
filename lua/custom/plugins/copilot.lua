-- GitHub Copilot configuration
-- https://github.com/github/copilot.vim

return {
  "github/copilot.vim",
  event = "InsertEnter",
  config = function()
    -- Disable default mappings
    vim.g.copilot_no_maps = true
    
    -- Key mappings
    vim.keymap.set('i', '<C-j>', 'copilot#Accept("<CR>")', {
      expr = true,
      replace_keycodes = false,
      silent = true,
    })
    
    -- Additional keymaps for Copilot
    vim.keymap.set('i', '<C-l>', '<Plug>(copilot-accept-word)', { silent = true })
    vim.keymap.set('i', '<C-]>', '<Plug>(copilot-next)', { silent = true })
    -- Changed from <C-[> to <M-[> (Alt+[) to avoid conflicting with Escape
    vim.keymap.set('i', '<M-[>', '<Plug>(copilot-previous)', { silent = true })
    vim.keymap.set('i', '<C-\\>', '<Plug>(copilot-dismiss)', { silent = true })
    
    -- Additional settings
    vim.g.copilot_filetypes = {
      ["*"] = true,
      ["markdown"] = true,
      ["help"] = false,
    }
  end,
}