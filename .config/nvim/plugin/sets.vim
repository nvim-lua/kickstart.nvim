
set rtp+=/usr/local/opt/fzf
set background=dark
set nowrap
set textwidth=79
set formatoptions=qrn1

set ignorecase
set smartcase
set gdefault

set incsearch
set showmatch
set hlsearch
set nocompatible
set exrc

set modelines=0
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab

set encoding=utf-8
set scrolloff=8
set autoindent
set smartindent
set showmode
set showcmd
set cmdheight=2
set hidden
set wildmenu
set wildmode=list:longest
set visualbell
set cursorline
set ttyfast
set ruler
set backspace=indent,eol,start
set laststatus=2
set relativenumber
set nu
set noswapfile
set nobackup
set nowritebackup
set undodir=~/.config/nvim/undodir
set undofile
set signcolumn=yes
set colorcolumn=80

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

set grepprg=rg\ --vimgrep\ --smart-case\ --follow

