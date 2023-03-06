set clipboard^=unnamed
hi ColorColumn guibg=#252525

if has("gui_macvim")
        set background=light
        colorscheme macvim
        set macligatures
        set guifont=Fira\ Code\ Retina:h14
        set columns=164
        set lines=50
        set guioptions-=r
        set fuoptions=maxvert,maxhorz
        " The IM behaviour is too strange for my taste so
        set imdisable
        map <Leader>font :set guifont=Cousine:h16<C-M>

        amenu <silent> TouchBar.Light :set background=light<CR>
        amenu <silent> TouchBar.Dark :set background=dark<CR>
        amenu TouchBar.-space1- <Nop>
        amenu TouchBar.Lang.Eng :exec g:_myvim_eng_text_script<CR>
        amenu TouchBar.Lang.Rus :exec g:_myvim_rus_text_script<CR>
        amenu TouchBar.-flexspace1- <Nop>
        amenu TouchBar.Scratch :ScratchWindow<CR>
        amenu TouchBar.-space2- <Nop>
        amenu <silent> TouchBar.GitGutter :GitGutterToggle<CR>
        amenu <silent> TouchBar.Tagbar :Tagbar<CR>

endif

if has("gui_gtk3")
        set guioptions=aegimrLt
        set guioptions=aci
endif

if has("win32")
        set guifont=Iosevka:h14:cRUSSIAN:qDEFAULT
        set guioptions-=T
        set guioptions-=r
endif

if has("directx")
        set renderoptions=type:directx
endif

set columns=87

" I always want this in gui
set list
set listchars=tab:⇒…,trail:∴,extends:→,precedes:←,nbsp:·

" KEEP AT THE BOTTOM
let s:localrc = g:_myvim_localdir . "/gvimrc"
if filereadable(s:localrc)
  exec 'source ' . s:localrc
endif

" Maximize window if editing Python
autocmd FileType python if has('gui_running') | set lines=999 | set columns=999 | endif


" Control Left and Right to switch tabs
nnoremap <C-Left> gT
tnoremap <C-Left> gT
nnoremap <C-Right> gt
tnoremap <C-Right> gt
