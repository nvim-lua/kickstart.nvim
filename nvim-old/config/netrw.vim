

"give syntax highlighting to sh files with zsh syntax highlighting
au BufRead,BufNewFile *.sh setfiletype zsh

" current directory to match netrw browsing
let g:netrw_keepdir= 0


"ends up going to the same directory but doesn't open a file
"function! OpenInTmuxPane()
    "" Get the full path of the current file
    ""let l:filepath = netrw#LocalBrowseCheck("")
	""echo l:filepath
	"let l:filepath = expand('%:p')

    "" Prepare the tmux command
    "let l:tmux_command = "tmux split-window -h 'nvim " . l:filepath . "'"

    "" Call the command
    "call system(l:tmux_command)
"endfunction

