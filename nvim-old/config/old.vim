" EasyAlign
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)



"lua require ('init')
"let g:coq_settings = { 'auto_start': v:true }
"
"" vim-pydocstring
let g:pydocstring_doq_path = '~/.config/nvim/env/bin/doq'


"return to previous place in buffer

""" Main Configurations
"filetype plugin indent on

"nmap M <Plug>MoveMotionEndOfLinePlug


" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
"inoremap <silent><expr> <TAB>
      "\ pumvisible() ? "\<C-n>" :
      "\ <SID>check_back_space() ? "\<TAB>" :
      "\ coc#refresh()
"inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
"function! s:check_back_space() abort
  "let col = col('.') - 1
  "return !col || getline('.')[col - 1]  =~# '\s'
"endfunction

" Use <c-space> to trigger completion.
"if has('nvim')
  ""inoremap <silent><expr> <c-space> coc#refresh()
"else
  ""inoremap <silent><expr> <c-@> coc#refresh()
"endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
"inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
			      ""\: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gt <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
"nnoremap <silent> K :call <SID>show_documentation()<CR>
"function! s:show_documentation()
  "if (index(['vim','help'], &filetype) >= 0)
    "execute 'h '.expand('<cword>')
  "elseif (coc#rpc#ready())
    "call CocActionAsync('doHover')
  "else
    "execute '!' . &keywordprg . " " . expand('<cword>')
  "endif
"endfunction

" Highlight the symbol and its references when holding the cursor.
"autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
"nnoremap <leader>9 <Plug>(coc-rename)
"nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
"xmap <leader>=  <Plug>(coc-format-selected)
"nmap <leader>=  <Plug>(coc-format-selected)

"augroup mygroup
  "autocmd!
  """ Setup formatexpr specified filetype(s).
  "autocmd FileType typescript,json,python,yaml setl formatexpr=CocAction('formatSelected')
  """ Update signature help on jump placeholder.
  "autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
"augroup end

"let g:python3_host_prog = "/usr/bin/python3.8"
" coc.vim END

" signify
"let g:signify_sign_add = '│'
"let g:signify_sign_delete = '│'
"let g:signify_sign_change = '│'
"hi DiffDelete guifg=#ff5555 guibg=none


""" Custom Functions

" Trim Whitespaces
"function! TrimWhitespace()
    "let l:save = winsaveview()
    "%s/\\\@<!\s\+$//e
    "call winrestview(l:save)
"endfunction

""" CUSTOM MAPPINGS

"open up a terminal
nmap <leader><C-t> <c-W>s<C-w>j:terminal<CR>:set nonumber<CR><S-a>
nmap <C-t> <C-w>v<C-w>l:terminal<CR>:set nonumber<CR><S-a>

" NerdTree
"nmap <leader>q :NERDTreeToggle<CR>
"nnoremap <leader>e :NERDTreeFocus<CR>
"nnoremap <C-f> :NERDTreeFind<CR>  """open NerdTree current directory"""
"nmap \\ <leader>q
"
"CHADtree
"let &tags = expand("%:p")
"nnoremap <leader>e :CHADopen<CR>
"nnoremap <leader>3 :CHADopen --always-focus<CR>

"nnoremap  <leader>e :Vexplore<CR><C-w>r
"nnoremap  <leader>E :Ex<CR>

"Tagbar
"nmap <leader>w :TagbarToggle<CR>
"nmap \| <leader>w

"Source vim
nmap <leader>R :so ~/.config/nvim/init.vim<CR>


"nmap <leader>t :call TrimWhitespace()<CR>
"nmap <leader>y <C-w>v<C-w>l:HackerNews best<CR>J
"nmap <leader>p <Plug>(pydocstring)

"easy align
xmap <leader>a gaip*
nmap <leader>a gaip*
"nmap <leader>s :Rg<CR>
"
""quick grep search
"all system files -- not useful
"nmap <leader>d :Files<CR>
"nnoremap <silent> <Leader>h: :History:<CR>
"nnoremap <silent> <Leader>h/ :History/<CR>
""latest files -- very useful!
"nnoremap <silent> <Leader>hh :History<CR>
""find file in line
"nmap <leader>z :BLines<CR>
"nmap <leader>H :RainbowParentheses!!<CR>
"nnoremap """ :reg<CR>
"


