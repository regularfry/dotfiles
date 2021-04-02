version 6.0
if &cp | set nocp | endif
map Q gq
let s:cpo_save=&cpo
set cpo&vim
vmap gx <Plug>NetrwBrowseXVis
nmap gx <Plug>NetrwBrowseX
vnoremap <silent> <Plug>NetrwBrowseXVis :call netrw#BrowseXVis()
nnoremap <silent> <Plug>NetrwBrowseX :call netrw#BrowseX(expand((exists("g:netrw_gx")? g:netrw_gx : '<cfile>')),netrw#CheckIfRemote())
inoremap  u
let &cpo=s:cpo_save
unlet s:cpo_save
set autoread
set backspace=indent,eol,start
set cursorline
set display=truncate
set expandtab
set ts=2
set sw=2
set tw=72
set nocompatible
set incsearch
set langnoremap
set nolangremap
set nomodeline
set mouse-=a
set nrformats=bin,hex
set ruler
set runtimepath=~/.vim,/var/lib/vim/addons,/usr/share/vim/vimfiles,/usr/share/vim/vim81,/usr/share/vim/vimfiles/after,/var/lib/vim/addons/after,~/.vim/after
set scrolloff=5
set showcmd
set suffixes=.bak,~,.swp,.o,.info,.aux,.log,.dvi,.bbl,.blg,.brf,.cb,.ind,.idx,.ilg,.inx,.out,.toc
set ttimeout
set ttimeoutlen=100
set wildmenu
set visualbell
set re=1

set nobackup
set nowritebackup
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp

set wildmode=longest,list
syntax on
filetype on
filetype plugin on
filetype indent on
set undodir=$HOME/.vim/undo
set undolevels=1000
set undoreload=10000


let mapleader=","

cnoremap %% <C-R>=expand('%:h').'/'<cr>
map <leader>e :edit %%
map <leader>v :view %%

" vim: set ft=vim :
