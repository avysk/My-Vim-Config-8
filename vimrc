"{{{ Windows/non-Windows specific settings
if has("win32")
  language C
  let g:_myvim_configdir=$HOME . '/vimfiles'
  set fileformat=unix
  set fileformats=unix,dos
else
  let g:_myvim_configdir=$HOME . '/.vim'
endif
"}}}

"{{{ Local paths
let g:_myvim_localdir=g:_myvim_configdir . '/local'
let s:scriptsdir=g:_myvim_configdir . '/scripts'
let s:pluginsdir=g:_myvim_localdir . '/plugged'
"}}}

"{{{1 General vim behaviour

" Proper backspace
set bs=indent,eol,start

" I don't want no tab characters
set expandtab

" Search in all subdirectories
set path+=**

" Proper completion
set wildmode=list:longest

"{{{2 Information about files

" Remember marks in 1000 last files
" Remember up to 1000 lines per register
set viminfo='1000,<1000

" Permanent undo
if has('persistent_undo')
  set undofile
  let &undodir=g:_myvim_localdir . "/undo"
  set undolevels=5000
endif
"}}}2

"{{{2 Search and parens matching

set showmatch  " Jump to matching paren
set matchtime=1  " ...but very fast
let loaded_matchparen=1  " ...and do no highlights

set ignorecase
set smartcase
set incsearch
set hlsearch
"}}}2

" Folding
set foldmethod=syntax

"{{{2 Windows and buffers
set noequalalways  " Do not resize my windows
set hidden " Use hidden buffers liberally
set switchbuf=usetab,split
"}}}2

"}}}1

"{{{1 Decorations
set modeline  " this is off for Debian by default

set relativenumber
set number

if has("win32")
  " Nothing
else
  set list
  set listchars=tab:⇒⋄,trail:∴,extends:→,precedes:←,nbsp:·
endif
set ruler
set laststatus=2
set showcmd
"}}}1

"{{{1 Bindings

"{{{2 Use space for leader
nnoremap <Space> <Nop>
nmap <Space> <Leader>
"}}}2

"{{{2 Switching to writing mode
" text in Russian
let g:_myvim_rus_text_script = "source " . s:scriptsdir . "/rus_text.vim"
nmap <Leader>rus :exec g:_myvim_rus_text_script<C-M>
" text in English
let g:_myvim_eng_text_script = "source " . s:scriptsdir . "/eng_text.vim"
nmap <Leader>eng :exec g:_myvim_eng_text_script<C-M>
"}}}2

"{{{2 Remapping arrows and similar keys to something useful
" Right/Left to move through ALE errors list
nmap <Down> <Plug>(ale_next_wrap)
nmap <Up> <Plug>(ale_previous_wrap)
" ALE documentation
nnoremap <F2> <Plug>(ale_documentation)
" PgDown to drop search highlighting
nnoremap <PageDown> :nohl<CR>
inoremap <PageDown> <C-O>:nohl<CR>
" PgUp to go to alternate file
nnoremap <PageUp> <C-^>
inoremap <PageUp> <C-O><C-^>
"}}}2

"}}}1

"{{{1 Plugins

"{{{2 Vim-plug managed plugins
call plug#begin(s:pluginsdir)

"{{{3 ALE
Plug 'dense-analysis/ale'
"}}}

"{{{3 black
Plug 'psf/black', { 'tag': '19.10b0' }
"}}}

"{{{3 Colorschemes
Plug 'reedes/vim-colors-pencil' | Plug 'lifepillar/vim-solarized8'
"}}}3

"{{{3 DrawIt
Plug 'vim-scripts/DrawIt'
"}}}

"{{{3 FastFold + SimpylFold
Plug 'Konfekt/FastFold' | Plug 'tmhedberg/SimpylFold'
"}}}3

"{{{3 fzf
Plug 'junegunn/fzf' | Plug 'junegunn/fzf.vim'
nmap <unique><silent><nowait> <Leader>bb :Buffers<CR>
"}}}

"{{{3 GitGutter
Plug 'airblade/vim-gitgutter'
" faster realtime updates
set updatetime=1000
" Highlight changed lines
let g:gitgutter_highlight_lines=1
let g:gitgutter_enabled=0
nnoremap <silent><nowait> <Leader>gg :GitGutterToggle<CR>
"}}}3

"{{{3 Julia
Plug 'JuliaEditorSupport/julia-vim'
let g:latex_to_unicode_auto = 1
"}}}3

"{{{3 paredit
Plug 'kovisoft/paredit', { 'for': ['clojure', 'lisp', 'scheme'] }
"}}}3

"{{{3 tagbar
Plug 'preservim/tagbar', {'on': 'TagbarToggle'}
nmap <F12> :TagbarToggle<CR>
"}}}

"{{{3 tslime
Plug 'jimmyharris/tslime.vim'
vmap <unique> <C-c><C-c> <Plug>SendSelectionToTmux
nmap <unique> <C-c><C-c> <Plug>NormalModeSendToTmux
nmap <unique> <C-c>r <Plug>SetTmuxVars
"}}}

"{{{3 Ultisnips + vim-snippets
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
let g:UltiSnipsEditSplit="vertical"
let g:UltiSnipsExpandTrigger="<Right>"
let g:UltiSnipsListSnippets="<Left>"
let g:UltiSnipsJumpForwardTrigger="<Down>"
let g:UltiSnipsJumpBackwardTrigger="<Up>"
"}}}3

