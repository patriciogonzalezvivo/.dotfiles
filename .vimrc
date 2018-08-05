set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" VUNDLE
Plugin 'VundleVim/Vundle.vim'

" THEME
Plugin 'bling/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'NLKNguyen/papercolor-theme'

" Sublime-like
Plugin 'terryma/vim-multiple-cursors'

" FILE formats
Plugin 'tpope/vim-markdown'

" Coding
Plugin 'scrooloose/nerdtree'
"Plugin 'scrooloose/nerdcommenter'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'tomtom/tcomment_vim'
Plugin 'airblade/vim-gitgutter'
Plugin 'tikhomirov/vim-glsl'
"Plugin 'beyondmarc/glsl.vim'

call vundle#end()

" Options
filetype plugin indent on
syntax on
set nu
set t_Co=256                    " This is may or may not needed.
set tabstop=4                   " a tab is four spaces
set backspace=indent,eol,start  " allow backspacing over everything in insert mode
set autoindent                  " always set autoindenting on
set copyindent                  " copy the previous indentation on autoindenting
set shiftwidth=4                " number of spaces to use for autoindenting
set shiftround                  " use multiple of shiftwidth when indenting with '<' and '>'
set incsearch                   " show search matches as you type
set expandtab

" Theme
set background=dark
colorscheme PaperColor
let g:airline_theme='papercolor'

" Status bar
set number
set laststatus=2

" Give a shortcut key to NERD Tree
map <F2> :NERDTreeToggle<CR>

" NerdCommenter
filetype plugin on
let g:NERDCustomDelimiters = {
    \ 'glsl' : { 'left': '//', 'leftAlt': '/', 'rightAlt': '/' },
    \ 'vs' : { 'left': '//', 'leftAlt': '/', 'rightAlt': '/' },
    \ 'fs' : { 'left': '//', 'leftAlt': '/', 'rightAlt': '/' },
    \ 'vect' : { 'left': '//', 'leftAlt': '/', 'rightAlt': '/' },
    \ 'frag' : { 'left': '//', 'leftAlt': '/', 'rightAlt': '/' },
    \ }
