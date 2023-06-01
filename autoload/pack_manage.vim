vim9script

#Always start job with sh -c or thing doesn't work :v
var gitupdate = ["sh", "-c", "if [ -d .git ]; then git reset --hard --quiet; git pull origin `git  rev-parse --abbrev-ref HEAD` --quiet; fi"]

def PackErrHandler(ch: channel, msg: string)
    echoerr "Possible update fail of one of the plugins. Please check it manually: \"" .. msg .. "\""
enddef

def PackOnExitInfo(ch: channel)
    echo "Plugins updated (or nothing to do)"
enddef

export def PackUpdate()
    var currDir: string = getcwd()
    var dirs: list<string> = globpath(g:xdgData .. "/vim/pack/triton/opt", "*", 0, 1)
    dirs = filter(dirs, "isdirectory(v:val)")
    for i in dirs
        silent exec "cd" fnameescape(i)
        var job = job_start(gitupdate, {"out_io": "null", "err_cb": "PackErrHandler", "close_cb": "PackOnExitInfo"})
        silent exec "cd" fnameescape("..")
    endfor
    echo "Plugins updating in background"
enddef

export def PackList()
    var currDir: string = getcwd()
    var dirs: list<string> = globpath(g:xdgData .. "/vim/pack/triton/opt", "*", 0, 1)
    dirs = filter(dirs, "isdirectory(v:val)")
    var output: string
    for i in dirs
        output ..= substitute(i, "^.*/", "", "") .. ", "
    endfor
    echo output
enddef
