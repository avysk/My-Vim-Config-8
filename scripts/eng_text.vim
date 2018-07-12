setlocal spell
setlocal spelllang=en_gb

let &l:spellfile=g:_myvim_configdir . '/spell/my.eng.utf-8.add'
let &l:thesaurus=&l:thesaurus . ',' . g:_myvim_configdir . '/mthesaur.txt'

setlocal nolist
setlocal linebreak
setlocal complete+=s

" Next are unfortunately global
set showbreak=.\ \ 
set display+=lastline

map <buffer> j gj
map <buffer> k gk

" Fix the preivous spelling mistake in insert mode with C-l
inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u

colo pencil
