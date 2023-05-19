set fileformat=unix
set fileformats=unix,dos
language en_US.UTF-8

"{{{ Local paths
if has("win32")
  let g:_myvim_configdir=$HOME . '/vimfiles'

  set shell=pwsh\ -nop\ -nol
  set shellcmdflag=-c
else
  let g:_myvim_configdir=$HOME . '/.vim'
endif
let g:_myvim_localdir=g:_myvim_configdir . '/local'
let s:scriptsdir=g:_myvim_configdir . '/scripts'
let s:pluginsdir=g:_myvim_localdir . '/plugged'
set colorcolumn=80

"}}}

"{{{1 General vim behaviour

" Always show signcolumn that the text does not jump when diagnostics appears
" or GitGutter is enabled
set signcolumn=yes

" I don't want no tab characters
set expandtab

" Search in all subdirectories
set path+=**

" Proper completion
set wildmode=list,longest

"{{{2 Information about files

" Remember marks in 1000 last files
" Remember up to 1000 lines per register
set viminfo='1000,<1000

" Permanent undo
set undofile
let &undodir=g:_myvim_localdir . "/undo"
call mkdir(&undodir, "p")
set undolevels=5000
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

set list
set listchars=tab:⇒⋄,trail:∴,extends:→,precedes:←,nbsp:·
set ruler
set laststatus=2
set showcmd
"}}}1

"{{{1 Bindings

"{{{2 Use space for leader
let g:mapleader = ' '
"}}}2

"{{{2 Use double comma for local leader
let g:maplocalleader = ',,'
"}}}2

"{{{2 Shortcut for terminal
if has('win32')
  nnoremap <silent> <LocalLeader>T :tab terminal ++close pwsh -nol<CR>
else
  nnoremap <silent> <LocalLeader>T :tab terminal<CR>
endif
"}}}

"{{{2 Switching to writing mode
" text in Russian
let g:_myvim_rus_text_script = "source " . s:scriptsdir . "/rus_text.vim"
nnoremap <silent> <Leader>rus :exec g:_myvim_rus_text_script<CR>
" text in English
let g:_myvim_eng_text_script = "source " . s:scriptsdir . "/eng_text.vim"
nnoremap <silent> <Leader>eng :exec g:_myvim_eng_text_script<CR>
"}}}2

"{{{2 Remapping
" PgDown to drop search highlighting
nnoremap <PageDown> :nohl<CR>
nnoremap <silent><nowait> <Leader>nh :nohl<CR>
inoremap <PageDown> <C-O>:nohl<CR>
" PgUp to go to alternate file
nnoremap <PageUp> <C-^>
inoremap <PageUp> <C-O><C-^>
" For arrows up and down see Coc section
"}}}2

"{{{2 Saving files
nnoremap <unique> <F2> :w<CR>
inoremap <unique> <F2> <C-\><C-O>:w<CR>
"}}}2

"{{{2 Closing and opening folders
nnoremap <unique> <F7> zM
nnoremap <unique> <F8> zR
"}}}2

"{{{2 Exiting vim
nnoremap <unique> <F10> :x<CR>
nnoremap <unique> <Leader><F4> :qa!<CR>
"}}}2

"{{{2 Pasting in terminal
tnoremap <S-Insert> <C-W>"+
"

