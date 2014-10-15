" Non-vi compat
set nocp
scriptencoding utf-8
set encoding=utf-8

"" Vundle
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
source $HOME/.vim/packages.vim
call vundle#end()

" Let's go
filetype plugin indent on
syntax on

