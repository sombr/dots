" twilight256 color scheme file
" Maintainer: Neal Milstein - neal dot milstein at gmail dot com
" Last Change: 2011 Feb 1
"
" This theme copies the colors from the TextMate theme Twilight.
"
" The theme is designed to be used on a black background. I only tested it
" using a 256-color terminal; I do not think it will work on much else (gvim,
" 8-color terminal, etc.).
"
" The functions in this theme that convert hex color codes to the nearest
" xterm-256 color number are from the theme desert2 (desert256), developed by Henry So, Jr. 
"
" The colors of this theme are based on the TextMate Twilight theme
" – www.macromates.com

set background=dark
if version > 580
    " no guarantees for version 5.8 and below, but this makes it stop
    " complaining
    hi clear
    if exists("syntax_on")
        syntax reset
    endif
endif
let g:colors_name="twilight256"

if has("gui_running") || &t_Co == 88 || &t_Co == 256
    " functions {{{
    " returns an approximate grey index for the given grey level
    fun <SID>grey_number(x)
        if &t_Co == 88
            if a:x < 23
                return 0
            elseif a:x < 69
                return 1
            elseif a:x < 103
                return 2
            elseif a:x < 127
                return 3
            elseif a:x < 150
                return 4
            elseif a:x < 173
                return 5
            elseif a:x < 196
                return 6
            elseif a:x < 219
                return 7
            elseif a:x < 243
                return 8
            else
                return 9
            endif
        else
            if a:x < 14
                return 0
            else
                let l:n = (a:x - 8) / 10
                let l:m = (a:x - 8) % 10
                if l:m < 5
                    return l:n
                else
                    return l:n + 1
                endif
            endif
        endif
    endfun

    " returns the actual grey level represented by the grey index
    fun <SID>grey_level(n)
        if &t_Co == 88
            if a:n == 0
                return 0
            elseif a:n == 1
                return 46
            elseif a:n == 2
                return 92
            elseif a:n == 3
                return 115
            elseif a:n == 4
                return 139
            elseif a:n == 5
                return 162
            elseif a:n == 6
                return 185
            elseif a:n == 7
                return 208
            elseif a:n == 8
                return 231
            else
                return 255
            endif
        else
            if a:n == 0
                return 0
            else
                return 8 + (a:n * 10)
            endif
        endif
    endfun

    " returns the palette index for the given grey index
    fun <SID>grey_color(n)
        if &t_Co == 88
            if a:n == 0
                return 16
            elseif a:n == 9
                return 79
            else
                return 79 + a:n
            endif
        else
            if a:n == 0
                return 16
            elseif a:n == 25
                return 231
            else
                return 231 + a:n
            endif
        endif
    endfun

    " returns an approximate color index for the given color level
    fun <SID>rgb_number(x)
        if &t_Co == 88
            if a:x < 69
                return 0
            elseif a:x < 172
                return 1
            elseif a:x < 230
                return 2
            else
                return 3
            endif
        else
            if a:x < 75
                return 0
            else
                let l:n = (a:x - 55) / 40
                let l:m = (a:x - 55) % 40
                if l:m < 20
                    return l:n
                else
                    return l:n + 1
                endif
            endif
        endif
    endfun

    " returns the actual color level for the given color index
    fun <SID>rgb_level(n)
        if &t_Co == 88
            if a:n == 0
                return 0
            elseif a:n == 1
                return 139
            elseif a:n == 2
                return 205
            else
                return 255
            endif
        else
            if a:n == 0
                return 0
            else
                return 55 + (a:n * 40)
            endif
        endif
    endfun

    " returns the palette index for the given R/G/B color indices
    fun <SID>rgb_color(x, y, z)
        if &t_Co == 88
            return 16 + (a:x * 16) + (a:y * 4) + a:z
        else
            return 16 + (a:x * 36) + (a:y * 6) + a:z
        endif
    endfun

    " returns the palette index to approximate the given R/G/B color levels
    fun <SID>color(r, g, b)
        " get the closest grey
        let l:gx = <SID>grey_number(a:r)
        let l:gy = <SID>grey_number(a:g)
        let l:gz = <SID>grey_number(a:b)

        " get the closest color
        let l:x = <SID>rgb_number(a:r)
        let l:y = <SID>rgb_number(a:g)
        let l:z = <SID>rgb_number(a:b)

        if l:gx == l:gy && l:gy == l:gz
            " there are two possibilities
            let l:dgr = <SID>grey_level(l:gx) - a:r
            let l:dgg = <SID>grey_level(l:gy) - a:g
            let l:dgb = <SID>grey_level(l:gz) - a:b
            let l:dgrey = (l:dgr * l:dgr) + (l:dgg * l:dgg) + (l:dgb * l:dgb)
            let l:dr = <SID>rgb_level(l:gx) - a:r
            let l:dg = <SID>rgb_level(l:gy) - a:g
            let l:db = <SID>rgb_level(l:gz) - a:b
            let l:drgb = (l:dr * l:dr) + (l:dg * l:dg) + (l:db * l:db)
            if l:dgrey < l:drgb
                " use the grey
                return <SID>grey_color(l:gx)
            else
                " use the color
                return <SID>rgb_color(l:x, l:y, l:z)
            endif
        else
            " only one possibility
            return <SID>rgb_color(l:x, l:y, l:z)
        endif
    endfun

    " returns the palette index to approximate the 'rrggbb' hex string
    fun <SID>rgb(rgb)
        let l:r = ("0x" . strpart(a:rgb, 0, 2)) + 0
        let l:g = ("0x" . strpart(a:rgb, 2, 2)) + 0
        let l:b = ("0x" . strpart(a:rgb, 4, 2)) + 0

        return <SID>color(l:r, l:g, l:b)
    endfun

    " sets the highlighting for the given group
    fun <SID>X(group, fg, bg, attr)
        if a:fg != ""
            exec "hi " . a:group . " guifg=#" . a:fg . " ctermfg=" . <SID>rgb(a:fg)
        endif
        if a:bg != ""
            exec "hi " . a:group . " guibg=#" . a:bg . " ctermbg=" . <SID>rgb(a:bg)
        endif
        if a:attr != ""
            exec "hi " . a:group . " gui=" . a:attr . " cterm=" . a:attr
        endif
    endfun
    " }}}

    call <SID>X("Normal", "ffffff", "", "")

    " highlight groups
    "call <SID>X("Cursor", "708090", "f0e68c", "")
    "CursorIM
    "Directory
    "DiffAdd
    "DiffChange
    "DiffDelete
    "DiffText
    "ErrorMsg
    "call <SID>X("VertSplit", "c2bfa5", "7f7f7f", "reverse")
    "call <SID>X("Folded", "ffd700", "4d4d4d", "")
    "call <SID>X("FoldColumn", "d2b48c", "4d4d4d", "")
    "call <SID>X("IncSearch", "708090", "f0e68c", "")
    call <SID>X("LineNr", "CCCCCC", "", "")
    "call <SID>X("ModeMsg", "D4D4D4", "", "")
    "call <SID>X("MoreMsg", "2e8b57", "", "")
    "call <SID>X("NonText", "addbe7", "000000", "bold")
    "call <SID>X("Question", "00ff7f", "", "")
    "call <SID>X("Search", "f5deb3", "cd853f", "")
    "call <SID>X("SpecialKey", "9acd32", "", "")
    "call <SID>X("StatusLine", "c2bfa5", "000000", "reverse")
    "call <SID>X("StatusLineNC", "c2bfa5", "7f7f7f", "reverse")
    "call <SID>X("Title", "cd5c5c", "", "")
    call <SID>X("Visual", "D3D3D3", "3E3E3E", "reverse")
    "VisualNOS
    "call <SID>X("WarningMsg", "fa8072", "", "")
    "WildMenu
    "Menu
    "Scrollbar
    "Tooltip

    " syntax highlighting groups
    call <SID>X("Comment", "828282", "", "")
    call <SID>X("Constant", "CF6A4C", "", "")
    call <SID>X("Identifier", "7587A6", "", "none")
    call <SID>X("Function", "9B703F", "", "")
    call <SID>X("Define", "CDA869", "", "none")
    call <SID>X("Statement", "CDA869", "", "")
    call <SID>X("String", "8F9D6A", "", "")
    call <SID>X("PreProc", "AFC4DB", "", "")
    call <SID>X("Type", "F9EE98", "", "")
    call <SID>X("Special", "DAEFA3", "", "")
    "Underlined
    call <SID>X("Ignore", "666666", "", "")
    "Error
    call <SID>X("Todo", "ff4500", "eeee00", "")

    " delete functions {{{
    delf <SID>X
    delf <SID>rgb
    delf <SID>color
    delf <SID>rgb_color
    delf <SID>rgb_level
    delf <SID>rgb_number
    delf <SID>grey_color
    delf <SID>grey_level
    delf <SID>grey_number
    " }}}
