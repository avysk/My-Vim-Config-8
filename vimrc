syntax on
filetype plugin indent on

set fileformat=unix
set fileformats=unix,dos
language en_US.UTF-8

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

"{{{2 Vim-plug managed plugins
call plug#begin(s:pluginsdir)

Plug 'junegunn/vader.vim'

"{{{3 vim-polyglot
let g:polyglot_disabled = ['sensible']
Plug 'sheerun/vim-polyglot'
"}}}3

"{{{3 Coc
Plug 'neoclide/coc.nvim', {'branch': 'release'}
execute "source " .. g:_myvim_configdir .. "/coc.vim"
"}}}3

"{{{3 Colorschemes
Plug 'arcticicestudio/nord-vim' | Plug 'reedes/vim-colors-pencil' | Plug 'lifepillar/vim-solarized8' | Plug 'avysk/vim-msx-colors'
"}}}3

"{{{3 copilot
Plug 'github/copilot.vim', { 'tag': '*' }
"}}}3

"{{{3 DrawIt
Plug 'vim-scripts/DrawIt'
"}}}

"{{{3 FastFold + SimpylFold
Plug 'Konfekt/FastFold' | Plug 'tmhedberg/SimpylFold'
let g:fastfold_minlines = 0
"}}}3

"{{{3 GitGutter
Plug 'airblade/vim-gitgutter', {'branch': 'main'}
" faster realtime updates
" set updatetime=300
let g:gitgutter_enabled=0
"}}}3

"{{{3 Neoformat
let g:neoformat_enabled_cs = ["csharpier"]
let g:neoformat_for_filetypes = ["cs", "fortran"]

function! MaybeRunNeoformat()
  if index(g:neoformat_for_filetypes, &filetype) >= 0
    execute "undojoin | Neoformat"
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
let g:qs_highlight_on_keys = ['f', 'F']
augroup QuickscopeColors
  au!
  au ColorScheme * hi! QuickScopePrimary cterm=reverse gui=reverse
  au ColorScheme * hi! QuickScopeSecondary cterm=underline gui=underline
augroup END
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
"}}}

"{{{3 Ultisnips + vim-snippets
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
let g:UltiSnipsEditSplit="context"
let g:UltiSnipsExpandTrigger="<Right>"
let g:UltiSnipsListSnippets="<Left>"
let g:UltiSnipsJumpForwardTrigger="<Down>"
let g:UltiSnipsJumpBackwardTrigger="<Up>"
"}}}3

"{{{3 Unison
Plug 'unisonweb/unison', { 'branch': 'trunk', 'rtp': 'editor-support/vim' }
"}}}3

"{{{3 vim-fortran-fpm{,-msx}
Plug 'avysk/vim-fortran-fpm' | Plug 'avysk/vim-fortran-fpm-msx'
"}}}3

"{{{3 vim-fullscreen
Plug 'lambdalisue/vim-fullscreen'
"}}}3

"{{{3 vim-peekaboo
Plug 'junegunn/vim-peekaboo'
"}}}3

"{{{3 vim-rainbow
Plug 'luochen1990/rainbow'
let g:rainbow_active = 1
"}}}3

"{{{3 vim-slime
Plug 'jpalardy/vim-slime'
let g:slime_target = "vimterminal"
let g:slime_vimterminal_config = {"term_finish": "close", "vertical": 1}
let g:slime_vimterminal_cmd = g:_myvim_shell
"}}}3

"{{{3 vim-surround
Plug 'tpope/vim-surround'
"}}}3

"{{{3 vim-z80
Plug 'samsaga2/vim-z80'
execute "source " .. g:_myvim_configdir .. "/z80.vim"
"}}}3

"{{{3 vimoutliner
Plug 'vimoutliner/vimoutliner'
"}}}

"{{{3 vimwiki
Plug 'vimwiki/vimwiki'
let g:vimwiki_list = [
      \ {'path': '~/OneDrive/vimwiki', 'list_margin': 2},
      \ {'path': '~/vimwiki', 'list_margin': 2} ]

