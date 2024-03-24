" Main Coloring Configurations
syntax on
color gruvbox
" Enable True Color Support (ensure you're using a 256-color enabled $TERM, e.g. xterm-256color)
set termguicolors
"
"CURSOR SETTINGS
"cursor settings MUST COME AFTER set TERMGUICOLORS
"https://github.com/neovim/neovim/wiki/FAQ#nvim-shows-weird-symbols-2-q-when-changing-modes
"highlight Cursor guifg=blue guibg=blue
"set guicursor=i:block-Cursor-blinkon1
"set guicursor=i:hor
highlight Cursor guifg=blue guibg=blue
autocmd InsertEnter * set cul
autocmd InsertLeave * set nocul

set syn=sh
nnoremap <leader>s :call ToggleRelAbsNumbers()<CR>

"use alt-/ to search within a highlighted visual field
vnoremap <M-/> <Esc>/\%V
"

" Enable automatic formatting of Terraform files on save
let g:terraform_fmt_on_save = 1

"  SETS
"set startdir=$NVIM_PWD

set writebackup
"set patchmode=.orig
set backupcopy=yes
set backupdir=~/Backups

"set number
"set relativenumber

"set statusline=%!MyStatusLine()
"function! MyStatusLine()
set statusline+=%F
let g:netrw_keepdir= 0

" this should open help in a vertical split
set splitright

set formatoptions-=cro
set nopaste
"set tabline
set conceallevel=0
set autochdir
set ignorecase
set smartcase
set tabstop=4 softtabstop=4 shiftwidth=2
set mouse=a
set indentexpr=''
"set expandtab
"set autoindent
"set smarttab
"set incsearch ignorecase smartcase hlsearch
set nohlsearch
"set hlsearch!
set wildmode=longest,list,full wildmenu
set ruler laststatus=2 showcmd showmode
set list listchars=trail:»,tab:»-
set fillchars+=vert:\ 
set wrap breakindent
set encoding=utf-8
set textwidth=0
set nohidden
set title
set undodir=~/.vim/undodir  "I need to set up this directory
set undofile
set incsearch
set backspace
set autoread
set scrolloff=10
set colorcolumn=80
set clipboard=unnamed,unnamedplus

set nocindent
set showbreak=>>
"set nosmartindent
"set noautoindent
"set indentexpr=
"filetype indent off
"filetype plugin indent off
set relativenumber
