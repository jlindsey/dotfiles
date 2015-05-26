" Core
Plug 'chriskempson/base16-vim'
Plug 'sheerun/vim-polyglot'
Plug 'Valloric/YouCompleteMe', { 'do': './install.sh --clang-completer' }
Plug 'Shougo/vimproc.vim', { 'do': 'make' }
Plug 'scrooloose/syntastic'
Plug 'tpope/vim-sensible'

" Util
Plug 'mattn/webapi-vim' " required for gist.vim
Plug 'mattn/gist-vim'
Plug 'rking/ag.vim'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-projectionist'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-endwise'

" UI
Plug 'kien/rainbow_parentheses.vim'
Plug 'majutsushi/tagbar'
Plug 'bling/vim-airline'
Plug 'christoomey/vim-tmux-navigator'
Plug 'kien/ctrlp.vim'
Plug 'sgur/ctrlp-extensions.vim'
Plug 'tacahiroy/ctrlp-funky'
Plug 'jeetsukumaran/vim-filebeagle'
Plug 'airblade/vim-gitgutter'
Plug 'haya14busa/vim-easymotion'
Plug 'mhinz/vim-startify'

" Language-specific
Plug 'tpope/vim-rails', { 'for': 'ruby' }
Plug 'tpope/vim-bundler', { 'for': 'ruby' }
Plug 'vim-ruby/vim-ruby', { 'for': 'ruby' }
Plug 'slim-template/vim-slim', { 'for': 'slim' }
Plug 'tejr/vim-nagios', { 'for': 'nagios' }
Plug 'guns/vim-clojure-static', { 'for': 'clojure' }
Plug 'guns/vim-clojure-highlight', { 'for': 'clojure' }
Plug 'Glench/Vim-Jinja2-Syntax', { 'for': ['jinja', 'jinja2'] }
Plug 'othree/xml.vim', { 'for': 'xml' }
Plug 'fatih/vim-go', { 'for': 'go' }
Plug 'tpope/vim-leiningen', { 'for': 'clojure' }
Plug 'tpope/vim-fireplace', { 'for': 'clojure' }
Plug 'tpope/vim-classpath', { 'for': ['clojure', 'java'] }