endif

" vim: set fdl=0 fdm=marker:
" JAVA
hi javaexternal ctermfg=129 guifg=#af00ff cterm=BOLD
hi javascopedecl ctermfg=198 guifg=#ff0087 cterm=BOLD
hi javaclassdecl ctermfg=39 guifg=#00afff cterm=BOLD
hi javaStorageClass ctermfg=34 guifg=#00af00 cterm=BOLD
hi javaBoolean ctermfg=118 guifg=#87ff00 cterm=BOLD
hi javaAnnotation ctermfg=11 guifg=#ffff00 cterm=NONE
hi javaElementType ctermfg=39 guifg=#00afff cterm=BOLD
"hi javaParenT ctermfg=11 cterm=BOLD
hi javatypedef ctermfg=39 guifg=#00afff cterm=NONE
hi javaConstant ctermfg=94 guifg=#875f00 cterm=BOLD
hi javaexceptions ctermfg=50 guifg=#00ffd7 cterm=BOLD

hi Typedef guifg=#828282 guibg=#000000 guisp=#000000 gui=NONE ctermfg=73 ctermbg=NONE cterm=BOLD
hi Title guifg=#5cacee guibg=#000000 guisp=#000000 gui=NONE ctermfg=75 ctermbg=NONE cterm=NONE
hi Todo guifg=#00ff40 guibg=#121212 guisp=#121212 gui=NONE ctermfg=47 ctermbg=233 cterm=NONE
hi Label guifg=#3b9c9c guibg=#000000 guisp=#000000 gui=NONE ctermfg=73 ctermbg=NONE cterm=NONE
hi Statement guifg=#177cff guibg=#000000 guisp=#000000 gui=bold ctermfg=27 ctermbg=NONE cterm=bold
hi Number guifg=#ff2600 guibg=#000000 guisp=#000000 gui=NONE ctermfg=196 ctermbg=NONE cterm=NONE
hi Boolean guifg=#72a5ee guibg=#000000 guisp=#000000 gui=NONE ctermfg=118 ctermbg=NONE cterm=NONE
hi Operator guifg=#bb00ff guibg=#000000 guisp=#000000 gui=NONE ctermfg=129 ctermbg=NONE cterm=NONE
hi Define guifg=#c12869 guibg=#000000 guisp=#000000 gui=NONE ctermfg=1 ctermbg=NONE cterm=NONE
hi Function guifg=#ff8c00 guibg=#000000 guisp=#000000 gui=NONE ctermfg=208 ctermbg=NONE cterm=NONE
hi FoldColumn guifg=#b0d0e0 guibg=#305070 guisp=#305070 gui=NONE ctermfg=152 ctermbg=60 cterm=NONE
hi PreProc guifg=#c12869 guibg=#000000 guisp=#000000 gui=NONE ctermfg=1 ctermbg=NONE cterm=NONE
hi Exception guifg=#3b9c9c guibg=#000000 guisp=#000000 gui=NONE ctermfg=73 ctermbg=NONE cterm=NONE
hi Keyword guifg=#00ffff guibg=#000000 guisp=#000000 gui=bold ctermfg=14 ctermbg=NONE cterm=bold
hi Type guifg=#00ffff guibg=#000000 guisp=#000000 gui=NONE ctermfg=39 ctermbg=NONE cterm=BOLD
hi String guifg=#a6ff00 guibg=#000000 guisp=#000000 gui=NONE ctermfg=154 ctermbg=NONE cterm=NONE
