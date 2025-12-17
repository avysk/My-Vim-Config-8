" Color scheme related autocmds

augroup QuickscopeColors
  autocmd!
  autocmd ColorScheme * hi! QuickScopePrimary cterm=reverse gui=reverse
  autocmd ColorScheme * hi! QuickScopeSecondary cterm=underline gui=underline
augroup END

augroup TermdebugColors
  autocmd!
  autocmd Colorscheme * hi! link debugPC PmenuSbar
  autocmd Colorscheme * hi! link debugBreakpoint WarningMsg
augroup end

" Fix coc.nvim menu highlight for msx colorscheme in tmux msx session
if !empty($TMUX)
  try
    const s:session = trim(system("tmux display-message -p '#{client_session}'"))
    if v:shell_error == 0 && s:session =~# 'msx'
      augroup FixCoc
        autocmd!
        autocmd BufEnter * hi CocMenuSel ctermbg=7 guibg=#3AA241
      augroup END
    endif
  catch /^Vim\%((\a\+)\)\=:E/
    " Silently handle tmux command errors
  endtry
endif

augroup FixRainbow
  autocmd!
  autocmd BufEnter * if exists('g:colors_name') | try | execute 'colorscheme ' .. g:colors_name | catch /^Vim\%((\a\+)\)\=:E185/ | endtry | endif
  autocmd BufEnter * if exists(':RainbowToggleOn') | try | execute 'RainbowToggleOn' | catch /^Vim\%((\a\+)\)\=:E/ | endtry | endif
augroup END
