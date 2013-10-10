if !exists(":ConvertHaml")
  command -nargs=1 ConvertHaml  :call s:DoHaml(<q-args>, 0)
endif

function s:DoHaml(from, correct)
  exe "%!html2haml"
  if exists(":Rename")
    let s:path = expand("%")
    let s:bar = substitute(s:path, "erb", "haml", "")
    echomsg "TESTING TESTING TESTING TESTING"
    echomsg s:bar
  else
    echomsg "Can't rename file without Rename plugin installed"
  end
endfunction
