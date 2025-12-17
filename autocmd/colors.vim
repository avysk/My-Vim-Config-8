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
  const s:session = trim(system("tmux display-message -p '#{client_session}'"))
  if s:session =~# 'msx'
    augroup FixCoc
      autocmd!
      autocmd BufEnter * hi CocMenuSel ctermbg=7 guibg=#3AA241
    augroup END
  endif
endif

augroup FixRainbow
  autocmd!
  autocmd BufEnter * execute 'colorscheme ' .. g:colors_name
  autocmd BufEnter * RainbowToggleOn
augroup END
