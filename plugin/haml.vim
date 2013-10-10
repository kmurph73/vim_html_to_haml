if !exists(":ConvertHaml")
  command -nargs=1 ConvertHaml  :call s:DoHaml(<q-args>, 0)
endif

function s:DoHaml
  exe "%!html2haml"
endfunction
