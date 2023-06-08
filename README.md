# Triton

## Words of introduction

Unlike normal Vim, this follows XDG(if you don't have XDG variables set, defaults will be assigned) which means:
* vimrc is in ~/.config/vim/vimrc
* .vim is in ~/.local/share/vim/ etc.

## Instalation

You have to have git installed and in PATH.

Add this line to your .profile(or .bash\_profile, .zsh\_profile etc.):

 `export VIMINIT='let $MYVIMRC="$XDG_CONFIG_HOME/vim/vimrc" | source $MYVIMRC'`

Then run install.sh.

## LSP

This supports LSP via lsp plugin from [yegappan](https://github.com/yegappan/lsp). You have a template how do add LSP server in vimrc.
Remember that vimrc uses vim9script, so his README examples won't work, [**read doc/lsp.txt instead.**](https://github.com/yegappan/lsp/blob/main/doc/lsp.txt) And don't forget about installing [LSP server](https://microsoft.github.io/language-server-protocol/implementors/servers/) from your package manager.

## Plugin management

* `:Packinstall <url>` - for downloading the plugin. It will not be used, until you put `packadd <packageName>` to vimrc_. [^1]
* `:Packupdate` - for creating jobs that will update all plugins. Any changes will be reverted(git reset --hard).
* `:Packlist` - list all plugins installed.
* `:Packdelete <name>` - removes plugin.

## Keybindings

The leader key can be different depending on system. For me it's `\`. You can customise it in _~/.config/vim/vimrc_ (`var mapleader = 'choose\_key'`).

* <leader> + n - directory explorer 
* <leader> + t - new tab
* <leader> + s - vertical split
* <Tab> - move between workplaces
* :Template - load template if avaliable.

## Advices

* Bind ESC to Caps-Lock, for example on mac:

![Esc](https://raw.github.com/DesantBucie/DesantBucie/master/easy.nvim/esc.gif)

[^1]: For now i have no (good) idea how to automate the process and most of plugins need configuration anyway. Also you may want to decide to load plugin only when special conditions are met like opening a file with certain extension.
