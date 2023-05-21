require('rose-pine').setup {
  disable_background = true,
}

function ColorMyPencils(color)
  color = color or 'rose-pine'
  vim.cmd.colorscheme(color)

  vim.api.nvim_set_hl(0, 'Normal', { bg = 'none' })
  vim.api.nvim_set_hl(0, 'NormalFloat', { bg = 'none' })
end

ColorMyPencils()

vim.cmd 'autocmd BufEnter * ThematicRandom'
