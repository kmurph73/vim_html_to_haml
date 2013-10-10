if !exists(":ConvertHaml")
  command -nargs=1 ConvertHaml  :call s:DoHaml(<q-args>, 0)
endif

function s:DoHaml(from, correct)
  exe "%!html2haml"
  if exists(":Rename")
    let s:path = expand("%")
    let s:bar = substitute(s:path, "erb", "haml", "")
    echom "TESTING TESTING TESTING TESTING"
    echom s:bar
  else
    echo "Can't rename file without Rename plugin installed"
  end
endfunction
