vim9script
var pairs: dict<string> = { 
    "{": "}", 
    "[": "]", 
    "(": ")"}

var singles = ["'", '"', '`']

def g:AutoPairsWPrevention(ascii_num: number): string
    var key = nr2char(ascii_num)
    var ch = getline('.')[charcol('.') - 1] 

    if key == ch
        return "\<Right>"
    endif
    if has_key(pairs, key)
        return key .. pairs[key] .. "\<Left>"
    endif
    return key
enddef

def IsAlpha(char: string): bool
    var ascii = char2nr(char)
    echo ascii
    g:res = (ascii >= 65 && ascii <= 90) || (ascii >= 97 && ascii <= 122)
    return g:res
enddef

def g:AutoPairsSingles(ascii_num: number): string

    var key = nr2char(ascii_num)

    #char under cursor
    var ch = getline('.')[charcol('.') - 1] 
    #char left of the cursor
    var ch2 = getline('.')[charcol('.') - 2]

    if key != ch && !IsAlpha(ch2)
        return key .. key .. "\<Left>"
    elseif IsAlpha(ch2)
        return key
    else
        return "\<Right>"
    endif
enddef

def g:AutoPairsDelete()
    g:ch = getline('.')[charcol('.') - 2]

    if has_key(pairs, g:ch)
        exe 'norm hvv%xgvx'
    else
        exe 'norm \<BS>'
    endif
enddef

def g:AutoPairs()
    for [key, value] in items(pairs) 
       exe "inoremap <expr> "  .. key .. " g:AutoPairsWPrevention(" .. char2nr(key) .. ")"
       exe "inoremap <expr> "  .. value .. " g:AutoPairsWPrevention(" .. char2nr(value) .. ")"
    endfor
    for i in singles
        exe "inoremap <expr> " .. i .. " g:AutoPairsSingles(" .. char2nr(i) .. ")"
    endfor
    #inoremap <BS> <Cmd>call g:AutoPairsDelete()<CR>
enddef
