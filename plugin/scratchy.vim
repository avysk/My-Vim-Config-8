" Vim scratch buffer implementation
" Alexey Vyskubov <alexey@ocaml.nl>

" Do this only once
if exists("scratchy_version")
  finish
endif

let g:scratchy_name = get(g:, 'scratchy_name', "--scratchy--")
let g:scratchy_geometry = get(g:, 'scratchy_geometry', "vertical rightbelow 40")

let g:scratchy_builtin_bindings = get(g:, 'scratchy_builtin_bindings', 1)

if g:scratchy_builtin_bindings
  nmap <unique> <F4> :ScratchTab<CR>
  nmap <unique> <F5> :ScratchWindow<CR>
  nmap <unique> <F6> :CloseScratch<CR>
  imap <unique> <F4> <C-O>:ScratchTab<CR>
  imap <unique> <F5> <C-O>:ScratchWindow<CR>
  imap <unique> <F6> <C-O>:CloseScratch<CR>
endif

" Nothing to touch below this line
" --------------------------------
let scratchy_version = "0.3"

" Close scratch window or tab
function CloseScratch()
  execute "tabdo call CloseScratch_()"
endfunction

" Close active scratch window or tab
function CloseScratch_()
  let l:win_num = bufwinnr(g:scratchy_name)
  if l:win_num > 0
    " Close scratch window in the current tab
    execute win_num . "wincmd w"
    execute "wincmd c"
    execute "wincmd ="
  endif
endfunction

" Open scratch window
function OpenScratchWindow()
  let l:old_tab = tabpagenr()
  call CloseScratch()
  execute "tabn " . old_tab
  if bufexists(g:scratchy_name)
    execute g:scratchy_geometry . "new"
    execute "buf ". g:scratchy_name
  else
    execute g:scratchy_geometry . "new"
    execute "file " . g:scratchy_name
    setlocal buftype=nofile
    setlocal bufhidden=hide
    setlocal noswapfile
  endif
endfunction

" Open scratch tab
function OpenScratchTab()
  let s:old_tab = tabpagenr()
  call CloseScratch()
  if bufexists(g:scratchy_name)
    execute "tabe"
    execute "buf " . g:scratchy_name
  else
    execute "tabe " . g:scratchy_name
    setlocal buftype=nofile
    setlocal bufhidden=hide
    setlocal noswapfile
  endif
  call setwinvar(0, "is_scratchy_tab", 1)
endfunction

" Return back
function JumpBack()
  echo s:old_tab
  execute "tabn" . s:old_tab
endfunction

" Open scratch tab if not there, go back if we're there
function ToggleScratchTab()
  if getwinvar(0, "is_scratchy_tab")
    call JumpBack()
  else
    call OpenScratchTab()
  endif
endfunction

" Open scratch window if we don't have one, close if we do
function ToggleScratchWindow()
  if gettabwinvar(tabpagenr(), 0, "is_scratchy_tab")
    call JumpBack()
  else
    let l:win_num = bufwinnr(g:scratchy_name)
    if l:win_num > 0
      call CloseScratch_()
    else
      call OpenScratchWindow()
    endif
  endif
endfunction

command -nargs=0 ScratchTab call ToggleScratchTab()
command -nargs=0 ScratchWindow call ToggleScratchWindow()
command -nargs=0 CloseScratch call CloseScratch()

" vim:sts=2:sw=2
