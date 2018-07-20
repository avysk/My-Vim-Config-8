colorscheme pencil
set background=light
if has("gui_running")
        set linespace=5
        if has("gui_gtk2")
                set guifont=Cousine\ 12,Andale\ Mono\ 14
        endif
        if has("gui_macvim")
                set guifont=Cousine:h12.00,Menlo:h12.00
        endif
endif

setlocal spell

setlocal nolist
setlocal linebreak

" Next are unfortunately global
set showbreak=.\ \ 
set display+=lastline

map <buffer> j gj
map <buffer> k gk

" Fix the preivous spelling mistake in insert mode with C-l
inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u
