let g:ctrlp_extensions = ['menu', 'yankring', 'funky']
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'

" ctrlp-funky
nnoremap <Leader>n :CtrlPFunky<cr>
let g:ctrlp_funky_syntax_highlight = 1
let g:ctrlp_funky_matchtype = 'path'

nnoremap <Leader>m :CtrlPMenu<cr>

