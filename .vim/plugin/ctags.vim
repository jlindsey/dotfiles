" ctags
function! RewriteCtags()
  call vimproc#system('git status')
  if vimproc#get_last_status() == 0
    call vimproc#system('git ctags')
  endif
endfunction
set tags=.git/tags,tags
nno <silent> <leader>ct :silent call RewriteCtags()<cr>
au BufWrite * silent call RewriteCtags()

