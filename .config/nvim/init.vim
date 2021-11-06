let mapleader = " "
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

nnoremap / /\v
vnoremap / /\v
nnoremap <leader>/ :Rg<space>
vnoremap <leader>/ :Rg<space>
nnoremap <leader>` :noh<cr>

" No Cheating
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>

" No weird line jumps
nnoremap j gj
nnoremap k gk

" FZF Bindings
noremap <leader><leader> :GFiles<CR>
noremap <leader>pf :Files<CR>
nnoremap <leader>C        :Colors<CR>
nnoremap <leader>B        :Buffers<CR>
nnoremap <leader>fl       :Lines<CR>
noremap <leader>m        :History<CR>
noremap <leader>/        :Rg<space>

" Use fuzzy completion relative filepaths across directory
imap <expr> <c-x><c-f> fzf#vim#complete#path('git ls-files $(git rev-parse --show-toplevel)')

" Better command history with q:
command! CmdHist call fzf#vim#command_history({'right': '40'})
nnoremap q: :CmdHist<CR>

" Better search history
command! QHist call fzf#vim#search_history({'right': '40'})
nnoremap q/ :QHist<CR>

command! -bang -nargs=* Ack call fzf#vim#ag(<q-args>, {'down': '40%', 'options': --no-color'})

inoremap <F1> <ESC>
nnoremap <F1> <ESC>
vnoremap <F1> <ESC>

inoremap hh <ESC>

" - Avoid using standard Vim directory names like 'plugin'
call plug#begin()

Plug 'gruvbox-community/gruvbox'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'stsewd/fzf-checkout.vim'
Plug 'leafgarland/typescript-vim'
Plug 'airblade/vim-gitgutter'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'tpope/vim-rhubarb'
Plug 'thesis/vim-solidity'
Plug 'vim-test/vim-test'

" Initialize plugin system
call plug#end()

syntax on
let g:gruvbox_contrast_dark = 'hard'
let g:gruvbox_italic=1
let g:gruvbox_invert_selection='0'
set termguicolors
set background=dark

augroup RAH_CODES
    autocmd!
    autocmd vimenter * ++nested colorscheme gruvbox
augroup END

"let g:netrw_banner = 0
"let g:netrw_liststyle = 3
"let g:netrw_browse_split = 4
"let g:netrw_altv = 1
"let g:netrw_winsize = 25
"augroup ProjectDrawer
"  autocmd!
"  autocmd VimEnter * :Vexplore
"augroup END
nnoremap <leader>pv :Vex<CR>

let g:airline_powerline_fonts = 1
let g:airline#extensions#tGabline#enabled = 1

" Completion
set completeopt=menuone,noinsert,noselect
let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']

" Git Fugitive
nnoremap <leader>gs :G<CR>
nnoremap <leader>gh :diffget //3<CR>
nnoremap <leader>gu :diffget //2<CR>
nnoremap <leader>gc :GCheckout<CR>
nnoremap <leader>ga :G add %:p<CR><CR>
nnoremap <leader>gc :G commit -v -q<CR>
nnoremap <leader>gt :G commit -v -q %:p<CR>
nnoremap <leader>gca :G commit --amend --no-edit<CR>
nnoremap <leader>gd :Gdiff<CR>
nnoremap <leader>ge :Gedit<CR>
nnoremap <leader>gr :Gread<CR>
nnoremap <leader>gw :Gwrite<CR><CR>
nnoremap <leader>gl :silent! Glog<CR>:bot copen<CR>
nnoremap <leader>gp :Ggrep<Space>
nnoremap <leader>gm :Gmove<Space>
nnoremap <leader>gb :G branch<Space>
nnoremap <leader>go :G checkout<Space>
nnoremap <leader>gps :Dispatch! git push<CR>
nnoremap <leader>gpl :Dispatch! git pull<CR>

" Copy to system clipboard
vnoremap <leader>y "*y
nnoremap <leader>y "*<y

" Move buffers
nmap sp :bprev<Return>
nmap sn :bnext<Return>
