if has("win32")
        language C
endif

"                        *** Please behave ***
set nocompatible

" Use space for leader
nnoremap <Space> <Nop>
nmap <Space> <Leader>

set backspace=indent,eol,start
set expandtab

set modeline
set modelines=5

set path+=** " Search in all subdirectories

set showmatch
set noequalalways
set wildmode=list:longest
set relativenumber
set number

" Remember marks in 20 last files
" Remember up to 1000 lines per register
set viminfo='20,<1000

" Permanent undo
if has('persistent_undo')
    set undofile
    set undodir=$HOME/.vim_undo_files
    set undolevels=5000
endif

" Search options
set ignorecase
set smartcase
set incsearch
set hlsearch

" Folding
set foldenable
set foldmethod=syntax

" Buffers
set hidden " Use hidden buffers liberally
set switchbuf=usetab,split
nmap <unique> <Leader>ls :ls<CR>:buf 
nmap <unique> <Leader>bb :buf 
nmap <unique> <Leader>vb :vertical sb 

" Tabs
set tabpagemax=20

"                        *** Decorations ***
"set listchars=
if has("win32")
        " Nothing
else
        set list
        set listchars=tab:⇒⋄,trail:∴,extends:→,precedes:←,nbsp:·
endif
"if ($TERM=="screen")
"        set nolist
"else
"        set list
"        set listchars=tab:⇒…,trail:∴,extends:→,precedes:←,nbsp:·
"endif
set ruler
set laststatus=2
set showcmd

"                         *** Bindings ***
" text in Russian
if has("win32")
        map <Leader>rus :so $HOME/vimfiles/scripts/rus_text.vim<C-M>
else
        map <Leader>rus :so ~/.vim/scripts/rus_text.vim<C-M>
endif
" text in English
if has("win32")
        map <Leader>eng :so $HOME/vimfiles/scripts/eng_text.vim<C-M>
else
        map <Leader>eng :so ~/.vim/scripts/eng_text.vim<C-M>
endif
" scratch
map <F4> <C-\><C-N>:ScratchTab<CR>
map <F5> <C-\><C-N>:ScratchWindow<CR>
map <F6> <C-\><C-N>:CloseScratch<CR>
map <F13> <C-\><C-N>:ScratchTab<CR>
map <F14> <C-\><C-N>:ScratchWindow<CR>
map <F15> <C-\><C-N>:CloseScratch<CR>
imap <F4> <C-\><C-N>:ScratchTab<CR>
imap <F5> <C-\><C-N>:ScratchWindow<CR>
imap <F6> <C-\><C-N>:CloseScratch<CR>
imap <F13> <C-\><C-N>:ScratchTab<CR>
imap <F14> <C-\><C-N>:ScratchWindow<CR>
imap <F15> <C-\><C-N>:CloseScratch<CR>
" tagbar
nmap <F12> :TagbarToggle<CR>

" Right/Left to move through location list (e.g. Syntastic errors)
nnoremap <Right> :lnext<CR>
nnoremap <Left> :lprev<CR>
" PgDown to drop search highlighting
nnoremap <PageDown> :nohl<CR>
inoremap <PageDown> <C-O>:nohl<CR>
" PgUp to go to alternate file
nnoremap <PageUp> <C-^>

"                        *** Plugins settings ***

"       *** Gitgutter
" faster realtime updates
set updatetime=1000
" Highlight changed lines
let g:gitgutter_highlight_lines=1

"       *** Lusty explorer
" Silence message about non-available Ruby
let g:LustyJugglerSuppressRubyWarning = 1

"       *** Ultisnips
let g:UltiSnipsEditSplit="vertical"
let g:UltiSnipsExpandTrigger="<Right>"
let g:UltiSnipsListSnippets="<Left>"
let g:UltiSnipsJumpForwardTrigger="<Down>"
let g:UltiSnipsJumpBackwardTrigger="<Up>"


"       *** YouCompleteMe
" let it work in virtualenv
let g:ycm_python_binary_path = 'python'
nnoremap <Leader>] :YcmCompleter GoTo<CR>

"       *** VimWiki
let g:vimwiki_list = [{'path': '~/vimwiki', 'list_margin': 2},
                    \ {'path': '~/Dropbox/vimwiki', 'list_margin': 2},
                    \ {'path': '~/Dropbox/vimwiki-md', 'list_margin': 2, 'syntax': 'markdown', 'ext': '.mdw'}]
nmap <leader>tt <Plug>VimwikiToggleListItem
autocmd FileType vimwiki set tw=80
autocmd FileType vimwiki set nowrap

nmap <F1> <Plug>VimwikiTabMakeDiaryNote
nmap <S-F1> <Plug>VimwikiDiaryIndex
nmap <leader><F1> <Plug>VimwikiDiaryIndex

"       *** Syntastic
let g:syntastic_always_populate_loc_list = 1
" be passive on go
let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['go'] }