"{{{3 vim-latex
let g:tex_flavor='latex'
if has("win32")
  set shellslash
endif
Plug 'vim-latex/vim-latex'
"}}}3

"{{{3 YouCompleteMe
Plug 'ycm-core/YouCompleteMe', { 'do': 'python install.py' }

" let it work in virtualenv
let g:ycm_python_binary_path = 'python'

nnoremap <Leader>] :YcmCompleter GoTo<CR>
nnoremap <Leader>` :YcmCompleter GetDoc<CR>
"}}}

"{{{3 vim-graphql
Plug 'jparise/vim-graphql'
"}}}

"{{{3 vim-markdown
Plug 'plasticboy/vim-markdown'
let g:vim_markdown_math=1
let g:vim_markdown_frontmatter=1
let g:vim_markdown_strikethrough=1
autocmd FileType markdown set conceallevel=2
autocmd FileType markdown set nowrap
autocmd FileType markdown set tw=80
"}}}

"{{{3 vimoutliner
Plug 'vimoutliner/vimoutliner'
autocmd FileType votl set listchars=tab:\ \ ,trail:∴,extends:→,precedes:←,nbsp:·
"}}}

"{{{3 vimwiki
Plug 'vimwiki/vimwiki'
let g:vimwiki_list = [
      \ {'path': '~/vimwiki', 'list_margin': 2},
      \ {'path': '~/Dropbox/vimwiki', 'list_margin': 2},
      \ {'path': '~/Dropbox/vimwiki-md', 'list_margin': 2,
      \  'syntax': 'markdown', 'ext': '.mdw'}]

let g:vimwiki_ext2syntax = {}

nmap <leader>tt <Plug>VimwikiToggleListItem
autocmd FileType vimwiki set tw=80
autocmd FileType vimwiki set nowrap

nmap <F1> <Plug>VimwikiTabMakeDiaryNote
nmap <S-F1> <Plug>VimwikiDiaryIndex
nmap <leader><F1> <Plug>VimwikiDiaryIndex
"}}}

"{{{3 vlime
Plug 'vlime/vlime', {'rtp': 'vim/'}
let g:vlime_cl_impl = 'clisp'
function! VlimeBuildServerCommandFor_clisp(vlime_loader, vlime_eval)
  return ['clisp', '-i', a:vlime_loader,
        \ '-x', a:vlime_eval,
        \ '-repl']
endfunction
"}}}3

call plug#end()
"}}}


"{{{2 ALE
let g:ale_lint_on_text_changed = 'never'
let g:ale_python_pylint_change_directory = 0
let g:ale_python_mypy_change_directory = 0

let g:ale_cpp_clangtidy_checks = ['*', '-fuchsia*']
let g:ale_fixers = {
      \ 'cpp': ['clang-format'],
      \ 'ocaml': ['ocamlformat']}
let g:ale_fix_on_save = 1

let g:ale_linters = {
      \ 'cpp': ['clangcheck', 'clangtidy', 'cppcheck'] }
"}}}

"{{{2 vim-black
let g:black_linelength = 79
"}}}2

"}}}1

"{{{1 Languages

"{{{2 INTERCAL
au BufRead,BufNewFile *.i set syntax=intercal
"}}}2

"{{{2 C
set cino=:0
"}}}2

"{{{2 C++
autocmd FileType cpp setlocal shiftwidth=2
autocmd FileType cpp setlocal softtabstop=2
"}}}

"{{{2 FORTRAN
let fortran_free_source=1
let fortran_fold=1
let fortran_fold_conditionals=1
let fortran_fold_multilinecomments=1
let fortran_more_precise=1
let fortran_do_enddo=1
"}}}2

"{{{2 Python
autocmd FileType python setlocal softtabstop=4
autocmd FileType python setlocal shiftwidth=4
"}}}2

"{{{2 OCaml
if has("win32")
  " Nothing
else
  let g:ocaml_folding=1
  let g:opamshare = substitute(system('opam config var share'),'\n$','','''')

  let s:ocp_indent = 'source ' . g:opamshare . '/ocp-indent/vim/indent/ocaml.vim'
  autocmd FileType ocaml exec s:ocp_indent
  execute "set rtp+=" . g:opamshare . "/merlin/vim"
  execute "set rtp+=" . g:opamshare . "/merlin/vimbufsync"

  autocmd FileType ocaml iabbrev <buffer> _ML (*<C-M><BS><BS>vim:sw=2<C-M>*)
  autocmd FileType ocaml setlocal tw=0
  autocmd FileType ocaml setlocal softtabstop=2
  autocmd FileType ocaml setlocal shiftwidth=2

endif
"}}}2

"{{{2 Lisp
let g:lisp_rainbow=1
"}}}2

"}}}1

"{{{1 Built-in packages
packadd! matchit
"}}}1

" KEEP THOSE AT THE BOTTOM
let s:localrc = g:_myvim_localdir . "/vimrc"
if filereadable(s:localrc)
  exec 'source ' . s:localrc
endif

syntax on
filetype plugin on
filetype indent on

set encoding=utf-8
set fileencoding=utf-8

" vim:sw=2:sts=2:foldmethod=marker
