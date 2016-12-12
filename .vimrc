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
set shiftwidth=4
set softtabstop=4
set noswapfile
set textwidth=0
set mouse=
set foldmethod=syntax
set nofoldenable

set keymap=russian-jcukenwin
set iminsert=0
set imsearch=0

highlight lCursor guifg=NONE guibg=Cyan

set cinkeys=0{,0},0),0#,!<Tab>,;,:,o,O,e
set indentkeys=!<Tab>,o,O

map gr :grep <cword> %:p:h
set statusline+=%F\ :+%l\ %c

map <C-o> :cn<CR>
map <C-k> :cp<CR>
map <C-l> :set number!<CR>
map <C-Up> :next<CR>
map <C-Down> :previous<CR>

au BufRead,BufNewFile *.g set syntax=antlr3
au BufRead,BufNewFile *.cu set filetype=cpp
au BufRead,BufNewFile *.txt set filetype=todo
au BufRead,BufNewFile *.txt set ff=unix

colorscheme elflord

set grepprg=grep\ -nH\ $*
set pastetoggle=<C-e>
set spelllang=en,ru
set hlsearch

set guioptions-=m  "remove menu bar
set guioptions-=T  "remove toolbar
set guioptions-=r  "remove right-hand scroll bar
set guicursor+=a:blinkon0

au BufEnter *.c call matchadd('ErrorMsg', '\%>80v.\+', -1)
au BufEnter *.cpp call matchadd('ErrorMsg', '\%>80v.\+', -1)
au BufEnter *.h call matchadd('ErrorMsg', '\%>80v.\+', -1)

let Tlist_WinWidth = 90
set complete-=i

set cinoptions=g0:0(0

set wrap
set noautoread
