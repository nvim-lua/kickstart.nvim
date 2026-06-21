-- VimTeX: LaTeX support (compile, view, errors)
-- https://github.com/lervag/vimtex
--
-- Ported from the user's lazy.nvim spec (lazy = false) to this base's `vim.pack`
-- imperative style. VimTeX reads its `vim.g.vimtex_*` settings when it is sourced,
-- so we set them BEFORE `vim.pack.add` loads the plugin (the equivalent of the old
-- lazy `init` hook).

-- Viewer settings (adjust based on your PDF viewer)
vim.g.vimtex_view_method = 'zathura' -- Use 'skim' on macOS, 'sumatra' on Windows, etc.

-- Compiler settings
vim.g.vimtex_compiler_method = 'latexmk' -- Default compiler backend

-- Optional: Disable some features if you don't need them
vim.g.vimtex_quickfix_enabled = 1 -- Enable quickfix window for errors
vim.g.vimtex_syntax_enabled = 1 -- Syntax highlighting (works with Tree-sitter too)

-- Set TeX flavor (usually not needed, but good to know)
vim.g.tex_flavor = 'latex'

vim.pack.add { 'https://github.com/lervag/vimtex' }

-- LaTeX keymaps (which-key group label is defined in init.lua: `<leader>l` = [L]aTeX)
vim.keymap.set('n', '<leader>ll', '<cmd>VimtexCompile<CR>', { desc = 'Compile LaTeX' })
vim.keymap.set('n', '<leader>lv', '<cmd>VimtexView<CR>', { desc = 'View PDF' })
vim.keymap.set('n', '<leader>le', '<cmd>VimtexErrors<CR>', { desc = 'Show Errors' })
