vim9script
var pairs: dict<string> = { 
    "{": "}", 
    "[": "]", 
    "(": ")", 
    "<": ">" }

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

def g:AutoPairsSingles(ascii_num: number): string
    var key = nr2char(ascii_num)

    var ch = getline('.')[charcol('.') - 1] 

    if key != ch
        return key .. key .. "\<Left>"
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
