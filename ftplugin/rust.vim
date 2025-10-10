" Rust-specific settings and mappings
" Extracted from vimrc for better organization

" Rust coding style document says so
setlocal colorcolumn=100
setlocal shiftwidth=4

" -> means function type return; I do not want beeps here
setlocal mps-=<:>

" If editing src/*.rs or tests/*.rs, add shortcut to open terminal in the project directory
if expand('%:p') =~# '\(src\|tests\)[\\/].*\.rs$'
  nnoremap <buffer><silent> <LocalLeader>rr :execute "tab terminal ++close ++kill='term' " . g:_myvim_shell<CR>
endif
