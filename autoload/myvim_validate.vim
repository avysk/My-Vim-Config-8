" Configuration validation functions
" Verify external dependencies and provide helpful error messages

" Check if Node.js is available and meets version requirement
function! myvim_validate#CheckNode() abort
  if !executable('node')
    echohl WarningMsg
    echom 'Node.js not found. coc.nvim requires Node.js 20+.'
    echom 'Install from: https://nodejs.org/'
    echohl None
    return 0
  endif
  
  let l:version = system('node --version')
  let l:major = str2nr(matchstr(l:version, '\d\+'))
  if l:major < 20
    echohl WarningMsg
    echom 'Node.js ' .. l:major .. ' found, but coc.nvim requires Node.js 20+.'
    echohl None
    return 0
  endif
  
  return 1
endfunction

" Check if Python is available
function! myvim_validate#CheckPython() abort
  if !executable('python') && !executable('python3')
    echohl WarningMsg
    echom 'Python not found. Some language servers require Python.'
    echohl None
    return 0
  endif
  return 1
endfunction

" Check if OCaml environment is set up
function! myvim_validate#CheckOCaml() abort
  if exists('$NO_OCAML_IN_VIM') || !executable('opam')
    return 1
  endif
  
  if !executable('ocamlmerlin')
    echohl WarningMsg
    echom 'ocamlmerlin not found. Install with: opam install merlin'
    echohl None
    return 0
  endif
  
  return 1
endfunction

" Validate all critical dependencies
function! myvim_validate#ValidateAll() abort
  call myvim_validate#CheckNode()
  call myvim_validate#CheckPython()
  call myvim_validate#CheckOCaml()
endfunction
