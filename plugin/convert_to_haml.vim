"if exists("g:loaded_convert_to_haml") || &cp || v:version < 700
"
"  finish
"endif
"
"let g:loaded_convert_to_haml = 1

command! -nargs=0 ConvertY  :call s:DoHaml()

function! s:DoHaml()
  exe "%!html2haml -e"

  let s:path = expand("%:p")
  if match(s:path,'erb') >= 0
    if exists(":Move")
      let s:bar = substitute(s:path, "erb", "haml", "")
      exe "Move ".s:bar""
    else
      echomsg "Can't rename file without vim-eunuch plugin installed"
    endif
  endif

  write
  e!

  " vim repeat support
  " doesn't work
  " silent! call repeat#set("\<Plug>DoHaml")
endfunction

" function jacked from
" http://stackoverflow.com/a/6271254/548170
function! s:Get_visual_selection()
  let [lnum1, col1] = getpos("'<")[1:2]
  let [lnum2, col2] = getpos("'>")[1:2]
  let lines = getline(lnum1, lnum2)
  let lines[-1] = lines[-1][: col2 - (&selection == 'inclusive' ? 1 : 2)]
  let lines[0] = lines[0][col1 - 1:]
  return join(lines, "\n")
endfunction

function! s:Last_line_is_selected()
  let s:lnum = getpos("'>")[1]
  return s:lnum == (line("$") + 1)
endfunction

function! s:Strip(input_string)
    return substitute(a:input_string, '^\s*\(.\{-}\)\n\s*$', '\1', '')
endfunction

function! s:CheckMode()
  echom mode()
endfunction

function! s:opfunc(type,...)
  let s:Fn = function("s:Get_visual_selection")
  let s:visual_selection = call(s:Fn, [])
  let s:hamlized = system('html2haml -e -s', s:visual_selection)
  normal gvx
  let @x = s:hamlized
  if s:Last_line_is_selected()
    normal "xp
  else
    normal "xP
  endif
endfunction

vnoremap <silent> <Plug>Vhtml_to_haml  :<C-U>call <SID>opfunc(visualmode(),visualmode() ==# 'V' ? 1 : 0)<CR>
xmap <c-v>   <Plug>Vhtml_to_haml

" function RunCommandWithStdin taken from
" http://stackoverflow.com/questions/18432409/can-i-pass-a-string-as-stdin-to-a-system-call-from-vim
" system() seems to work for now...

"function! RunCommandWithStdin(cmd, stdin_lines)
"  let l:stdin = shellescape(join(a:stdin_lines, "\\n"), 1)
"  return execute '!echo -e' l:stdin '|' a:cmd
"endfunction
