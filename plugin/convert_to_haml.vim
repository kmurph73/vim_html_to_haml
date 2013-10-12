if exists("g:loaded_convert_to_haml") || &cp || v:version < 700
  finish
endif

let g:loaded_convert_to_haml = 1

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

  " vim repeat support
  " doesn't work
  " silent! call repeat#set("\<Plug>DoHaml")
endfunction
