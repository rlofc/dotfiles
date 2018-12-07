" tir_black color scheme
" Based on ir_black from: http://blog.infinitered.com/entries/show/8
" adds 256 color console support
" changed WildMenu color to be the same as PMenuSel

set background=dark
hi clear

if exists("syntax_on")
 syntax reset
endif

let colors_name = "darker-dreams"

" General colors
"hi Normal ctermfg=white ctermbg=NONE
hi Normal ctermfg=249 ctermbg=NONE
hi NonText ctermfg=232 ctermbg=NONE

hi Cursor ctermfg=0 ctermbg=15
hi LineNr ctermfg=239 ctermbg=none

hi VertSplit  ctermfg=235    ctermbg=235    cterm=NONE
hi StatusLine  ctermfg=235 ctermbg=254
hi StatusLineNC ctermfg=0 ctermbg=235 

hi Folded ctermfg=103 ctermbg=234
hi Title  ctermfg=187 cterm=bold
hi Visual ctermbg=60

hi SpecialKey ctermfg=8 ctermbg=236

hi WildMenu ctermfg=0 ctermbg=195
hi PmenuSbar ctermfg=0 ctermbg=15

"hi SpellBad  ctermfg=none ctermbg=52 cterm=none 
hi SpellBad  ctermfg=none ctermbg=52 cterm=underline 
hi SpellCap  ctermfg=none ctermbg=52 cterm=underline 
hi Error  ctermfg=203 ctermbg=none cterm=underline 
hi ErrorMsg  ctermfg=white ctermbg=203 cterm=bold
hi WarningMsg  ctermfg=white ctermbg=203 cterm=bold

hi ModeMsg  ctermfg=0 ctermbg=189 cterm=bold

if version >= 700 " Vim 7.x specific colors
 hi CursorLine  ctermbg=232 cterm=none
 hi CursorColumn  ctermbg=16 cterm=none
 hi MatchParen  ctermfg=200 ctermbg=16
 hi Pmenu ctermfg=white ctermbg=232
 hi PmenuSel ctermfg=0 ctermbg=195 
 hi Search ctermfg=none ctermbg=236 cterm=underline 
endif

" Syntax highlighting
hi Comment ctermfg=238
hi Atom ctermfg=155 
hi String ctermfg=203
hi Number ctermfg=198
" hi Number ctermfg=191

hi Keyword ctermfg=117 
hi PreProc ctermfg=117 
hi Conditional ctermfg=119 

hi Todo ctermfg=0 ctermbg=202 " 38
hi Constant ctermfg=151 

hi Identifier ctermfg=117 cterm=bold
hi Function ctermfg=255
hi Type ctermfg=221
hi cCustomClass ctermfg=248
hi cCustomFunc ctermfg=255
" hi Type ctermfg=228
"hi Type ctermfg=229 
"hi Statement ctermfg=208
hi Statement ctermfg=87

hi Special ctermfg=235 
hi Delimiter ctermfg=37 
hi Operator ctermfg=190
" hi Operator ctermfg=white 

hi link Character Constant
hi link Boolean Constant
hi link Float Number
hi link Repeat Statement
hi link Label Statement
hi link Exception Statement
hi link Include PreProc
hi link Define PreProc
hi link Macro PreProc
hi link PreCondit PreProc
hi link StorageClass Type
hi link Structure Type
hi link Typedef Type
hi link Tag Special
hi link SpecialChar Special
hi link SpecialComment Special
hi link Debug Special

" Special for XML
hi link xmlTag Keyword 
hi link xmlTagName Conditional 
hi link xmlEndTag Identifier 

" Special for HTML
hi link htmlTag Keyword 
hi link htmlTagName Conditional 
hi link htmlEndTag Identifier 

" Special for Javascript
hi link javaScriptNumber Number 

" GitGutter
hi SignColumn ctermfg=white ctermbg=NONE

" Testing new c syntax coloring scheme
"hi cUserFunction ctermfg=159
"hi cUserFunction ctermfg=230
hi cUserFunction ctermfg=255
"hi cOperator ctermfg=227
hi cOperator ctermfg=248
hi cCharacter ctermfg=222
hi cConstant ctermfg=159 cterm=bold
"hi cCppString ctermfg=116 ctermbg=234
hi cCppString ctermfg=109 ctermbg=234
hi cSpecial ctermfg=123 ctermbg=234
hi cIncluded ctermfg=219
hi cStatement ctermfg=190
"hi cStatement ctermfg=154
hi cStorageClass ctermfg=248
hi Function ctermfg=255
hi Delimiter ctermfg=248

hi luaFunctionBlock cterm=bold
