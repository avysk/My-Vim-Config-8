" Mappings

let g:mapleader = ' '
let g:maplocalleader = ',,'
noremap <silent><unique><nowait> <Leader>T :execute "tab terminal ++close ++kill='term' " . g:_myvim_shell<CR>
nnoremap <silent><unique><nowait> <PageDown> :nohl<CR>
nnoremap <silent><unique><nowait> <Leader>nh :nohl<CR>
inoremap <silent><unique><nowait> <PageDown> <C-\><C-O>:nohl<CR>
nnoremap <silent><unique><nowait> <PageUp> <C-^>
inoremap <silent><unique><nowait> <PageUp> <C-\><C-O><C-^>
" Do not enter ex mode by acident
nnoremap <silent><unique><nowait> Q :
nnoremap <unique><nowait> <Leader>; :
nnoremap <silent><unique><nowait> <Leader>q :q<CR>
nnoremap <silent><unique><nowait> <Leader>x :x<CR>
nnoremap <silent><unique><nowait> <F2> :w<CR>
inoremap <silent><unique><nowait> <F2> <C-\><C-O>:w<CR>
nnoremap <silent><unique><nowait> <F7> zM
nnoremap <silent><unique><nowait> <F8> zR
nnoremap <silent><unique><nowait> <F10> :x<CR>
nnoremap <silent><unique><nowait> <Leader><F4> :qa!<CR>
tnoremap <silent><unique><nowait> <S-Insert> <C-W>"+
"Control Left and Right to switch tabs
nnoremap <silent><unique><nowait> <C-Left> gT
inoremap <silent><unique><nowait> <C-Left> <C-\><C-O>:tabp<CR>
tnoremap <silent><unique><nowait> <C-Left> gT
nnoremap <silent><unique><nowait> <C-Right> gt
inoremap <silent><unique><nowait> <C-Right> <C-\><C-O>:tabn<CR>
tnoremap <silent><unique><nowait> <C-Right> gt
nnoremap <silent><unique><nowait> <Leader>cn :set background=dark<CR>:colorscheme nord<CR>
nnoremap <silent><unique><nowait> <Leader>gg :GitGutterBufferToggle<CR>
nnoremap <silent><unique><nowait> <Leader>cp :set background=dark<CR>:colorscheme pencil<CR>
nnoremap <silent><unique><nowait> <Leader>cip :set background=light<CR>:colorscheme pencil<CR>
nnoremap <silent><unique><nowait> <Leader>cs :set background=dark<CR>:colorscheme solarized8_flat<CR>
nnoremap <silent><unique><nowait> <Leader>cis :set background=light<CR>:colorscheme solarized8_flat<CR>
nnoremap <silent><unique><nowait> <Leader>cm :colorscheme msx<CR>
nnoremap <silent><unique><nowait> <F12> :TagbarToggle "fc"<CR>
nnoremap <silent><unique><nowait> <Right> :TagbarToggle "fc"<CR>
