" OCaml-specific settings and mappings
" Extracted from vimrc for better organization

" OCaml-specific abbreviation for modeline
iabbrev <buffer> _ML (*<C-M><BS><BS>vim:sw=2<C-M>*)

" Text width and indentation
setlocal tw=0
setlocal shiftwidth=2

" Reformat mapping
nnoremap <buffer><silent><unique> <LocalLeader>f :call Reformat()<CR>

" Function to reformat OCaml code with ocamlformat
function! Reformat()
  let curpos = getcurpos()
  execute "w"
  silent execute "! [ -f .ocamlformat ] || touch .ocamlformat"
  silent execute "%!ocamlformat '%'"
  write
  call setpos('.', curpos)
endfunction
