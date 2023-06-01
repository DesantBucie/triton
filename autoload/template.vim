vim9script
export def Template()
    var lang = expand('%:e')
    var home = getenv("XDG_DATA_HOME")
    var check_file = home .. "/vim/pack/triton/opt/Triton/templates/" .. lang .. ".template"
    if filereadable(check_file)
        execute "read " .. check_file
    else
        echo "Template doesn't exist"
    endif
enddef
