vim9script

import '../autoload/template.vim' as temp
import '../autoload/pack_manage.vim' as pacman

def g:DisableArrows()
	noremap <Up> <Nop>
	noremap <Down> <Nop>
	noremap <Left> <Nop>
	noremap <Right> <Nop>
	noremap! <Up> <Nop>
	noremap! <Down> <Nop>
	noremap! <Left> <Nop>
	noremap! <Right> <Nop>
enddef
def g:ToggleVExplorer()
    g:netrw_chgwin = winnr() + 1
    g:netrw_winsize = 30
    if (tabpagewinnr(tabpagenr(), '$') > 1)
        g:netrw_winsize = 50
    endif
    Lexplore
enddef

def g:Main()

    set shortmess+=T
    set viminfofile=$HOME/.local/share/vim/viminfo
    set backupdir=$HOME/.cache/vim/backup/
    set directory=$HOME/.cache/vim/swap/
    set undodir=$HOME/.cache/vim/undo/

    set guitablabel=%{GuiTabLabel()}
    set number
    set clipboard^=unnamed
    set autoindent
    set shiftwidth=4 softtabstop=-1 expandtab
    set tabstop=4
    set cursorline
    set title
    set smartcase
    set showmatch
    set ignorecase
    set autochdir
    set mouse=a
    set belloff=all
    set ruler
    set signcolumn=number
    set backspace=indent,eol,start
    set nohlsearch incsearch ignorecase
    set completeopt=menu,popup completepopup=highlight:Pmenu
    set nobackup
    set noswapfile
    set nobackup
    set nowb

    command! -nargs=0 -bar Template temp.Template()
    command! -nargs=0 -bar Packlist pacman.PackList()
    command! -nargs=0 -bar Packupdate pacman.PackUpdate()

    map <leader>n :call ToggleVExplorer()<CR>
    map <leader>t :tabe<CR>
    map <leader>s :vs<CR>
    noremap <tab> <C-w>w
enddef

