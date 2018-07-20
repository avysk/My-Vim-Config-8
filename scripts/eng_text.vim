setlocal spelllang=en_gb

let &l:spellfile=g:_myvim_configdir . '/spell/my.eng.utf-8.add'
let &l:thesaurus=&l:thesaurus . ',' . g:_myvim_configdir . '/mthesaur.txt'

setlocal complete+=s


exec 'source ' . g:_myvim_configdir . '/scripts/text_generic.vim'
