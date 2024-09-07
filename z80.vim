" Changes for using asMSX as Z80 assembly
let s:template_dir = g:_myvim_configdir .. '/templates'
let s:msx_template = s:template_dir .. '/z80.asm'
augroup Templates
        au!
        autocmd FileType z80 execute "if !filereadable(expand('%')) | 0r " .. s:msx_template .. " | endif"
augroup END

augroup asMSX
        au!
        autocmd FileType z80 syn keyword z80PreProc .bios .biosvars .endm .msxdos .rom bios biosvars endm msxdos rom
        autocmd FileType z80 syn match z80Lbl "\.[A-Z_.?][A-Z_.?0-9]*:\="
        autocmd FileType z80 syn match z80Lbl "@@[A-Z_.?][A-Z_.?0-9]*:\="
        " Indirect register access
        autocmd FileType z80 syn region z80Reg start=/\[ix/ end=/\]/ keepend oneline contains=z80Lbl,z80Number,z80Reg,z80Other
        autocmd FileType z80 syn region z80Reg start=/\[iy/ end=/\]/ keepend oneline contains=z80Lbl,z80Number,z80Reg,z80Other
        autocmd FileType z80 syn match z80Reg "\[b\=c\]"
        autocmd FileType z80 syn match z80Reg "\[de\]"
        autocmd FileType z80 syn match z80Reg "\[hl\]"
        autocmd FileType z80 syn match z80Reg "\[sp\]"
        autocmd FileType z80 syn keyword Error '
        autocmd FileType z80 setlocal makeprg=asmsx\ %:S
        autocmd FileType z80 ++once nnoremap <F9> :make!<CR>
augroup END
