syntax on
set background=dark
set showcmd
set incsearch
set nocompatible

set viminfo='10,\"100,:20,%,n~/.viminfo

set autochdir


filetype plugin indent on
if filereadable("/etc/vim/vimrc")
  source /etc/vim/vimrc
endif
au BufRead,BufNewFile *.g set syntax=antlr3
nmap <F9> :w<CR>:!aspell -l en -e -c %<CR>:e<CR>

map gr :grep <cword>

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


map <C-o> :cn<CR>
map <C-n> :set number!<CR>
map <C-p> :cp<CR>
map <F1> :tag! 
map <F2> :w<CR>:make<CR>
imap <F2> <ESC><F2>
map <F3> :noh<CR>
set pastetoggle=<C-e>

set spelllang=en,ru

map <F7> :set spell!<CR>
map <F5> :edit<CR>
imap <F5> <C-O>:edit<CR>

map <C-Up> :next<CR>
map <C-Down> :previous<CR>

function! SwitchToC()
  set cindent
  set comments=sl:/*,elx:*/
endfunction

function! SwitchToTex()
  setlocal spell
  colorscheme slate
endfunction

au! BufRead,BufNewFile *.cu set filetype=cpp
au! BufRead,BufNewFile *.tex call SwitchToTex ()
au! BufRead,BufNewFile *.kayrick-tools set ft=sh
autocmd BufEnter *.c call SwitchToC ()
let g:miniBufExplMapWindowNavVim = 1
let g:miniBufExplMapWindowNavArrows = 1
let g:miniBufExplMapCTabSwitchBufs = 1
let g:miniBufExplModSelTarget = 1 


if &t_Co > 2 || has("gui_running")
  syntax on
  set background=dark
  hi Comment    term=bold ctermfg=Cyan
  hi LineNr     term=bold ctermfg=Cyan
  hi IncSearch  term=underline cterm=bold,underline ctermfg=none ctermbg=none
  hi Search     term=underline cterm=underline ctermfg=none ctermbg=none
  hi Pmenu      term=NONE cterm=NONE ctermfg=7 ctermbg=5 gui=NONE guifg=White guibg=DarkGray
  hi PmenuSel   term=NONE cterm=NONE ctermfg=0 ctermbg=7 gui=NONE guifg=Black guibg=LightGray
  hi PmenuSbar  term=NONE cterm=NONE ctermfg=7 ctermbg=0 gui=NONE guifg=White guibg=Black
  hi PmenuThumb term=NONE cterm=NONE ctermfg=0 ctermbg=7 gui=NONE guifg=Black guibg=White
  hi lCursor guibg=#ffffff
  set hlsearch
  let c_space_errors=1
endif

colorscheme elflord

if has("gui_running")
  colorscheme koehler
  set gfn=Terminus\ 12
  set guioptions=
  let &guicursor = &guicursor . ",a:blinkon0"
endif

function Translate ()
   let  a=getline('.')
   let co=col('.')-1
   let starts=strridx(a," ",co)
   let ends = stridx(a," ",co)
   if ends==-1
       let ends=strlen(a)
   endif
   let res = strpart(a,starts+1,ends-starts)
   let cmds = "sdcv -n -u quick_russian-english -u quick_english-russian " . res
   let out = system(cmds)
   echo out
endfunction



map <F8>  :call Translate ()<cr>
map <F10> :execute "grep " . expand("<cword>") . 

filetype plugin on
set grepprg=grep\ -nH\ $*
filetype indent on
let g:tex_flavor='latex'

inoremap <F4> <C-O>za
nnoremap <F4> za
onoremap <F4> <C-C>za
vnoremap <F4> zf

inoremap <F6> <C-O>zA
nnoremap <F6> zA
onoremap <F6> <C-C>zA
vnoremap <F6> zF

inoremap <F11> <C-O>zR
nnoremap <F11> zR
onoremap <F11> <C-C>zR
vnoremap <F11> zR


inoremap <F12> <C-O>zM
nnoremap <F12> zM
onoremap <F12> <C-C>zM
vnoremap <F12> zM

function! ResCur()
  if line("'\"") <= line("$")
    normal! g`"
    return 1
  endif
endfunction

augroup resCur
  autocmd!
  autocmd BufWinEnter * call ResCur()
augroup END
