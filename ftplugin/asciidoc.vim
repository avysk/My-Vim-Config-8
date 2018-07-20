" Asciidoc support by Alexey Vyskubov <alexey@ocaml.nl>
" v0.1 created 9.01.2015
"
let b:did_ftplugin=1

if !exists("no_plugin_maps") && !exists("no_asciidoc_maps")
  nnoremap <Leader>r gq}
endif

setlocal autoindent expandtab tabstop=8 softtabstop=2 shiftwidth=2
setlocal textwidth=78 colorcolumn=80 wrap formatoptions=tcqn
setlocal formatlistpat=^\\s*\\d\\+\\.\\s\\+\\\\|^\\s*<\\d\\+>\\s\\+\\\\|^\\s*[a-zA-Z.]\\.\\s\\+\\\\|^\\s*[ivxIVX]\\+\\.\\s\\+
setlocal comments=s1:/*,ex:*/,://,b:#,:%,:XCOMM,fb:-,fb:*,fb:+,fb:.,fb:>
setlocal spell
setlocal spelllang=en_us
setlocal linebreak

setlocal foldmethod=marker

" Unfortunately global
set showbreak=.\ \ 
set display+=lastline