"{{{2 Terminal Control Left and Right to switch tabs
nnoremap [1;5D gT
tnoremap [1;5D gT
nnoremap [1;5C gt
tnoremap [1;5C gt
"}}}2

"{{{2 Launch clisp in a tab
autocmd FileType lisp nnoremap <LocalLeader>rr :tab terminal ++close clisp<CR>
"}}}2

"{{{2 If editing src/*.rs or tests/*.rs, add shortcut to open terminal in the
" project directory
autocmd BufReadPost src/*.rs nnoremap <silent><unique> <LocalLeader>rr :let $projectdir=expand('%:p:h:h')<CR>:tab terminal ++close<CR> cd "$projectdir"<CR>
autocmd BufReadPost tests/*.rs nnoremap <LocalLeader>rr <silent><unique> :let $projectdir=expand('%:p:h:h')<CR>:tab terminal ++close ++kill='term'<CR>cd "$projectdir"<CR>
"}}}2

"}}}1

"{{{1 Plugins

"{{{2 Vim-plug managed plugins
call plug#begin(s:pluginsdir)

"{{{3 vim-polyglot
Plug 'sheerun/vim-polyglot'
" Prevent vim-polyglot from breaking votl filetype detect
let g:polyglot_disabled = ['ftdetect']
"}}}3

"{{{3 Coc
Plug 'neoclide/coc.nvim', {'branch': 'release'}

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1] =~ '\s'
endfunction

" Use tab for trigger completion with characters ahead
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <C-h> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo
inoremap <silent><expr> <C-h> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! WrapLocation(where)
  if !exists('b:we_have_coc_list')
    execute 'CocDiagnostics'
    execute 'lclose'
    let b:we_have_coc_list = 'yes'
    execute 'lfirst'
    return
  endif
  if a:where == 'up'
    try
      execute 'lprevious'
    catch /E553/
      execute 'llast'
    endtry
  else
    try
      execute 'lnext'
    catch /E553/
      execute 'lfirst'
    endtry
  endif
endfunction

nmap <silent> <Up> :call WrapLocation('up')<CR>
nmap <silent> <Down> :call WrapLocation('down')<CR>
nmap <silent> <Left> :CocCommand<CR>

" These are straight from documentation but I do not think they work. At
" least, not for Python.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming
nmap <leader>rn <Plug>(coc-rename)

" Remap keys for applying code actions at the cursor position
nmap <leader>ac  <Plug>(coc-codeaction-cursor)
" Remap keys for apply code actions affect whole buffer
nmap <leader>as  <Plug>(coc-codeaction-source)
" Apply the most preferred quickfix action to fix diagnostic on the current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Remap keys for applying refactor code actions
nmap <silent> <leader>re <Plug>(coc-codeaction-refactor)
nmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)

" Run the Code Lens action on the current line
nmap <leader>cl  <Plug>(coc-codelens-action)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> to scroll float windows/popups
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges
" Requires 'textDocument/selectionRange' support of language server
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Some commands for showing files and buffers
nnoremap <Leader>bb :CocList buffers<CR>
nnoremap <Leader>ff :CocList --auto-preview files<CR>

let g:coc_global_extensions = ['coc-clojure', 'coc-json', 'coc-lists', 'coc-omni', 'coc-pyright', 'coc-rust-analyzer', 'coc-sh', 'coc-syntax', 'coc-toml', 'coc-ultisnips', 'coc-word']
"}}}3

"{{{3 Colorschemes
Plug 'reedes/vim-colors-pencil' | Plug 'lifepillar/vim-solarized8'
"}}}3

"{{{3 DrawIt
Plug 'vim-scripts/DrawIt'
"}}}

"{{{3 FastFold + SimpylFold
Plug 'Konfekt/FastFold' | Plug 'tmhedberg/SimpylFold'
let g:fastfold_minlines = 0
"}}}3

"{{{3 GitGutter
Plug 'airblade/vim-gitgutter'
" faster realtime updates
" set updatetime=300
let g:gitgutter_enabled=0
nnoremap <silent><nowait> <Leader>gg :GitGutterBufferToggle<CR>
"}}}3

"{{{3 Neoformat
let g:neoformat_for_filetypes = ["cs", "fortran"]
function! MaybeRunNeoformat()
  if index(g:neoformat_for_filetypes, &filetype) >= 0
    execute "Neoformat"
  endif
endfunction

Plug 'sbdchd/neoformat'
augroup fmt
  autocmd!
  autocmd BufWritePre * call MaybeRunNeoformat()
augroup end
"}}}3

"{{{3 paredit
let g:paredit_electric_return = 1
let g:paredit_shortmaps = 1
Plug 'kovisoft/paredit'
"}}}3

"{{{3 Quickscope
Plug 'unblevable/quick-scope'
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']
"}}}3

"{{{3 Neural
if has('win32')
  " nothing
else
  Plug 'dense-analysis/neural'
  " API key setting in local vimrc => not published to git
endif
"}}}3

"{{{3 tagbar
Plug 'preservim/tagbar', {'on': 'TagbarToggle'}
nmap <F12> :TagbarToggle<CR>
"}}}

"{{{3 Ultisnips + vim-snippets
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
let g:UltiSnipsEditSplit="context"
let g:UltiSnipsExpandTrigger="<Right>"
let g:UltiSnipsListSnippets="<Left>"
let g:UltiSnipsJumpForwardTrigger="<Down>"
let g:UltiSnipsJumpBackwardTrigger="<Up>"
"}}}3

"{{{3 vim-peekaboo
Plug 'junegunn/vim-peekaboo'
"}}}3

"{{{3 vim-rainbow
Plug 'frazrepo/vim-rainbow'
let g:rainbow_active = 1
"}}}3

"{{{3 vim-slime
Plug 'jpalardy/vim-slime'
let g:slime_target = "vimterminal"
let g:slime_vimterminal_config = {"term_finish": "close", "vertical": 1}
"}}}3

"{{{3 vimoutliner
Plug 'vimoutliner/vimoutliner'
autocmd FileType votl setlocal listchars=tab:\ \ ,trail:∴,extends:→,precedes:←,nbsp:·
"}}}

"{{{3 vimwiki
Plug 'vimwiki/vimwiki'
let g:vimwiki_list = [
      \ {'path': '~/OneDrive/vimwiki', 'list_margin': 2},
      \ {'path': '~/vimwiki', 'list_margin': 2} ]

let g:vimwiki_ext2syntax = {}
let g:vimwiki_folding = 'syntax'

nmap <leader>tt <Plug>VimwikiToggleListItem
autocmd FileType vimwiki setlocal tw=80
autocmd FileType vimwiki setlocal nowrap
autocmd FileType vimwiki setlocal foldmethod=syntax
autocmd FileType vimwiki setlocal foldlevel=2

nmap <F1> <Plug>VimwikiTabMakeDiaryNote
nmap <S-F1> <Plug>VimwikiDiaryIndex
nmap <leader><F1> <Plug>VimwikiDiaryIndex

" Something is broken in my setup
autocmd FileType vimwiki syntax off
autocmd FileType vimwiki syntax on

"}}}3

call plug#end()
"}}}2

"}}}1

"{{{1 Languages

"{{{2 C#
" Make it agree with CSharpier
autocmd FileType cs setlocal colorcolumn=100
"}}}2

"{{{2 FORTRAN
let fortran_free_source=1
let fortran_fold=1
let fortran_fold_conditionals=1
let fortran_fold_multilinecomments=1
let fortran_more_precise=1
let fortran_do_enddo=1
"}}}2

"{{{2 Python
autocmd FileType python setlocal shiftwidth=4
" For documentation.
autocmd FileType python setlocal colorcolumn+=72

function PythonTestFile()
  let mybufname = bufname()
  set shellslash
  let myfilename = fnamemodify(mybufname, ':t')
  let mydirname = fnamemodify(mybufname, ':.:s?^./??:h')
  let testdirname = substitute(mydirname, '[^/]\+', 'tests', '')
  let testname = testdirname .. '/test_' .. myfilename
  let testbufname=bufname("^" .. testname .. '$')
  if testbufname == ''
    silent execute ':e ' .. testname
  else
    silent execute ':sb ' .. testname
  endif
endfunction
" Switch to test file
autocmd FileType python nnoremap <silent> <LocalLeader>t :call PythonTestFile()<CR>
" Go back
autocmd FileType python nnoremap <silent> <LocalLeader>b :silent execute ':sb ' . substitute(expand('%:t'), '^test_', '/', '')<CR>

"}}}2

"{{{2 OCaml
if has("win32")
  " Nothing
else
  let g:ocaml_folding=1
  let g:opamshare = substitute(system('opam config var share'),'\n$','','''')

  execute "set rtp+=" . g:opamshare . "/merlin/vim"
  " Update merlin documentation
  execute "helptags " . g:opamshare . "/merlin/vim/doc"

  autocmd FileType ocaml iabbrev <buffer> _ML (*<C-M><BS><BS>vim:sw=2<C-M>*)
  autocmd FileType ocaml setlocal tw=0
  autocmd FileType ocaml setlocal shiftwidth=2

  function Reformat()
    let curpos = getcurpos()
    execute "w"
    silent execute "! [[ -a .ocamlformat ]] || touch .ocamlformat"
    silent execute "%!ocamlformat '%'"
    call setpos('.', curpos)
  endfunction

autocmd FileType ocaml nnoremap <silent><unique> <LocalLeader>f :call Reformat()<CR>

endif
"}}}2

"{{{2 Prolog
autocmd BufNew,BufNewFile,BufRead *.pl setlocal ft=prolog | syntax on
"}}}2

"{{{2 Rust
" Rust coding style document says so.
autocmd FileType rust setlocal colorcolumn=100
autocmd FileType rust setlocal shiftwidth=4
"}}}2

"}}}1

autocmd FileType make setlocal tabstop=8
autocmd FileType make setlocal listchars=tab:⇒\ ,trail:∴,extends:→,precedes:←,nbsp:·

" KEEP THOSE AT THE BOTTOM
let s:localrc = g:_myvim_localdir . "/vimrc"
if filereadable(s:localrc)
  exec 'source ' . s:localrc
endif

syntax on
filetype plugin on
filetype indent on

let s:localconsolecolor = g:_myvim_localdir . "/vimrc-colors"
if filereadable(s:localconsolecolor)
  exec 'source ' . s:localconsolecolor
endif

" vim:sw=2:sts=2:foldmethod=marker
