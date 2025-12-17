" Formatting autocmds - auto-formatting on save

function! MaybeRunNeoformat() abort
  if index(g:neoformat_for_filetypes, &filetype) >= 0
    execute 'undojoin | Neoformat'
  endif
endfunction

augroup fmt
  autocmd!
  autocmd BufWritePre * call MaybeRunNeoformat()
augroup end
