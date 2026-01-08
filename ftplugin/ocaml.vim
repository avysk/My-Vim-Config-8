" OCaml-specific settings and mappings
" Extracted from vimrc for better organization

" OCaml-specific abbreviation for modeline
iabbrev <buffer> _ML (*<C-M><BS><BS>vim:sw=2<C-M>*)

" Text width and indentation
setlocal tw=0
setlocal shiftwidth=2

" Reformat mapping
nnoremap <buffer><silent><unique> <LocalLeader>f :call <SID>MyvimOcamlReformat()<CR>

" Function to reformat OCaml code with ocamlformat
function! s:MyvimOcamlReformat() abort
  if !executable('ocamlformat')
    echoerr 'ocamlformat is not available. Please install it.'
    return
  endif
  
  const curpos = getcurpos()
  try
    write
    silent execute '! [ -f .ocamlformat ] || touch .ocamlformat'
    if v:shell_error != 0
      echoerr 'Failed to create .ocamlformat file'
      return
    endif
    
    silent execute "%!ocamlformat '%'"
    if v:shell_error != 0
      undo
      echoerr 'ocamlformat failed. Changes have been reverted.'
      return
    endif
    
    write
    call setpos('.', curpos)
  catch /^Vim\%((\a\+)\)\=:E/
    echoerr 'Error during reformat: ' .. v:exception
  endtry
endfunction
