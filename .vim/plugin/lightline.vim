set guifont=Source\ Code\ Pro\ for\ Powerline\ 10
set noshowmode

let g:lightline = {
      \ 'mode_map': { 'c': 'NORMAL' },
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'readonly', 'modified' ], [ 'bufferline' ] ],
      \   'right': [ [ 'syntasitc', 'lineinfo' ], [ 'percent' ], [ 'fileformat', 'fileencoding', 'filetype'] ]
      \ },
      \ 'component': {
      \   'bufferline': '%{bufferline#refresh_status()}%{MyBufferline()[0]}'.
      \                 '%#TabLineSel# %{g:bufferline_status_info.current}'.
      \                 '%#LightLineLeft_active_2#%{MyBufferline()[2]}'
      \ },
      \ 'component_function': {
      \   'modified': 'MyModified',
      \   'readonly': 'MyReadonly',
      \   'fugitive': 'MyFugitive',
      \   'filename': 'MyFilename',
      \   'fileformat': 'MyFileformat',
      \   'filetype': 'MyFiletype',
      \   'fileencoding': 'MyFileencoding',
      \   'mode': 'MyMode',
      \ },
      \ 'component_expand': { 'syntastic': 'SyntasticStatuslineFlag' },
      \ 'component_type': { 'syntastic': 'error' },
      \ 'separator': { 'left': '', 'right': '' },
      \ 'subseparator': { 'left': '∣', 'right': '∣' },
      \ }
"      \ 'separator': { 'left': '', 'right': '' },
"      \ 'subseparator': { 'left': '', 'right': '' }

function! MyModified()
  return &ft =~ 'help\|unite\|vimshell' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! MyReadonly()
  return &ft !~? 'help\|unite\|vimshell' && &readonly ? '' : ''
endfunction

function! MyFilename()
  return ('' != MyReadonly() ? MyReadonly() . ' ' : '') .
        \ (&ft == 'unite' ? unite#get_status_string() :
        \  &ft == 'vimshell' ? vimshell#get_status_string() :
        \ '' != expand('%:t') ? expand('%:t') : '[No Name]') .
        \ ('' != MyModified() ? ' ' . MyModified() : '')
endfunction

function! MyBufferline()
    call bufferline#refresh_status()
    let b = g:bufferline_status_info.before
    let c = g:bufferline_status_info.current
    let a = g:bufferline_status_info.after
    let alen = strlen(a)
    let blen = strlen(b)
    let clen = strlen(c)
    let w = winwidth(0) * 4 / 10
    if w < alen+blen+clen
        let whalf = (w - strlen(c)) / 2
        let aa = alen > whalf && blen > whalf ? a[:whalf] : alen + blen < w - clen || alen < whalf ? a : a[:(w - clen - blen)]
        let bb = alen > whalf && blen > whalf ? b[-(whalf):] : alen + blen < w - clen || blen < whalf ? b : b[-(w - clen - alen):]
        return [(strlen(bb) < strlen(b) ? '...' : '') . bb, c, aa . (strlen(aa) < strlen(a) ? '...' : '')]
    else
        return [b, c, a]
    endif
endfunction

function! MyFugitive()
  if &ft !~? 'unite\|help\|vimshell' && exists("*fugitive#head")
    let _ = fugitive#head()
    return strlen(_) ? "\ue0a0 "._ : ''
  endif
  return ''
endfunction

function! MyFileformat()
  return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! MyFiletype()
  return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
endfunction

function! MyFileencoding()
  return winwidth(0) > 70 ? (strlen(&fenc) ? &fenc : &enc) : ''
endfunction

function! MyMode()
  return winwidth(0) > 60 ? lightline#mode() : ''
endfunction