"       *** Vimoutliner
autocmd FileType votl set listchars=tab:\ \ ,trail:∴,extends:→,precedes:←,nbsp:·

"                         *** Languages ***

"         *** INTERCAL
au BufRead,BufNewFile *.i set syntax=intercal

"         *** C
set cino=:0
" use gcc for syntastic
let g:syntastic_c_compiler = 'gcc'
let g:syntastic_c_compiler_options = '-std=gnu99 -Wall -I/opt/local/include'

"         *** FORTRAN
let fortran_free_source=1
let fortran_fold=1
let fortran_fold_conditionals=1
let fortran_fold_multilinecomments=1
let fortran_more_precise=1
let fortran_do_enddo=1

"         *** Python
autocmd FileType python setlocal softtabstop=4
autocmd FileType python setlocal shiftwidth=4
let g:syntastic_python_checkers=['pycodestyle', 'pylint', 'python']

"         *** OCaml
if has("win32")
        " Nothing
else
        let g:ocaml_folding=1
        let g:opamshare = substitute(system('opam config var share'),'\n$','','''')
        "let s:ocp_indent = 'source ' . g:opamshare . '/vim/syntax/ocp-indent.vim'
        autocmd FileType ocaml iabbrev <buffer> _ML (*<C-M><BS><BS>vim:sw=2<C-M>*)
        autocmd FileType ocaml setlocal tw=0
        autocmd FileType ocaml setlocal softtabstop=2
        autocmd FileType ocaml setlocal shiftwidth=2
        "autocmd FileType ocaml exec s:ocp_indent

        execute "set rtp+=" . g:opamshare . "/merlin/vim"

        " use merlin for syntastic
        let g:syntastic_ocaml_checkers = ['merlin']
endif

"         *** Lisp
let g:lisp_rainbow=1

"         *** Scala
au BufRead,BufNewFile *.sc set filetype=scala

"         *** Elixir
let g:tagbar_type_elixir = {
    \ 'ctagstype' : 'elixir',
    \ 'kinds' : [
        \ 'f:functions',
        \ 'functions:functions',
        \ 'c:callbacks',
        \ 'd:delegates',
        \ 'e:exceptions',
        \ 'i:implementations',
        \ 'a:macros',
        \ 'o:operators',
        \ 'm:modules',
        \ 'p:protocols',
        \ 'r:records',
        \ 't:tests'
    \ ]
    \ }

"         *** Javascript
let g:syntastic_javascript_checkers = ['eslint']
" ...and jsx extensions
let g:jsx_ext_required = 0

"         *** Julia
let g:latex_to_unicode_auto = 1

"         *** Typescript
let g:typescript_use_builtin_tagbar_defs=1

"         *** Ruby
autocmd FileType ruby setlocal softtabstop=2
autocmd FileType ruby setlocal shiftwidth=2
"autocmd FileType ruby setlocal makeprg=rake\ -s
autocmd FileType ruby compiler rspec
let g:syntastic_ruby_checkers=['rubocop', 'mri']
" let g:rubycomplete_buffer_loading = 1
let g:rubycomplete_classes_in_global = 1

" ...and now to make MacVim happy
if has("gui_macvim")
  set rubydll=/opt/local/lib/libruby.2.4.dylib
endif

"         *** Go
autocmd FileType go set listchars=tab:⋄\ ,trail:∴,extends:→,precedes:←,nbsp:·
au FileType go nmap <leader>r <Plug>(go-run)
au FileType go nmap <leader>b <Plug>(go-build)
au FileType go nmap <leader>t <Plug>(go-test)
au FileType go nmap <leader>c <Plug>(go-coverage)
let g:go_list_type = "quickfix"
if has("win32")
        " vimproc seems to be broken on Windows
        let g:go#use_vimproc = 0
endif

"         *** FSharp
autocmd FileType fsharp setlocal sw=4
autocmd FileType fsharp setlocal sts=4

"         *** CSharp
let g:syntastic_cs_checkers = ['syntax', 'semantic', 'issues']

" Rust
let g:syntastic_rust_checkers = ['cargo']

" Clojure
let g:syntastic_clojure_checkers = ['eastwood']
let g:rainbow_active = 0
autocmd VimEnter *.clj RainbowToggleOn

" TSLIME
vmap <unique> <C-c><C-c> <Plug>SendSelectionToTmux
nmap <unique> <C-c><C-c> <Plug>NormalModeSendToTmux
nmap <unique> <C-c>r <Plug>SetTmuxVars

" VOoM
let g:voom_return_key = "<C-Return>"
let g:voom_tab_key = "<C-Tab>"

" KEEP THOSE AT THE BOTTOM
if has("win32")
        let s:localrc=$HOME."/vimfiles/vim_local"
else
        let s:localrc=$HOME."/.vim/vim_local"
endif
if filereadable(s:localrc)
        exec 'source ' . s:localrc
endif

syntax on
filetype plugin on
filetype indent on

set encoding=utf-8
set fileencoding=utf-8
