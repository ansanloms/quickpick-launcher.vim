# quickpick-launcher.vim

[ctrlp-launcher](https://github.com/mattn/ctrlp-launcher) for [quickpick.vim](https://github.com/prabirshrestha/quickpick.vim).

## Install

```
Plug 'prabirshrestha/quickpick.vim'
Plug 'ansanloms/quickpick-launcher.vim'

command! -bang -nargs=? PLauncher call quickpick#pickers#launcher#open("<bang>", <f-args>)
```

## Configuration

Edit `~/.quickpick-launcher` .

## Usage

```
:PLauncher
```
