#!/bin/sh
CURRENT_PWD="$PWD"
if [ -z "$XDG_CONFIG_HOME" ]; then
    VIM_CONFIG="$HOME/.config/vim"
else
    VIM_CONFIG="$XDG_CONFIG_HOME/vim"
fi
if [ -z "$XDG_DATA_HOME" ]; then
    VIM_HOME="$HOME/.local/share/vim"
else
    VIM_HOME="$XDG_DATA_HOME/vim"
fi
if [ -z "$XDG_CACHE_HOME" ]; then
    VIM_CACHE="$HOME/.cache/vim"
else
    VIM_CACHE="$XDG_CACHE_HOME/vim"
fi

VIM_PLUGINS="$VIM_HOME/pack/triton/opt"

echo "Vim plugins: $VIM_PLUGINS"
echo "Vim cache: $VIM_CACHE"
echo "Vim data: $VIM_HOME"
! type git && echo "No git installed" && exit 127

make_folder_if_doesnt_exist() {
    if [ ! -d "$1" ]; then
        mkdir -p "$1"
    else 
        cd "$1" && rm -rf ./*
    fi
}

make_folder_if_doesnt_exist "$VIM_CONFIG"
make_folder_if_doesnt_exist "$VIM_PLUGINS"
make_folder_if_doesnt_exist "$VIM_CACHE/backup"
make_folder_if_doesnt_exist "$VIM_CACHE/undo"
make_folder_if_doesnt_exist "$VIM_CACHE/swap"

cd "$CURRENT_PWD" || exit 127
cp vimrc "$VIM_CONFIG" && echo COPYING vimrc
cd ..
cp -r "triton" "$VIM_PLUGINS" 
cd "$VIM_PLUGINS" || exit 127;
git clone https://github.com/yegappan/lsp --quiet
echo "Now you need to install language servers on your behalf."
echo "Best you check yourself: https://github.com/yegappan/lsp"
cd "$CURRENT_PWD" || exit 127
