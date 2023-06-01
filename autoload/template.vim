vim9script

import './path.vim'

export def Template()
    var lang = expand('%:e')
    var check_file = g:xdgData .. "/vim/pack/triton/opt/Triton/templates/" .. lang .. ".template"
    if filereadable(check_file)
        execute "read " .. check_file
    else
        echo "Template doesn't exist"
    endif
enddef