"nmap <leader>g :Goyo<CR>
"nmap <leader>j :set filetype=journal<CR>
"nmap <leader>l :Limelight!!<CR>
"xmap <leader>l :Limelight!!<CR>
"
"I actually don't like what this does.  It makes the python indent all weird.
"Figure out what plugin would cause indent to be like this, then delete it.
"I still have an annoying indentation error when I'm typing as well.
"autocmd FileType python nmap <leader>x :0,$!~/.config/nvim/env/bin/python -m yapf<CR>


"nmap <Tab> :tabn<CR>
"nmap <S-Tset -g status-left "#{pane_current_path}"ab> :tabp<CR>

" view current buffers and type the number you want to go to.
":bd to delete a single buffer
nnoremap <F5> :buffers<CR>:buffer<Space>

"go back to file tree
"nnoremap <C-e> :Ex

"splits
nnoremap <leader><v> :vsplit<CR>
"nnoremap <leader><C-h> <C-w><s>

"Navigate split buffers
"Normal Mode
nnoremap <C-j> <C-w><C-j>
nnoremap <C-k> <C-W><C-k>
nnoremap <C-l> <C-W><C-l>
nnoremap <C-h> <C-W><C-h>
"Terminal mode
tnoremap <C-j> <C-\><C-n><C-W><C-J>
tnoremap <C-k> <C-\><C-n><C-W><C-K>
tnoremap <C-l> <C-\><C-n><C-W><C-L>
tnoremap <C-h> <C-\><C-n><C-W><C-H>


"add current cursor position to jumplist
nnoremap <Leader>m  :autocmd CursorHold * normal! m'<CR>


""easymotion mappings

"nnoremap <Leader>f <Plug>(easymotion-prefix)f
"nnoremap <Leader>s <Plug>(easymotion-s2)
"nnoremap <Leader>f <Plug>(easymotion-prefix)s
"nnoremap  <c-_> <Plug>(easymotion-sn)
"nnoremap  <Leader>/ <Plug>(easymotion-sn)
"nnoremap <Leader>F <Plug>(easymotion-prefix)F
"nnoremap <Leader>s <Plug>(easymotion-prefix)s


"map  <C-;> <Plug>(easymotion-next)
"map  <C-,> <Plug>(easymotion-prev)" Terminal mode:
"nmap <leader>f <Plug>(easymotion-overwin-f)
"nmap <leader>cf c<Plug>(easymotion-overwin-f)
"nmap s <Plug>(easymotion-overwin-f2)
" Turn on case-insensitive feature
let g:EasyMotion_smartcase = 1

"fuzzy finder
"I have to remap ctrlp's default in order to make my custom command to work
let g:ctrlp_map = '<c-p>'
"open up all files including dotfiles
nnoremap <leader>p :CtrlP /home/ldraney<CR>
set wildignore+=*/.vim/*
"

"Rename tmux window tab after current file with path
"autocmd BufReadPost,FileReadPost,BufNewFile * call system("tmux rename-window " . expand("%:t"))


"tmap <C-w> <Esc><C-w>
"tmap <C-d> <Esc>:q<CR>

"delete
"I don't know what this does...
"autocmd BufWinEnter,WinEnter term://* startinsert
"autocmd BufLeave term://* stopinsert


":!tmux split-window -h; tmux select-pane -L; tmux kill-pane; tmux select-layout even-horizontal<CR>
"OVERCOMING ANNOYING LITTLE VIM THINGS
"nnoremap <CR> <CR><left>
"inoremap <CR> <CR><left>
"nnoremap o o<left>

"highlight search settings
"highlight link Searchlight Incsearch
"hi Search guibg=white guifg=green
"hi Search cterm=NONE ctermfg=grey ctermbg=blue
""" PLUGIN CONFIGURATIONS



