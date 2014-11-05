function! s:my_cr_function()
  if pumvisible() && neosnippet#expandable()
    return <Plug>(neosnippet_expand) . "\<CR>"
  else
    return "\<CR>"
  endif
endfunction

imap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
smap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
xmap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>

imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
      \ "\<Plug>(neosnippet_expand_or_jump)"
      \: pumvisible() ? "\<C-n>" : "\<TAB>"

smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
      \ "\<Plug>(neosnippet_expand_or_jump)"
      \: "\<TAB>"

if has('conceal')
  set conceallevel=2 concealcursor=i
endif

