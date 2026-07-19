syntax on
filetype plugin indent on

set fileformat=unix
set fileformats=unix,dos
language en_US.UTF-8

if has('unix') && !has('linux') && !has('mac')
  let s:bsd=1
else
  let s:bsd=0
endif

"{{{ Local paths
if has("win32")
  let g:_myvim_configdir=$HOME . '/vimfiles'
  let g:_myvim_shell="pwsh -nol"
else
  let g:_myvim_configdir=$HOME . '/.vim'
  let g:_myvim_shell="bash"
endif
" The following setting is used in gvimrc => global
let g:_myvim_localdir=g:_myvim_configdir . '/local'
let s:scriptsdir=g:_myvim_configdir . '/scripts'
let s:pluginsdir=g:_myvim_localdir . '/plugged'
set colorcolumn=80

"}}}

"{{{1 General vim behaviour

if exists('+smoothscroll') " appeared in version 9.1
  set smoothscroll
endif

set termguicolors

" Sensible backspace
set backspace=indent,eol,start

" Always show signcolumn that the text does not jump when diagnostics appears
" or GitGutter is enabled
set signcolumn=yes

" I don't want no tab characters
set expandtab

" Search in all subdirectories
set path+=**

" Proper completion
set wildmode=longest:list

"{{{2 Information about files

" Remember marks in 1000 last files
" Remember up to 1000 lines per register
set viminfo='1000,<1000

" Permanent undo
set undofile
let &undodir=g:_myvim_localdir . "/undo"
try
  call mkdir(&undodir, "p")
catch /^Vim\%((\a\+)\)\=:E/
  echohl WarningMsg
  echom 'Warning: Could not create undo directory: ' .. &undodir
  echohl None
endtry
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
set cursorcolumn " better see cursor in terminal -- unset in gvimrc
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

execute "source " .. g:_myvim_configdir .. "/mappings.vim"
" text in Russian
let g:_myvim_rus_text_script = "source " . s:scriptsdir . "/rus_text.vim"
nnoremap <silent><unique> <Leader>rus :exec g:_myvim_rus_text_script<CR>
" text in English
let g:_myvim_eng_text_script = "source " . s:scriptsdir . "/eng_text.vim"
nnoremap <silent><unique> <Leader>eng :exec g:_myvim_eng_text_script<CR>
"}}}2

" For arrows up and down see Coc section

"}}}1

"{{{1 Plugins

" Load plugin configurations
execute "source " .. g:_myvim_configdir .. "/config/plugins.vim"

"{{{2 Vim-plug managed plugins
call plug#begin(s:pluginsdir)

Plug 'sheerun/vim-polyglot'
Plug 'thindil/a.vim'

"{{{3 Coc
Plug 'neoclide/coc.nvim', {'branch': 'release'}
execute "source " .. g:_myvim_configdir .. "/coc.vim"
"}}}3

Plug 'arcticicestudio/nord-vim' | Plug 'reedes/vim-colors-pencil' | Plug 'lifepillar/vim-solarized8' | Plug 'avysk/vim-msx-colors'

Plug 'vim-scripts/DrawIt'
Plug 'Konfekt/FastFold' | Plug 'tmhedberg/SimpylFold'
Plug 'airblade/vim-gitgutter', {'branch': 'main'}
Plug 'sbdchd/neoformat'
Plug 'kovisoft/paredit'
Plug 'unblevable/quick-scope'

"{{{3 Neural
if has('win32')
  " nothing
else
  Plug 'dense-analysis/neural'
  " API key setting in local vimrc => not published to git
endif
"}}}3

Plug 'preservim/tagbar', {'on': 'TagbarToggle'}
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
Plug 'unisonweb/unison', { 'branch': 'trunk', 'rtp': 'editor-support/vim' }
Plug 'avysk/vim-fortran-fpm' | Plug 'avysk/vim-fortran-fpm-msx'
Plug 'lambdalisue/vim-fullscreen'
Plug 'junegunn/vim-peekaboo'
Plug 'luochen1990/rainbow'
Plug 'jpalardy/vim-slime'
Plug 'tpope/vim-surround'
Plug 'gergap/vim-ollama'

"{{{3 vim-z80
Plug 'samsaga2/vim-z80'
execute "source " .. g:_myvim_configdir .. "/z80.vim"
"}}}3

Plug 'vimoutliner/vimoutliner'

