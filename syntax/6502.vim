if version < 600
        syntax clear
elseif exists("b:current_syntax")
        finish
endif

syn case ignore
syn keyword asm65Reg x y a

syn keyword asm65Op  adc and asl bit brk clc cld cli clv cmp cpx cpy dec dex dey eor inc inx iny  lda ldx ldy lsr nop ora pha php pla plp rol ror rti rts sbc sec sed sei sta stx sty tax tay tsx txa txs tya 
syn keyword asm65Branch bcc bcs beq bmi bne bpl bvc bvs jmp jsr

syn keyword asmMerlinPseudoOp equ hex dfb db ddb da dw adr adrl ds asc dci inv fls rev str strl
syn keyword asmMerlinMacro mac endm pmc
syn match asmMerlinMacro "^\s\+\zs<<<\ze\s"
syn match asmMerlinMacro "^\s\+\zs<<<\ze$"
syn match asmMerlinMacro "^\s\+\zs>>>\ze\s"
syn keyword asmMerlinConditional if else fin
syn match asmMerlinInclude "^\s*put\s.*$"
syn match asmMerlinInclude "^\s*putbin\s.*$"
syn match asmMerlinInclude "^\s*use\s.*$"
syn keyword asmMerlinEnd end
syn keyword asmMerlinMisc dum dend chk dat err
syn match asmMerlinVariable "\]\w\+"
syn keyword asmMerlinMandatory typ dsk

" Atari 800XL 'Sally' undocumented opcodes
" mnemonics taken from Trevin Beattie's 'Atari Technical Information' page
" at "http://www.xmission.com/~trevin/atari/atari.shtml"
syn keyword asmSallyUndoc anc arr asr asx ax7 axe brk dcp jam las lax php rla rra sax slo sre sx7 sy7 xea xs7

syn match asmLabel		"^[a-z_][a-z0-9_]*"
syn match asmComment		";.*"hs=s+1 contains=asmTodo
syn keyword asmTodo	contained todo fixme xxx warning danger note notice bug
syn region asmString		start=+"+ skip=+\\"+ end=+"+
syn keyword asmSettings		opt org

syn match decNumber	"\<\d\+\>"
syn match hexNumber	"\$\x\+\>" " 'bug', but adding \< doesn't behave!
syn match binNumber	"%[01]\+\>" 
syn match asmImmediate	"#\$\x\+\>"
syn match asmImmediate	"#\d\+\>"
syn match asmImmediate	"<\$\x\+\>"
syn match asmImmediate	"<\d\+\>"
syn match asmImmediate	">\$\x\+\>"
syn match asmImmediate	">\d\+\>"
syn match asmImmediate	"#<\$\x\+\>"
syn match asmImmediate	"#<\d\+\>"
syn match asmImmediate	"#>\$\x\+\>"
syn match asmImmediate	"#>\d\+\>"

let did_6502_syntax_inits = 1

hi link asmLabel	Label
hi link asmString	String
hi link asmComment	Comment
hi link asmSettings	Statement
hi link asm65Op Statement
hi link asmSallyUndoc Special
hi link asm65Reg Identifier
hi link asm65Branch Conditional
hi link asmTodo Debug

hi link asmImmediate Special

hi link asmMerlinPseudoOp Special
hi link asmMerlinMacro PreProc
hi link asmMerlinConditional Conditional
hi link asmMerlinInclude Include
hi link asmMerlinEnd Bold
hi link asmMerlinMisc Special
hi link asmMerlinVariable Identifier
hi link asmMerlinMandatory Bold

hi link hexNumber	Number
hi link binNumber	Number
hi link decNumber	Number


let b:current_syntax = "6502"
