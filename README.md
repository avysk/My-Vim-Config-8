# Basic scratch window for vim

`vim-scratchy` is a vim plugin for having a basic scratch buffer in vim. The content of that buffer is not saved between sessions.

BSD 2-clause license.

## Installation

### Using Vim packages (since Vim 7.4.1528)

```
git clone https://github.com/avysk/vim-scratchy.git ~/.vim/pack/avysk/start/vim-scratchy
```

### Using Pathogen
```
git clone https://github.com/avysk/vim-scratchy.git ~/.vim/bundle/vim-scratchy
```

## Usage

With default mappings (see below) use `F4` to open scratch buffer in another tab or to return from it; use `F5` open/close scratch buffer using the split; use `F6` to close scratch split/tab.

## Mappings

To disable built-in mappings, add to your `.vimrc`:
```
let g:scratchy_builtin_bindings=0
```

To add your own mappings, add to your `.vimrc`:
```
nmap <unique> <F4> :ScratchTab<CR>
nmap <unique> <F5> :ScratchWindow<CR>
nmap <unique> <F6> :CloseScratch<CR>
imap <unique> <F4> <C-O>:ScratchTab<CR>
imap <unique> <F5> <C-O>:ScratchWindow<CR>
imap <unique> <F6> <C-O>:CloseScratch<CR>
```

## Settings

To change the display name of scratch buffer, set in your `.vimrc`:
```
let g:scratchy_name = "SCRATCH BUFFER"
```
Default value is `--scratchy--`.

To change how split for the scratch buffer is done, set `g:scratchy_geometry` in your `.vimrc`. Default value is `vertical rightbelow 40`. See `:help vertical`, `:help leftabove`, `:help rightbelow`, `:help topleft`, `:help botright`. The number specifies the number of lines/columns for the split (see `:help new` and `:help vnew`).

## Bugs

If you already have a split, then pressing `F5` twice might not return you to the window you was in before. Please submit a pull request if you know how to fix it in a non-horrible way.