"{{{3 vimwiki
Plug 'vimwiki/vimwiki'

nnoremap <F1> <Plug>VimwikiTabMakeDiaryNote
nnoremap <S-F1> <Plug>VimwikiDiaryIndex
nnoremap <leader><F1> <Plug>VimwikiDiaryIndex
"}}}3

"{{{3 zeavim
if executable('zeal')
  Plug 'KabbAmine/zeavim.vim'
endif
"}}}3

"{{{3 zig
if executable('zig')
  Plug 'https://codeberg.org/ziglang/zig.vim'
  " don't show parse errors in a separate window
  let g:zig_fmt_parse_errors = 0
  " disable format-on-save from `ziglang/zig.vim`
  let g:zig_fmt_autosave = 0
  augroup Zig
    autocmd!
    autocmd BufWritePre *.zig,*.zon call CocActionAsync('organizeImport')
  augroup END
endif

call plug#end()
"}}}2

"}}}1

"{{{1 Languages

"{{{2 FORTRAN
let fortran_free_source=1
let fortran_fold=1
let fortran_fold_conditionals=1
let fortran_fold_multilinecomments=1
let fortran_more_precise=1
let fortran_do_enddo=1
"}}}2

"{{{2 OCaml
if executable('opam')
  let g:ocaml_folding=1
  try
    let g:opamshare = trim(system('opam config var share'))
    if v:shell_error != 0
      echoerr 'Failed to get opam share directory'
    elseif executable('merlin')
      let l:merlin_path = g:opamshare .. '/merlin/vim'
      if isdirectory(l:merlin_path)
        execute 'set rtp+=' .. l:merlin_path
        " Update merlin documentation
        try
          execute 'helptags ' .. l:merlin_path .. '/doc'
        catch /^Vim\%((\a\+)\)\=:E/
          " Silently ignore helptags errors
        endtry
      endif
    endif
  catch /^Vim\%((\a\+)\)\=:E/
    echoerr 'Error initializing OCaml support: ' .. v:exception
  endtry
endif
"}}}2

"}}}1

" Validate dependencies at startup
call myvim_validate#ValidateAll()

"{{{1 Autocmd groups
execute "source " .. g:_myvim_configdir .. "/autocmd/general.vim"
execute "source " .. g:_myvim_configdir .. "/autocmd/formatting.vim"
execute "source " .. g:_myvim_configdir .. "/autocmd/colors.vim"
"}}}1

" Configure cursor appearance for different terminals
if &term =~# "-256color" || &term =~# 'win32'
  " Common cursor shape settings for all supported terminals
  let &t_SI .= "\<Esc>[6 q"  " Insert mode: vertical line
  let &t_EI .= "\<Esc>[2 q"  " Normal mode: solid block
  let &t_SR .= "\<Esc>[1 q"  " Replace mode: blinking block

  " Additional color settings for 256color terminals only
  if &term =~# "-256color"
    " Insert mode: green vertical line, Replace mode: blinking green block,
    " Normal mode: orange solid block
    let &t_SI = "\<Esc>]12;green\x7" .. &t_SI
    let &t_EI = "\<Esc>]12;orange\x7" .. &t_EI
    let &t_SR = "\<Esc>]12;green\x7" .. &t_SR
  endif
endif

packadd! termdebug

if !empty($TMUX)
  try
    const s:session = trim(system("tmux display-message -p '#{client_session}'"))
    if v:shell_error == 0
      colorscheme s:session =~# 'msx' ? 'msx' : 'nord'
    else
      set background=dark
      colorscheme nord
    endif
  catch /^Vim\%((\a\+)\)\=:E185/
    " Colorscheme not found, use default
    set background=dark
  endtry
else
  try
    set background=dark
    colorscheme solarized8_flat
  catch /^Vim\%((\a\+)\)\=:E185/
    " Colorscheme not found, use default
  endtry
endif

const s:localrc = g:_myvim_localdir .. '/vimrc'
if filereadable(s:localrc)
  try
    execute 'source ' .. s:localrc
  catch /^Vim\%((\a\+)\)\=:E/
    echohl ErrorMsg
    echom 'Error loading local vimrc: ' .. v:exception
    echohl None
  endtry
endif

augroup 6502
  autocmd!
  autocmd BufRead,BufNewFile *.S :set filetype=6502
augroup END

" vim:sw=2:sts=2:foldmethod=marker
