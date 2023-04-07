-- RevealInFinder
-- ---------------------------------------------------------------------------

vim.cmd([[
  function! s:RevealInFinder()
    if filereadable(expand("%"))
      let l:command = "xdg-open -R %"
    elseif getftype(expand("%:p:h")) == "dir"
      let l:command = "xdg-open %:p:h"
    else
      let l:command = "xdg-open ."
    endif
      execute ":silent! !" . l:command
    redraw!
  endfunction

  command! Reveal call <SID>RevealInFinder()
]])

vim.keymap.set('n', '<leader>R', ":Reveal<CR>", { noremap = true, desc = '[R]eveal with xdg-open' })

return {
}
