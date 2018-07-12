setlocal spell
setlocal spelllang=ru_yo
if has("win32")
        setlocal spellfile=$HOME/vimfiles/spell/my.ru.utf-8.add
else
        setlocal spellfile=~/.vim/spell/my.ru.utf-8.add
endif
setlocal nolist
setlocal linebreak

" Next two are unfortunately global
set showbreak=.\ \ 
set display+=lastline

map <buffer> <Down> gj
map <buffer> <Up> gk
map <buffer> j gj
map <buffer> k gk
imap <buffer> <Down> <C-o>gj
imap <buffer> <Up> <C-o>gk

" Fix the preivous spelling mistake in insert mode with C-l
inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u

if has("win32")
        so $HOME/vimfiles/scripts/iawriter_theme.vim
else
        so ~/.vim/scripts/iawriter_theme.vim
endif
