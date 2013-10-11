command! -nargs=0 ConvertToHaml  :call s:DoHaml()

function! s:DoHaml()
  exe "%!html2haml"

  let s:path = expand("%:p")
  if match(s:path,'erb') >= 0
    if exists(":Move")
      let s:bar = substitute(s:path, "erb", "haml", "")
      exe "Move ".s:bar""
    else
      echomsg "Can't rename file without vim-eunuch plugin installed"
    endif
  endif

  silent! call repeat#set("\<Plug>DoHaml", v:count)
endfunction
