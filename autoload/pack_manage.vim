vim9script

var gitupdate: string = 'if [ -d .git ]; then git reset --hard --quiet; git pull origin $(git  rev-parse --abbrev-ref HEAD) --quiet; fi'

def PackErrHandler(ch: channel, msg: string)
    echo "Possible update fail of one of the plugins. Please check it manually: \"" .. msg .. "\""
enddef

export def PackUpdate()
    var currDir: string = getcwd()
    var dirs: list<string> = globpath('$HOME/.local/share/vim/pack/triton/opt', '*', 0, 1)
    dirs = filter(dirs, 'isdirectory(v:val)')
    for i in dirs
        silent exec 'cd' fnameescape(i)
        var job = job_start(gitupdate, {"in_io": "null", "out_io": "null", "err_cb": "PackErrHandler"})
    endfor
    silent exec 'cd' fnameescape(currDir)
    echo "Plugins updating in background"
enddef

export def PackList()
    var currDir: string = getcwd()
    var dirs: list<string> = globpath('$HOME/.local/share/vim/pack/triton/opt', '*', 0, 1)
    dirs = filter(dirs, 'isdirectory(v:val)')
    var output: string
    for i in dirs
        output = output .. substitute(i, '^.*/', '', '') .. ", "
    endfor
    echo output
enddef
