if filereadable("/etc/vim/vimrc")
  source /etc/vim/vimrc
endif

syntax on

set background=dark
set showcmd
set incsearch
set nocompatible
set viminfo='10,\"100,:20,%,n~/.viminfo

filetype plugin indent on

set smartindent
set autoindent
set expandtab
set shiftwidth=2
set softtabstop=2
set noswapfile
set textwidth=0
set mouse=
set foldmethod=syntax
set nofoldenable

set keymap=russian-jcukenwin
set iminsert=0
set imsearch=0

highlight lCursor guifg=NONE guibg=Cyan

let mapleader = "_"

set cinkeys=0{,0},0),0#,!<Tab>,;,:,o,O,e
set indentkeys=!<Tab>,o,O

map gr :grep <cword>

map <C-o> :cn<CR>
map <C-k> :cp<CR>
map <F2> :make<CR>
map <C-l> :set number!<CR>
map <C-Up> :next<CR>
map <C-Down> :previous<CR>

au BufNewFile,BufRead Done.txt set filetype=todo
au BufRead,BufNewFile *.g set syntax=antlr3
au BufRead,BufNewFile *.cu set filetype=cpp

colorscheme elflord

set grepprg=grep\ -nH\ $*
set autochdir
set pastetoggle=<C-e>
set spelllang=en,ru
set spell

let g:localrc_filename = '.lvimrc'
