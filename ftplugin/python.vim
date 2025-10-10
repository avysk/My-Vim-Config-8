" Python-specific settings and mappings
" Extracted from vimrc for better organization

" Indentation
setlocal shiftwidth=4

" For documentation
setlocal colorcolumn+=72

" Switch to test file
nnoremap <buffer><silent> <LocalLeader>t :call PythonTestFile()<CR>

" Go back from test file
nnoremap <buffer><silent> <LocalLeader>b :silent execute ':sb ' . substitute(expand('%:t'), '^test_', '/', '')<CR>

" Sort imports on save
autocmd BufWritePre <buffer> CocCommand python.sortImports

" Function to navigate to test file
function! PythonTestFile()
  let mybufname = bufname()
  set shellslash
  let myfilename = fnamemodify(mybufname, ':t')
  let mydirname = fnamemodify(mybufname, ':.:s?^./??:h')
  let testdirname = substitute(mydirname, '[^/]\+', 'tests', '')
  let testname = testdirname .. '/test_' .. myfilename
  let testbufname=bufname("^" .. testname .. '$')
  if testbufname == ''
    silent execute ':e ' .. testname
  else
    silent execute ':sb ' .. testname
  endif
endfunction
