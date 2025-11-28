
" If you are distributing this theme, please replace this comment
" with the appropriate license attributing the original VS Code
" theme author.


" Andromeda Mariana - Italic Bordered - A nice dark theme

" ==========> Reset
set background=dark

hi clear

if exists("syntax_on")
  syntax reset
endif

let g:colors_name = 'andromeda-mariana-italic-bordered'

" ==========> Highlight function
function! s:h(face, guibg, guifg, ctermbg, ctermfg, gui)
  let l:cmd="highlight " . a:face
  
  if a:guibg != ""
    let l:cmd = l:cmd . " guibg=" . a:guibg
  endif

  if a:guifg != ""
    let l:cmd = l:cmd . " guifg=" . a:guifg
  endif

  if a:ctermbg != ""
    let l:cmd = l:cmd . " ctermbg=" . a:ctermbg
  endif

  if a:ctermfg != ""
    let l:cmd = l:cmd . " ctermfg=" . a:ctermfg
  endif

  if a:gui != ""
    let l:cmd = l:cmd . " gui=" . a:gui
  endif

  exec l:cmd
endfun


" ==========> Colors dictionary

" GUI colors dictionary (hex)
let s:hex = {}
" Terminal colors dictionary (256)
let s:bit = {}

let s:hex.color0="#262A33"
let s:hex.color1="#D5CED9"
let s:hex.color2="#FFF"
let s:hex.color3="#3D4352"
let s:hex.color4="#30343d"
let s:hex.color5="#585c65"
let s:hex.color6="#3a3e47"
let s:hex.color7="#6c7079"
let s:hex.color8="#373a42"
let s:hex.color9="#50535b"
let s:hex.color10="#71757e"
let s:hex.color11="#4b9f9f"
let s:hex.color12="#444851"
let s:hex.color13="#f3ecf7"
let s:hex.color14="#dfd8e3"
let s:hex.color15="#494d56"
let s:hex.color16="#EE6A6F"
let s:hex.color17="#5fb3b3"
let s:hex.color18="#c594c5"
let s:hex.color19="#FA8763"
let s:hex.color20="#A3CE9E"
let s:hex.color21="#FAB763"

let s:bit.color5="59"
let s:bit.color8="73"
let s:bit.color15="151"
let s:bit.color13="176"
let s:bit.color1="188"
let s:bit.color12="203"
let s:bit.color14="209"
let s:bit.color16="215"
let s:bit.color2="233"
let s:bit.color0="236"
let s:bit.color4="237"
let s:bit.color3="238"
let s:bit.color9="239"
let s:bit.color7="240"
let s:bit.color6="243"
let s:bit.color11="253"
let s:bit.color10="255"


" ==========> General highlights 
call s:h("Normal", s:hex.color0, s:hex.color1, s:bit.color0, s:bit.color1, "none")
call s:h("Cursor", s:hex.color2, "", s:bit.color2, "", "none")
call s:h("Visual", s:hex.color3, "", s:bit.color3, "", "none")
call s:h("ColorColumn", s:hex.color4, "", s:bit.color4, "", "none")
call s:h("LineNr", "", s:hex.color5, "", s:bit.color5, "none")
call s:h("CursorLine", s:hex.color6, "", s:bit.color3, "", "none")
call s:h("CursorLineNr", "", s:hex.color7, "", s:bit.color6, "none")
call s:h("CursorColumn", s:hex.color6, "", s:bit.color3, "", "none")
call s:h("StatusLineNC", s:hex.color8, "", s:bit.color4, "", "none")
call s:h("StatusLine", s:hex.color9, "", s:bit.color7, "", "none")
call s:h("VertSplit", "", s:hex.color10, "", s:bit.color6, "none")
call s:h("Folded", s:hex.color6, s:hex.color11, s:bit.color3, s:bit.color8, "none")
call s:h("Pmenu", s:hex.color12, s:hex.color13, s:bit.color9, s:bit.color10, "none")
call s:h("PmenuSel", s:hex.color4, s:hex.color14, s:bit.color4, s:bit.color11, "none")
call s:h("EndOfBuffer", s:hex.color0, s:hex.color15, s:bit.color0, s:bit.color9, "none")
call s:h("NonText", s:hex.color0, s:hex.color15, s:bit.color0, s:bit.color9, "none")


" ==========> Syntax highlights
call s:h("Constant", "", s:hex.color16, "", s:bit.color12, "none")
call s:h("Special", "", s:hex.color16, "", s:bit.color12, "none")
call s:h("Function", "", s:hex.color17, "", s:bit.color8, "none")
call s:h("Statement", "", s:hex.color18, "", s:bit.color13, "none")
call s:h("Operator", "", s:hex.color19, "", s:bit.color14, "none")
call s:h("PreProc", "", s:hex.color18, "", s:bit.color13, "none")
call s:h("Type", "", s:hex.color18, "", s:bit.color13, "none")
call s:h("String", "", s:hex.color20, "", s:bit.color15, "none")
call s:h("Number", "", s:hex.color21, "", s:bit.color16, "none")

highlight link cStatement Statement
highlight link cSpecial Special


" Generated using https://github.com/nice/themeforge
" Feel free to remove the above URL and this line.