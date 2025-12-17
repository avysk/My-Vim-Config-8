" General autocmds for various file types and behaviors

augroup Makefile
  autocmd!
  autocmd FileType make setlocal tabstop=8
  autocmd FileType make setlocal listchars=tab:⇒\ ,trail:∴,extends:→,precedes:←,nbsp:·
augroup end

augroup Outliner
  autocmd!
  autocmd BufReadPost *.otl setf votl
  autocmd FileType votl setlocal listchars=tab:\ \ ,trail:∴,extends:→,precedes:←,nbsp:·
augroup end

augroup c_header
  autocmd!
  autocmd BufNewFile *.h let b:guard = toupper(expand('%:t:r')) .. '_H' | call setline(1, ['#ifndef ' .. b:guard, '#define ' .. b:guard, '', '#endif // ' .. b:guard]) | 3 | startinsert
augroup END

augroup VimwikiSettings
  autocmd!
  autocmd FileType vimwiki setlocal tw=80
  autocmd FileType vimwiki setlocal nowrap
  autocmd FileType vimwiki setlocal foldmethod=syntax
  autocmd FileType vimwiki setlocal foldlevel=2
  autocmd FileType vimwiki ++once nnoremap <unique><silent> <leader>tt <Plug>VimwikiToggleListItem
augroup END

" Configure cursor appearance for different terminals
if &term =~# "-256color" || &term =~# 'win32'
  augroup CursorAppearance
    autocmd!
    " Make sure that at start the cursor is orange block
    autocmd VimEnter * normal! :startinsert :stopinsert
  augroup END
endif
