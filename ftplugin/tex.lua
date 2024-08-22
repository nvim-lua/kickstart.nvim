-- Keybinding to compile LaTeX to PDF using xelatex with latexmk and output to the "output" directory
vim.keymap.set('n', '<leader>ll', ':!mkdir -p output && latexmk -pdf -xelatex -output-directory=output -synctex=1 %<CR>',
  {
    desc = 'Compile LaTeX to PDF using xelatex with SyncTeX in the output directory',
    noremap = true,
    silent = true
  })

-- Keybinding to view the compiled PDF in Zathura from the output directory
vim.keymap.set('n', '<leader>lv', function()
  local pdf_path = vim.fn.expand('%:p:h') .. '/output/' .. vim.fn.expand('%:t:r') .. '.pdf'
  vim.cmd(':silent !nohup zathura ' .. pdf_path .. ' >/dev/null 2>&1 &')
end, {
  desc = 'View PDF in Zathura from the output directory',
  noremap = true,
  silent = true
})

-- Custom surroundings for LaTeX
vim.g.surround_110 = "\\begin{\r}\n\\end{\r}" -- map `yssn` for \begin{} \end{}

