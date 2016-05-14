"if exists("g:loaded_convert_to_haml") || &cp || v:version < 700
"
"  finish
"endif
"
"let g:loaded_convert_to_haml = 1

"command! -nargs=0 ConvertY  :call s:opfunc(visualmode(),visualmode() ==# 'V' ? 1 : 0)
command! -range -nargs=0 Html2Haml  :call s:opfunc(visualmode(),visualmode() ==# 'V' ? 1 : 0)

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

  silent! call repeat#set("\<Plug>Nhtml_to_haml", v:count)
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

function! s:WriteToNewBuffer(file_name, file_type, file_path)
  execute 'rightbelow vsplit ' . a:file_name
  execute 'setlocal filetype=' . a:file_type
  execute 'setlocal buftype=nowrite'
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

function! s:opfunc(type,vis)
  let s:Fn = function("s:Get_visual_selection")
  let s:selection = call(s:Fn, [])
  let s:hamlized = system('cd `rbenv root` && html2haml -e -s', s:selection)
  call s:WriteToNewBuffer("haml_equivalent", 'haml', '/tmp/file.haml')
  "normal gvx
  let @x = s:hamlized
  if s:Last_line_is_selected()
    normal "xp
  else
    normal "xP
  endif

  "echom v:count
  "silent! call repeat#set("\<Plug>Vhtml_to_haml()")
endfunction

"nnoremap <silent> <Plug>Nhtml_to_haml  :<C-U>call <SID>DoHaml()<CR>
"vnoremap <silent> <Plug>Vhtml_to_haml  :<C-U>call <SID>opfunc(visualmode(),visualmode() ==# 'V' ? 1 : 0)<CR>
"xmap <c-g>   <Plug>Vhtml_to_haml
"nmap <leader>t   <Plug>Nhtml_to_haml

" function RunCommandWithStdin taken from
" http://stackoverflow.com/questions/18432409/can-i-pass-a-string-as-stdin-to-a-system-call-from-vim
" system() seems to work for now...

"function! RunCommandWithStdin(cmd, stdin_lines)
"  let l:stdin = shellescape(join(a:stdin_lines, "\\n"), 1)
"  return execute '!echo -e' l:stdin '|' a:cmd
"endfunction
