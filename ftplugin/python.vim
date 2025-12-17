" Python-specific settings and mappings
" Extracted from vimrc for better organization

" Indentation
setlocal shiftwidth=4

" For documentation
setlocal colorcolumn+=72

" Switch to test file
nnoremap <buffer><silent> <LocalLeader>t :call PythonTestFile()<CR>

" Go back from test file
nnoremap <buffer><silent> <LocalLeader>b :silent execute ':sb ' .. substitute(expand('%:t'), '^test_', '/', '')<CR>

" Sort imports on save
autocmd BufWritePre <buffer> CocCommand python.sortImports

" Function to navigate to test file
function! PythonTestFile() abort
  const mybufname = bufname()
  set shellslash
  const myfilename = fnamemodify(mybufname, ':t')
  const mydirname = fnamemodify(mybufname, ':.:s?^./??:h')
  const testdirname = substitute(mydirname, '[^/]\+', 'tests', '')
  const testname = testdirname .. '/test_' .. myfilename
  const testbufname = bufname('^' .. testname .. '$')
  silent execute empty(testbufname) ? ':e ' .. testname : ':sb ' .. testname
endfunction
