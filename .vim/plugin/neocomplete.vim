" Neocomplete
set completeopt-=preview

let g:neocomplete#enable_at_startup = 1
let g:neocomplete#force_overwrite_completefunc = 0
let g:neocomplete#enable_prefetch = 1
let g:neocomplete#enable_omni_fallback = 1
let g:neocomplete#use_vimproc = 1
let g:neocomplete#enable_smart_case = 1
let g:neocomplete#min_keyword_length = 3
let g:rubycomplete_buffer_loading = 1
let g:rubycomplete_classes_in_global = 1
let g:rubycomplete_rails = 1
let g:neocomplete#ctags_command = 'git ctags'
let g:neocomplete#enable_auto_close_preview = 1
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return neocomplete#close_popup() . "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplete#close_popup()
inoremap <expr><C-e>  neocomplete#cancel_popup()

" Enable omni completion.
autocmd FileType css,scss,less setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
autocmd FileType ruby,eruby setlocal omnifunc=syntaxcomplete#Complete

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif
let g:neocomplete#sources#omni#input_patterns.cpp =
      \ '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'
let g:neocomplete#sources#omni#input_patterns.c =
      \ '[^.[:digit:] *\t]\%(\.\|->\)\%(\h\w*\)\?'
if !exists('g:neocomplete#force_omni_input_patterns')
  let g:neocomplete#force_omni_input_patterns = {}
endif
let g:neocomplete#force_omni_input_patterns.ruby =
      \ '[^. *\t]\.\w*\|\h\w*::'

