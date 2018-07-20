setlocal spelllang=ru_yo

let &l:spellfile=g:_myvim_configdir . '/spell.my.ru.utf-8.add'

" Fix the preivous spelling mistake in insert mode with C-l
inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u

colo pencil

exec 'source ' . g:_myvim_configdir . '/scripts/text_generic.vim'
