vim9script

var plugins = g:xdgData .. "/vim/pack/triton/opt/"

#Always start job with sh -c or thing doesn't work :v
var commandblock = [ 'sh', '-c', '']

##### HANDLERS
def PackUpdateErrHandler(ch: channel, msg: string)
    echoerr "Possible update fail of one of the plugins. Please check it manually: \"" .. msg .. "\""
enddef

def PackUpdateOnExitInfo(ch: channel)
    echow "Plugins updated (or nothing to do)"
enddef

def PackInstallErrHandler(ch: channel, msg: string)
    echoerr msg
enddef

def PackInstallOnExit(ch: channel)
    echo "Package installed, now use packadd in vimrc to use it."    
enddef

def PackDeleteOnExit(ch: channel)
    echo "Done removing."
enddef

#### MAIN FUNCTIONS
export def PackInstall(url: string)
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
        echow "Plugin already installed"
    endif
enddef

export def PackUpdate()
    var dirs: list<string> = globpath(plugins, "*", 0, 1)
    dirs = filter(dirs, "isdirectory(v:val)")
    for i in dirs
        if !empty(glob(expand(i .. "/.git")))
            commandblock[2] = 'git reset --hard --quiet; git pull origin `git  rev-parse --abbrev-ref HEAD` --quiet'
            var job = job_start(commandblock, {"out_io": "null", "err_cb": "PackUpdateErrHandler", "close_cb": "PackUpdateOnExitInfo"})
        endif
    endfor
    echo "Plugins updating in background"
enddef

export def PackList()
    var dirs: list<string> = globpath(plugins, "*", 0, 1)
    dirs = filter(dirs, "isdirectory(v:val)")
    var output: string
    for i in dirs
        output ..= substitute(i, "^.*/", "", "") .. ", "
    endfor
    echo output
enddef

def PackDelete(arg: string)
    if !empty(glob(expand(plugins .. arg)))
        var choice = confirm("Are you sure?",
                \ "&Yes\n&No")
        if choice == 1
            commandblock[2] = 'rm -rf ' .. plugins .. arg
            var job = job_start(commandblock, { "out_io": "null", "err_io": "null", "close_cb": "PackDeleteOnExit"})
        else
            return
        endif
    else
        echow "Folder does not exist"
        return
    endif
enddef

####### COMMANDS

command! -nargs=0 -bar Packlist PackList()
command! -nargs=0 -bar Packupdate PackUpdate()
command! -nargs=1 -bar Packinstall PackInstall(<f-args>)
command! -nargs=1 -bar Packdelete PackDelete(<f-args>)

