#!/bin/sh
CURRENT_PWD="$PWD"
NVIM_CONFIG="$HOME/.config/vim"
NVIM_PLUGINS="$HOME/.local/share/vim/pack/triton/opt"

! type git && echo "No git installed" && exit 127
! type printf && echo "No printf installed" && exit 127
! type sed && echo "No sed installed" && exit 127
! type sort && echo "No sort installed" && exit 127

make_folder_if_doesnt_exist() {
    if [ ! -d "$1" ]; then
        mkdir -p "$1"
    else 
        cd "$1" && rm -rf ./*
    fi
}

make_folder_if_doesnt_exist "$NVIM_CONFIG"
make_folder_if_doesnt_exist "$NVIM_PLUGINS"

cd "$CURRENT_PWD"
cp vimrc "$NVIM_CONFIG" && echo COPYING vimrc
cd ..
cp -r "Triton" "$NVIM_PLUGINS" 
cd "$NVIM_PLUGINS" || exit 127;
git clone https://github.com/yegappan/lsp
echo "Now you need to install language servers on your behalf."
echo "Best you check yourself: https://github.com/yegappan/lsp"
cd "$CURRENT_PWD"
