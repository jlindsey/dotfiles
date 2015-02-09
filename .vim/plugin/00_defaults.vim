" Filetype and syntax
filetype plugin indent on
syntax on

" remap <leader> to ,
let mapleader = ","

" General settings
set nu " Line numbers
set rnu " Set relative line numbers
set scrolloff=3 " Keep at least 3 lines visible above + below cursor
set cursorline " Highlight the current line
set showmode " Show current file mode
set wildmenu " expand wildcards in commands on <tab>
set wildmode=list:longest
set ttyfast " Force vim to think we're on a fast tty connection (we are)
set visualbell " visual bell instead of audio
set modeline " Allow modelines
set modelines=5
set autoread
set autowrite
set grepprg=ack

" Color
set background=dark
colorscheme base16-monokai

" show hidden characters
set list
set listchars=eol:¬,tab:→\ ,extends:>,precedes:<,trail:…
" Use 2 spaces as tab
set expandtab
set tabstop=2
set shiftwidth=2
" Save backup and swap files in ~/.vim
set swapfile
set backup
set undofile " persist file undo history
set dir=~/.vim/backups
set backupdir=~/.vim/backups
set undodir=~/.vim/backups
au FocusLost * :wa " Autosave
" Searching
set ignorecase
set smartcase " intelligently deal with case-sensative search
set gdefault " default global replace
set incsearch
set showmatch
set hlsearch " Highlight search terms
" Clear current seach with ,<space>
nmap <leader><space> :noh<cr>
" move around between matching bracket groups with <tab>
nnoremap <tab> %
vnoremap <tab> %
" movement
nno <C-h> <C-w>h
nno <C-j> <C-w>j
nno <C-k> <C-w>k
nno <C-l> <C-w>l
nno <up> <nop>
nno <down> <nop>
nno <left> <nop>
nno <right> <nop>
vno <up> <nop>
vno <down> <nop>
vno <left> <nop>
vno <right> <nop>
nno j gj
nno k gk
" working with buffers
set hidden
" ,t Open a new empty buffer
nmap <leader>T :enew<cr>
" ,l Next buffer
nmap <leader>j :bnext<cr>
nno gt :bnext<cr>
" ,h Previous buffer
nmap <leader>k :bprevious<cr>
nno gT :bprevious<cr>
" ,q Close current buffer and move to the previous one
nmap <leader>q :bp <bar> bd #<cr>
" Show all open buffers
nmap <leader>bl :ls<cr>

" Password management
if !has('nvim')
  set cryptmethod=blowfish
  au BufReadPost * if &key != "" | set noswapfile nowritebackup viminfo= nobackup noshelltemp history=0 secure | endif
endif

" reload current vimrc
nmap <leader>R :so $MYVIMRC<cr>

" Clipboard copy
vno <C-c> "+y

" Command Abbreviations
ca !! VimProcBang

