set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" VUNDLE
Plugin 'VundleVim/Vundle.vim'

" THEME
Plugin 'bling/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'kaicataldo/material.vim'

" Sublime-like
Plugin 'terryma/vim-multiple-cursors'

" FILE formats
Plugin 'tpope/vim-markdown'

" Coding
Plugin 'scrooloose/nerdtree'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'tomtom/tcomment_vim'
Plugin 'airblade/vim-gitgutter'
Plugin 'tikhomirov/vim-glsl'
" Plugin 'beyondmarc/glsl.vim'

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


if (has('nvim'))
    let $NVIM_TUI_ENABLE_TRUE_COLOR = 1
endif

if (has('termguicolors'))
    set termguicolors
else
    set encoding=utf-8
    set term=xterm-256color
endif

" Theme
" set background=dark

let g:enable_bold_font = 1
let g:hybrid_use_Xresources = 1
let g:hybrid_transparent_background = 1

" Air-line
let g:airline_theme = 'hybrid'

" THEME
let g:material_theme_style = 'ocean'
colorscheme material


let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

" unicode symbols
let g:airline_left_sep = ''
let g:airline_right_sep = ''
let g:airline_symbols.linenr = ' '
" let g:airline_symbols.branch = '⎇'
let g:airline_symbols.branch = '<'
"let g:airline_symbols.paste = 'ρ'
"let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '|'
"let g:airline_symbols.whitespace = 'Ξ'
let g:airline_symbols.whitespace = '.'

" airline symbols
" let g:airline_left_sep = ''
" let g:airline_left_alt_sep = ''
" let g:airline_right_sep = ''
" let g:airline_right_alt_sep = ''
" let g:airline_symbols.branch = ''
" let g:airline_symbols.readonly = ''
" let g:airline_symbols.linenr = ''

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

