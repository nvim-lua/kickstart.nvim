"function! TmuxSplitEvenHorizontal()
  "let filepath = expand('%:p')
  "if !empty(filepath)
    "let tmux_command = "tmux split-window -h -c '#{pane_current_path}' 'nvim ".filepath."' && tmux select-layout even-horizontal"
    "call system(tmux_command)
  "endif
"endfunction

function! TmuxSplitEvenHorizontal()
  let filepath = expand('%:p')
  if !empty(filepath)
    let tmux_command = "tmux split-window -h -c '".expand('%:p:h')."' && tmux send-keys -t '.tmux.active-pane' 'nvim ".shellescape(filepath)."' Enter && tmux select-layout even-horizontal"
    call system(tmux_command)
  endif
endfunction

nnoremap <leader>th :call TmuxSplitEvenHorizontal()<CR>

function! ToggleRelAbsNumbers()
	set relativenumber
        set number
    else
        set norelativenumber
        set nonumber
    endif
endfunction


" Functions and autocmds to run whenever changing colorschemes
function! TransparentBackground()
    highlight Normal guibg=NONE ctermbg=NONE
    highlight LineNr guibg=NONE ctermbg=NONE
    set fillchars+=vert:\│
    highlight VertSplit gui=NONE guibg=NONE guifg=#444444 cterm=NONE ctermbg=NONE ctermfg=gray
endfunction

autocmd ColorScheme * call TransparentBackground() " uncomment if you are using a translucent terminal and you want nvim to use that


function! ToggleLineNumbers()
  if &relativenumber
    set norelativenumber
	set number
  else
    set relativenumber
  endif
endfunction

nnoremap <leader><leader>n :call ToggleLineNumbers()<CR>