let g:vimwiki_ext2syntax = {}
let g:vimwiki_folding = 'syntax'

autocmd FileType vimwiki setlocal tw=80
autocmd FileType vimwiki setlocal nowrap
autocmd FileType vimwiki setlocal foldmethod=syntax
autocmd FileType vimwiki setlocal foldlevel=2

autocmd FileType vimwiki ++once nnoremap <unique><silent> <leader>tt <Plug>VimwikiToggleListItem

nnoremap <F1> <Plug>VimwikiTabMakeDiaryNote
nnoremap <S-F1> <Plug>VimwikiDiaryIndex
nnoremap <leader><F1> <Plug>VimwikiDiaryIndex
"}}}3

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
if has("win32") || exists('$NO_OCAML_IN_VIM')
  " Nothing
else
  let g:ocaml_folding=1
  let g:opamshare = substitute(system('opam config var share'),'\n$','','''')

  execute "set rtp+=" . g:opamshare . "/merlin/vim"
  " Update merlin documentation
  execute "helptags " . g:opamshare . "/merlin/vim/doc"

endif
"}}}2

"}}}1

augroup Makefile
  autocmd!
  autocmd FileType make setlocal tabstop=8
  autocmd FileType make setlocal listchars=tab:⇒\ ,trail:∴,extends:→,precedes:←,nbsp:·
augroup end

augroup Outliner
  autocmd!
  au BufReadPost *.otl setf votl
  au FileType votl setlocal listchars=tab:\ \ ,trail:∴,extends:→,precedes:←,nbsp:·
augroup end

" Configure cursor appearance for different terminals
if &term =~ "-256color" || &term =~ 'win32'
  " Common cursor shape settings for all supported terminals
  let &t_SI .= "\<Esc>[6 q"  " Insert mode: vertical line
  let &t_EI .= "\<Esc>[2 q"  " Normal mode: solid block
  let &t_SR .= "\<Esc>[1 q"  " Replace mode: blinking block

  " Additional color settings for 256color terminals only
  if &term =~ "-256color"
    " Insert mode: green vertical line, Replace mode: blinking green block,
    " Normal mode: orange solid block
    let &t_SI = "\<Esc>]12;green\x7" . &t_SI
    let &t_EI = "\<Esc>]12;orange\x7" . &t_EI
    let &t_SR = "\<Esc>]12;green\x7" . &t_SR
  endif

  " Make sure that at start the cursor is orange block
  autocmd VimEnter * normal! :startinsert :stopinsert
endif

packadd! termdebug
let g:termdebug_wide = 1
augroup TermdebugColors
  autocmd!
  autocmd Colorscheme * hi! link debugPC PmenuSbar
  autocmd Colorscheme * hi! link debugBreakpoint WarningMsg
augroup end

if !empty($TMUX)
  let s:session = system("tmux display-message -p '#{client_session}'")
  if s:session =~ "msx"
    " In tmux 'msx' session I want to use 'msx' colorscheme
    colorscheme msx
    " And now fix coc.nvim menu highlight which will be broken
    augroup FixCoc
      autocmd!
      au BufEnter * hi CocMenuSel ctermbg=7 guibg=#3AA241
    augroup END
  else
    colorscheme nord
  endif
else
  set background=dark
  colorscheme solarized8_flat
endif

augroup c_header
  autocmd!
  au BufNewFile *.h let b:guard = toupper(expand('%:t:r'))..'_H' | call setline (1, ['#ifndef '..b:guard, '#define '..b:guard, '', '#endif // '..b:guard]) | 3 | startinsert
augroup END

let s:localrc = g:_myvim_localdir . "/vimrc"
if filereadable(s:localrc)
  exec 'source ' . s:localrc
endif

augroup FixRainbow
  autocmd!
  au BufEnter * execute 'colorscheme ' .. g:colors_name
  au BufEnter * RainbowToggleOn
augroup END

" vim:sw=2:sts=2:foldmethod=marker
