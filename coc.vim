" Settings for coc.nvim extension
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

" Make <C-a> to accept selected completion item
inoremap <silent><expr> <C-a> coc#pum#visible() ? coc#pum#confirm() : "<C-a>"
" Same for control-space
inoremap <silent><expr> <C-@> coc#pum#visible() ? coc#pum#confirm() : "<C-@>"
" Same for shift-right arrow
inoremap <silent><expr> <S-Right> coc#pum#visible() ? coc#pum#confirm() : "<S-Right>"
" Same for keypad insert
inoremap <silent><expr> <kInsert> coc#pum#visible() ? coc#pum#confirm() : "<kInsert>"

" Alt-Space on Windows
if has('win32')
  inoremap <silent><expr>   coc#pum#visible() ? coc#pum#confirm() : " "
endif


function! WrapLocation(where)
  if !exists('b:we_have_coc_list')
    execute 'CocDiagnostics'
    execute 'lclose'
    try
      execute 'lfirst'
      let b:we_have_coc_list = 'yes'
    catch /E42/
      echo 'No errors.'
    endtry
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

augroup CocHelper
  autocmd!
  autocmd TextChanged * if exists("b:we_have_coc_list") | unlet b:we_have_coc_list | endif
augroup END


nnoremap <silent><unique> <Up> :call WrapLocation('up')<CR>
nnoremap <silent><unique> <Down> :call WrapLocation('down')<CR>
nnoremap <silent><unique> <Left> :CocCommand<CR>

" These are straight from documentation but I do not think they work. At
" least, not for Python.
nnoremap <silent><unique> [g <Plug>(coc-diagnostic-prev)
nnoremap <silent><unique> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation
nnoremap <silent><unique> gd <Plug>(coc-definition)
nnoremap <silent><unique> gy <Plug>(coc-type-definition)
nnoremap <silent><unique> gi <Plug>(coc-implementation)
nnoremap <silent><unique> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent><unique> K :call ShowDocumentation()<CR>

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
nnoremap <leader>rn <Plug>(coc-rename)

" Remap keys for applying code actions at the cursor position
nnoremap <leader>ac  <Plug>(coc-codeaction-cursor)
" Remap keys for apply code actions affect whole buffer
nnoremap <leader>as  <Plug>(coc-codeaction-source)

" Remap keys for applying refactor code actions
nnoremap <silent><unique> <leader>re <Plug>(coc-codeaction-refactor)
nnoremap <silent><unique> <leader>r  <Plug>(coc-codeaction-refactor-selected)

" Run the Code Lens action on the current line
nnoremap <leader>cl  <Plug>(coc-codelens-action)

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
nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"

" Use CTRL-S for selections ranges
" Requires 'textDocument/selectionRange' support of language server
nnoremap <silent><unique> <C-s> <Plug>(coc-range-select)
xmap <silent><unique> <C-s> <Plug>(coc-range-select)

let g:coc_global_extensions = ['coc-clojure', 'coc-json', 'coc-lists', 'coc-omni', 'coc-pyright', 'coc-rust-analyzer', 'coc-sh', 'coc-syntax', 'coc-toml', 'coc-ultisnips', 'coc-vimlsp', 'coc-word']
nnoremap <Leader>bb :CocList buffers<CR>
nnoremap <Leader>ff :CocList --auto-preview files<CR>
