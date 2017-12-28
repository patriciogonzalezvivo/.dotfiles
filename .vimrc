execute pathogen#infect()

" Theme
let g:enable_bold_font = 1
let g:hybrid_use_Xresources = 1
colorscheme hybrid_reverse

let g:pencil_neutral_headings = 1   " 0=blue (def), 1=normal
"let g:pencil_neutral_code_bg = 1    " 0=gray (def), 1=normal
"let g:pencil_spell_undercurl = 1    " 0=underline, 1=undercurl (def)
"let g:pencil_terminal_italics = 1
"let g:airline_theme = 'hybrid'
"colorscheme pencil

" Options
syntax on
filetype plugin indent on
set nu
set tabstop=2     " a tab is four spaces
set backspace=indent,eol,start " allow backspacing over everything in insert mode
set autoindent    " always set autoindenting on
set copyindent    " copy the previous indentation on autoindenting
set shiftwidth=2  " number of spaces to use for autoindenting
set shiftround    " use multiple of shiftwidth when indenting with '<' and '>'
set incsearch     " show search matches as you type
set expandtab
set shiftwidth=2
set softtabstop=2

" Status bar
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
