
nnoremap <ESC> :noh<CR>
nnoremap <C-U>  <PageUp>z.
nnoremap <C-D>  <PageDown>z.

xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)


nnoremap <SPACE> <Nop>
let mapleader = " "
nnoremap <leader>f /<C-R><C-W><CR>Nzz " search for word under cursor
noremap <leader>c "+y
noremap <leader>p "+p
nmap <leader>v :vsplit<CR>
nmap <leader>w <C-W><C-W>
nmap <leader>h :split<CR>
nmap <leader>o :only<CR>

" Align based on next key hit
noremap <leader>a <Plug>(EasyAlign)ip

" Get folding working with vscode neovim plugin
        if(exists("g:vscode"))
            nnoremap zM :call VSCodeNotify('editor.foldAll')<CR>
            nnoremap zR :call VSCodeNotify('editor.unfoldAll')<CR>
            nnoremap zc :call VSCodeNotify('editor.fold')<CR>
            nnoremap zC :call VSCodeNotify('editor.foldRecursively')<CR>
            nnoremap zo :call VSCodeNotify('editor.unfold')<CR>
            nnoremap zO :call VSCodeNotify('editor.unfoldRecursively')<CR>
            nnoremap za :call VSCodeNotify('editor.toggleFold')<CR>

            function! MoveCursor(direction) abort
                if(reg_recording() == '' && reg_executing() == '')
                    return 'g'.a:direction
                else
                    return a:direction
                endif
            endfunction

            nmap <expr> j MoveCursor('j')
            nmap <expr> k MoveCursor('k')
        endif

lua require('vscode-plugins')

