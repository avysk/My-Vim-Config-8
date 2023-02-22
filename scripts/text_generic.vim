if has("gui_running")
        set background=light
        colorscheme pencil
        set linespace=8
        if has("gui_gtk3")
                set guifont=Cousine\ 16,Andale\ Mono\ 16
        endif
        if has("gui_macvim")
                set guifont=Iosevka:h16,Cousine:h12.00,Menlo:h12.00
        endif
endif

setlocal spell

setlocal nolist
setlocal linebreak
setlocal breakindent

" Next are unfortunately global
set showbreak=.\ \ 
set display+=lastline

map <buffer> j gj
map <buffer> k gk

" Fix the previous spelling mistake in insert mode with C-l
inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u
