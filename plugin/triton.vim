vim9script

if exists("g:triton_main")
    finish
endif
g:triton_main = 1

import '../autoload/template.vim' as temp
import '../autoload/pack_manage.vim' as pacman
import '../autoload/path.vim'

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

    if getenv("XDG_DATA_HOME") != ''
        g:xdgData = getenv("XDG_DATA_HOME")
        set viminfofile=$XDG_DATA_HOME/vim/viminfo
    endif
    set backupdir=$HOME/.cache/vim/backup/
    set directory=$HOME/.cache/vim/swap/
    set undodir=$HOME/.cache/vim/undo/
    if getenv("XDG_CACHE_HOME") != ''
        g:xdgCache = getenv("XDG_CACHE_HOME")
        set backupdir=$XDG_CACHE_HOME/vim/backup/
        set directory=$XDG_CACHE_HOME/vim/swap/
        set undodir=$XDG_CACHE_HOME/vim/undo/
    endif
    if getenv("XDG_CONFIG_HOME") != ''
        g:xdgConfig = getenv("XDG_CONFIG_HOME")
    endif

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

    map <leader>n :call ToggleVExplorer()<CR>
    map <leader>t :tabe<CR>
    map <leader>s :vs<CR>
    noremap <C-w> <C-w>w
    inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
    inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
enddef

