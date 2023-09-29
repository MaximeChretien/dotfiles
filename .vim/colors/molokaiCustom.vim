" Vim color file
"
" Edited By: Scott Linder <scott@scottlinder.com>
" https://github.com/scott-linder/molokai
"
" Original Author: Tomas Restrepo <tomas@winterdom.com>
" https://github.com/tomasr/molokai
"
" Note: Based on the Monokai theme for TextMate
" by Wimer Hazenberg and its darker variant
" by Hamish Stuart Macpherson
"

hi clear

if version > 580
    " no guarantees for version 5.8 and below, but this makes it stop
    " complaining
    hi clear
    if exists("syntax_on")
        syntax reset
    endif
endif
let g:colors_name="molokaiCustom"

"
" Support for 256-color terminal
"
hi Normal          ctermfg=252 ctermbg=235
hi CursorLine                  ctermbg=236   cterm=none
hi CursorLineNr    ctermfg=208               cterm=none

hi Boolean         ctermfg=141
hi Character       ctermfg=222
hi Number          ctermfg=141
hi String          ctermfg=222
hi Conditional     ctermfg=197               cterm=bold
hi Constant        ctermfg=141               cterm=bold

hi DiffDelete      ctermfg=125 ctermbg=233

hi Directory       ctermfg=154               cterm=bold
hi Error           ctermfg=222 ctermbg=233
hi Exception       ctermfg=154               cterm=bold
hi Float           ctermfg=141
hi Function        ctermfg=154
hi Identifier      ctermfg=208

hi Keyword         ctermfg=197               cterm=bold
hi Operator        ctermfg=197
hi PreCondit       ctermfg=154               cterm=bold
hi PreProc         ctermfg=154
hi Repeat          ctermfg=197               cterm=bold

hi Statement       ctermfg=197               cterm=bold
hi Tag             ctermfg=197
hi Title           ctermfg=203
hi Visual                      ctermbg=238

hi Comment         ctermfg=244
hi LineNr          ctermfg=239 ctermbg=235
hi NonText         ctermfg=239
hi SpecialKey      ctermfg=239

hi MatchParen                   ctermbg=208 cterm=bold
hi ModeMsg         ctermfg=229
hi MoreMsg         ctermfg=229
hi Operator        ctermfg=161

" complete menu
hi Pmenu           ctermfg=81  ctermbg=16
hi PmenuSel        ctermfg=255 ctermbg=242
hi PmenuSbar                   ctermbg=232
hi PmenuThumb      ctermfg=81

hi PreCondit       ctermfg=118               cterm=bold
hi PreProc         ctermfg=118
hi Question        ctermfg=81
hi Repeat          ctermfg=161               cterm=bold
hi Search          ctermfg=0   ctermbg=222   cterm=NONE

" marks column
hi SignColumn      ctermfg=118 ctermbg=235
hi SpecialChar     ctermfg=161               cterm=bold
hi SpecialComment  ctermfg=245               cterm=bold
hi Special         ctermfg=81
if has("spell")
   hi SpellBad                ctermbg=52
   hi SpellCap                ctermbg=17
   hi SpellLocal              ctermbg=17
   hi SpellRare  ctermfg=none ctermbg=none  cterm=reverse
endif
hi Statement       ctermfg=161               cterm=bold
hi StatusLine      ctermfg=238 ctermbg=253
hi StatusLineNC    ctermfg=244 ctermbg=232
hi StorageClass    ctermfg=208
hi Structure       ctermfg=81
hi Tag             ctermfg=161
hi Title           ctermfg=166
hi Todo            ctermfg=231 ctermbg=232   cterm=bold

hi Typedef         ctermfg=81
hi Type            ctermfg=81                cterm=none
hi Underlined      ctermfg=244               cterm=underline

hi VertSplit       ctermfg=244 ctermbg=232   cterm=bold
hi VisualNOS                   ctermbg=238
hi Visual                      ctermbg=238
hi WarningMsg      ctermfg=231 ctermbg=238   cterm=bold
hi WildMenu        ctermfg=81  ctermbg=16

hi Comment         ctermfg=59
hi CursorColumn                ctermbg=236
hi ColorColumn                 ctermbg=236
hi LineNr          ctermfg=250 ctermbg=236
hi NonText         ctermfg=59

" Must be at the end, because of ctermbg=234 bug.
" https://groups.google.com/forum/#!msg/vim_dev/afPqwAFNdrU/nqh6tOM87QUJ
set background=dark
