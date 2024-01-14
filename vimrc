if !has("vim9script")
    echo "Error, vim9script not supported"
endif
vim9script

filetype plugin indent on
syntax on


if getenv("XDG_DATA_HOME") != null
    set packpath+=$XDG_DATA_HOME/vim
else
    set packpath+=$HOME/.local/share/vim
endif
set packpath-=~/.vim
set packpath-=~/.vim/after

packadd triton
packadd lsp
g:Main()

######## PERSONAL ADDITIONS BELOW ########

# Use it as your template
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
#g:LspAddServer(lspServers)
g:DisableArrows()
