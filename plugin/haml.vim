!exists(":toHaml")
  command -nargs=1  toHaml  :call s:toHaml(<q-args>, 0)
endif

function s:toHaml(from, correct)
  exe "%!html2haml "
endfunction
