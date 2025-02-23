$PWD_PATH = Get-Location | Foreach-Object { $_.Path }
echo "$PWD_PATH`r`n"

if (!$XDG_DATA_HOME) {
    $VIM_HOME = "$HOME/.local/share/vim"
} 
else {
    $VIM_HOME = "$XDG_DATA_HOME/vim"
}


if (!$XDG_CACHE_HOME) {
    $VIM_CACHE = "$HOME/.cache/vim"
} 
else {
    $VIM_CACHE = "$XDG_CACHE_HOME/vim"
}

$VIM_PLUGINS  = "$VIM_HOME/pack/triton/start"
$VIM_OPT      = "$VIM_HOME/pack/triton/opt"
$VIM_UNLOADED = "$VIM_HOME/pack/triton/unloaded"

Write-Host "Vim plugins: $VIM_PLUGINS"
Write-Host "Vim cache: $VIM_CACHE"
Write-Host "Vim data: $VIM_HOME`r`n"

Write-Host -ForegroundColor Red "Does it look reasonable? [y/n]"
$ans = Read-Host 

if ($ans -ne 'y'){
    Write-Host -ForegroundColor Red 'Answer is not an "y". Aborting.'
    exit 1
}

if ((Get-Command "git" -ErrorAction SilentlyContinue) -eq $null) {
    Write-Host "No git installed, aborting."
}

function makeFolder([string]$arg1) {
    if (Test-Path -Path $arg1 -PathType Container) {
        Get-ChildItem -Path $arg1 -Include * -File -Recurse | foreach { $_.Delete()}
    }
    else {
        New-Item -ItemType Directory $arg1
    }
}

makeFolder $VIM_CONFIG
makeFolder $VIM_PLUGINS
makeFolder $VIM_OPT
makeFolder $VIM_UNLOADED
makeFolder "$VIM_CACHE/backup"
makeFolder "$VIM_CACHE/undo"
makeFolder "$VIM_CACHE/swap"

Set-Location -LiteralPath $PWD_PATH
Copy-Item vimrc ~/_vimrc
Set-Location ..
Copy-Item -Recurse triton $VIM_OPT
Set-Location -LiteralPath $VIM_OPT
git clone https://github.com/yegappan/lsp --quiet
Write-Host "Now you need to install language servers on your behalf."
Write-Host "Best you check yourself: https://github.com/yegappan/lsp"
Set-Location -LiteralPath $PWD_PATH


