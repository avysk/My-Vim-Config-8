" Formatting autocmds - auto-formatting on save

function! s:MyvimMaybeRunNeoformat() abort
  if !exists(':Neoformat')
    " Neoformat plugin is not loaded
    return
  endif
  
  if index(g:neoformat_for_filetypes, &filetype) >= 0
    try
      execute 'undojoin | Neoformat'
    catch /^Vim\%((\a\+)\)\=:E/
      " Silently handle formatting errors to avoid interrupting save
      echohl WarningMsg
      echom 'Neoformat error: ' .. v:exception
      echohl None
    endtry
  endif
endfunction

augroup fmt
  autocmd!
  autocmd BufWritePre * call s:MyvimMaybeRunNeoformat()
augroup end
