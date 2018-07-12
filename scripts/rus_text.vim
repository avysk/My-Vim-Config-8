setlocal spell
setlocal spelllang=ru_yo

let &l:spellfile=g:_myvim_configdir . '/spell.my.ru.utf-8.add'
setlocal nolist
setlocal linebreak

" Next two are unfortunately global
set showbreak=.\ \ 
set display+=lastline

map <buffer> j gj
map <buffer> k gk

" Fix the preivous spelling mistake in insert mode with C-l
inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u

colo pencil
