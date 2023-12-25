vim9script

import './path.vim'

def Template()
    var lang = expand('%:e')
    var check_file = g:xdgData .. "/vim/pack/triton/opt/Triton/templates/" .. lang .. ".template"
    if filereadable(check_file)
        execute "read " .. check_file
    else
        echo "Template doesn't exist"
    endif
enddef

command! -nargs=0 -bar Template Template()
