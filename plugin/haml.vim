command! -nargs=1 ConvertHaml  :call s:DoHaml(<q-args>, 0)

function! s:DoHaml(from, correct)
  exe "%!html2haml"
  if exists("Move")
    let s:path = expand("%:p")
    let s:bar = substitute(s:path, "erb", "haml", "")
    exe "Move ".s:bar""
  else
    echomsg "Can't rename file without Rename plugin installed"
  end
endfunction
