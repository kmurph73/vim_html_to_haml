if !exists(":ConvertHaml")
  command -nargs=1 ConvertHaml  :call s:DoHaml(<q-args>, 0)
endif

function s:DoHaml(from, correct)
  exe "%!html2haml"
  if exists(":Rename")
  else
    echo "Can't rename file without Rename plugin installed"
  end
endfunction
