if !exists(":toHaml")
  command -nargs=1 ToHaml  :call s:toHaml(<q-args>, 0)
endif

function s:toHaml(from, correct)
  exe "%!html2haml "
endfunction
