" Python-specific settings and mappings
" Extracted from vimrc for better organization

" Indentation
setlocal shiftwidth=4

" For documentation
setlocal colorcolumn+=72

" Switch to test file
nnoremap <buffer><silent> <LocalLeader>t :call MyvimPythonTestFile()<CR>

" Go back from test file
nnoremap <buffer><silent> <LocalLeader>b :silent execute ":sb " .. substitute(expand('%:h'), '^tests/', 'src/', '') .. substitute(expand('%:t'), '^test_', '/', '')<CR>

" Sort imports on save
if exists(':CocCommand')
  autocmd BufWritePre <buffer> CocCommand python.sortImports
endif
