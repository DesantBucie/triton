# Triton

## Words of introduction

Unlike normal Vim, this follows XDG which means:
* vimrc is in ~/.config/vim/vimrc
* .vim is in ~/.local/share/vim/ etc.
## Instalation

You have to have git installed and in PATH.

UNIX: Run install.sh.

## LSP

This supports LSP via lsp plugin from [yegappan](https://github.com/yegappan/lsp). You have a template how do add LSP server in vimrc.
Remember that vimrc uses vim9script, so his README examples won't work, [**read doc/lsp.txt instead.**](https://github.com/yegappan/lsp/blob/main/doc/lsp.txt) And don't forget about installing [LSP server](https://microsoft.github.io/language-server-protocol/implementors/servers/) from your package manager.

## Plugin management

For now, git clone them to ~/.local/share/vim/pack/triton/opt/ and `packadd <foldername>` in vimrc.

* `:Packupdate` - for creating jobs that will update all plugins. Any changes will be reverted(git reset --hard)
* `:Packlist` - to list plugins installed

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
