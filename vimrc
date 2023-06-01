if !has("vim9script")
    echo "Error, vim9script not supported"
endif
vim9script

var xdgData = getenv("XDG_DATA_HOME")
import xdgData .. '/vim/main.vim'

filetype plugin indent on
syntax on

set runtimepath=$HOME/.local/share/vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,$HOME/.local/share/vim/after"

g:Main()

######## PERSONAL ADDITIONS BELOW ########

### Plugins ###
packadd lsp #well lsp
packadd noarrows #turns off arrows

#use it as your template
#var lspServers = [
#    {
#     name: 'clangd',
#     filetype: ['c', 'cpp'],
#     path: '/usr/bin/clangd',
#     args: ['--background-index']
#    },
#    {
#     name: 'anotherServer',
#     filetype: ['jar', 'java'],
#     path: '/random/path',
#     args: ['--random-command']
#    },
#]

g:LspAddServer(lspServers)
g:DisableArrows()
