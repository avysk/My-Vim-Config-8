" Plugin configuration
" This file contains all plugin g: variable settings extracted from vimrc
" for better organization and maintainability.

"{{{ Completion and LSP
" coc.nvim configurations are in coc.vim (separate file)
"}}}

"{{{ Formatting and Code Style
" Neoformat
let g:neoformat_enabled_cs = ["csharpier"]
let g:neoformat_for_filetypes = ["cs", "fortran"]
"}}}

"{{{ Language Support
" vim-polyglot
let g:polyglot_disabled = ['sensible']
"}}}

"{{{ Code Folding
" FastFold
let g:fastfold_minlines = 0
"}}}

"{{{ Git Integration
" GitGutter - disabled by default, toggle with mapping
let g:gitgutter_enabled=0
"}}}

"{{{ Lisp Editing
" paredit
let g:paredit_electric_return = 1
let g:paredit_shortmaps = 1
"}}}

"{{{ Navigation and Search
" Quickscope - highlight targets for f and F
let g:qs_highlight_on_keys = ['f', 'F']
"}}}

"{{{ Snippets
" UltiSnips
let g:UltiSnipsEditSplit="context"
let g:UltiSnipsExpandTrigger="<Right>"
let g:UltiSnipsListSnippets="<Left>"
let g:UltiSnipsJumpForwardTrigger="<Down>"
let g:UltiSnipsJumpBackwardTrigger="<Up>"
"}}}

"{{{ Visual Enhancements
" vim-rainbow - colorful bracket highlighting
let g:rainbow_active = 1
"}}}

"{{{ REPL and Terminal Integration
" vim-slime - send code to terminal
let g:slime_target = "vimterminal"
let g:slime_vimterminal_config = {"term_finish": "close", "vertical": 1}
let g:slime_vimterminal_cmd = g:_myvim_shell
"}}}

"{{{ Note Taking and Wiki
" vimwiki
let g:vimwiki_list = [
      \ {'path': '~/OneDrive/vimwiki', 'list_margin': 2},
      \ {'path': '~/vimwiki', 'list_margin': 2} ]
let g:vimwiki_ext2syntax = {}
let g:vimwiki_folding = 'syntax'
"}}}

"{{{ Debugging
" termdebug - wide layout for debugging
let g:termdebug_wide = 1
"}}}
