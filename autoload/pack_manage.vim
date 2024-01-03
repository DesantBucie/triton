vim9script

var plugins = g:xdgData .. "/vim/pack/triton/start/"
var unloaded = g:xdgData .. "/vim/pack/triton/unloaded/"
var tritons = g:xdgData .. "vim/pack/trition/opt/"
#Always start job with sh -c or thing doesn't work :v
var commandblock = [ 'sh', '-c', '']

##### HANDLERS
def PackUpdateErrHandler(ch: channel, msg: string)
    echoerr "Possible update fail of one of the plugins. Please check it manually: \"" .. msg .. "\""
enddef

def PackUpdateOnExitInfo(ch: channel)
    echo "Plugins updated (or nothing to do)"
enddef

def PackInstallErrHandler(ch: channel, msg: string)
    echoerr msg
enddef

def PackInstallOnExit(ch: channel)
    echo "Package installed."    
    packloadall
enddef

def PackDeleteOnExit(ch: channel)
    echo "Done removing."
enddef

def PackUnloadOnExit(ch: channel)
    echo "Plugin unloaded"
enddef

def PackLoadOnExit(ch: channel)
    echo "Plugin loaded back"
enddef
#### MAIN FUNCTIONS
def PackInstall(url: string)
    var i: number = -1
    # Find first / to extract only the directory name
    while url[i] != '/'
        i -= 1
        if i < -50
            echoe "Wrong URL"
            return
        endif
    endwhile
    i += 1
    var dir = url[i : ]
    if empty(glob(expand(plugins .. dir)))
        commandblock[2] = 'git clone ' .. url .. ' --quiet ' .. plugins .. dir
        var job = job_start(commandblock, { "out_io": "null", "err_cb": "PackInstallErrHandler", "close_cb": "PackInstallOnExit"})
    else
        echo "Plugin already installed"
    endif
enddef

def PackUpdate()
    var dirs: list<string> = globpath(plugins, "*", 0, 1)
    dirs = filter(dirs, "isdirectory(v:val)")
    for i in dirs
        if !empty(glob(expand(i .. "/.git")))
            commandblock[2] = 'git -C ' .. i .. ' reset --hard --quiet; git -C ' .. i .. ' pull origin `git -C ' .. i .. '  rev-parse --abbrev-ref HEAD` --quiet'
            var job = job_start(commandblock, {"out_io": "null", "err_cb": "PackUpdateErrHandler", "close_cb": "PackUpdateOnExitInfo"})
        endif
    endfor
    dirs = globpath(tritons, "*", 0, 1)
    dirs = filter(dirs, "isdirectory(v:val)")
    for i in dirs
        if !empty(glob(expand(i .. "/.git")))
            commandblock[2] = 'git -C ' .. i .. ' reset --hard --quiet; git -C ' .. i .. ' pull origin `git -C ' .. i .. '  rev-parse --abbrev-ref HEAD` --quiet'
            var job = job_start(commandblock, {"out_io": "null", "err_cb": "PackUpdateErrHandler", "close_cb": "PackUpdateOnExitInfo"})
        endif
    endfor
    echo "Plugins updating in background"
    packloadall
enddef

def PackList()
    var dirs: list<string> = globpath(plugins, "*", 0, 1)
    dirs = filter(dirs, "isdirectory(v:val)")
    var output: string
    output = "LOADED: "
    for i in dirs
        output ..= substitute(i, "^.*/", "", "") .. ", "
    endfor
    dirs = globpath(unloaded, "*", 0, 1)
    dirs = filter(dirs, "isdirectory(v:val)")
    output ..= " UNLOADED: "
    for i in dirs
        output ..= substitute(i, "^.*/", "", "") .. ", "
    endfor
    echo output
enddef

def PackDelete(arg: string)
    if empty(glob(expand(plugins .. arg)))
        echo "Folder does not exist"
        return
    endif
    var choice = confirm("Are you sure?",
            \ "&Yes\n&No")
    if choice == 1
        commandblock[2] = 'rm -rf ' .. plugins .. arg
        var job = job_start(commandblock, { "out_io": "null", "err_io": "null", "close_cb": "PackDeleteOnExit"})
    else
        return
    endif
    return
enddef

def PackUnload(arg: string)
    if empty(glob(expand(plugins .. arg)))
        echo "Plugin does not exist or is unloaded"
        return
    endif
    commandblock[2] = 'mv ' .. plugins .. arg .. " " .. unloaded .. arg
    var job = job_start(commandblock, { "out_io": "null", "err_io": "null", "close_cb": "PackUnloadOnExit"})
    return
enddef

def PackLoad(arg: string)
    if empty(glob(expand(unloaded .. arg)))
        echo "Plugin does not exist or is already loaded"
        return
    endif
    commandblock[2] = 'mv ' .. unloaded .. arg .. " " ..  plugins .. arg
    var job = job_start(commandblock, { "out_io": "null", "err_io": "null", "close_cb": "PackLoadOnExit"})
    return
enddef
####### COMMANDS

command! -nargs=0 -bar Packlist PackList()
command! -nargs=0 -bar Packupdate PackUpdate()
command! -nargs=1 -bar Packinstall PackInstall(<f-args>)
command! -nargs=1 -bar Packdelete PackDelete(<f-args>)
command! -nargs=1 -bar Packload PackLoad(<f-args>)
command! -nargs=1 -bar Packunload PackUnload(<f-args>)

