if !exists(":ConvertHaml")
  command -nargs=1 ConvertHaml  :call s:toHaml(<q-args>, 0)
endif

function s:toHaml(from, correct)
  exe "%!html2haml "
endfunction
