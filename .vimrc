" Non-vi compat
set nocp
scriptencoding utf-8
set encoding=utf-8

"" vim-plug
call plug#begin('~/.vim/bundle')
source $HOME/.vim/packages.vim
call plug#end()

" Let's go
filetype plugin indent on
syntax on

