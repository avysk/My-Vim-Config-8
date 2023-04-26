# Installation

Clone this repository:
```
git clone https://github.com/avysk/My-Vim-Config-8 <your vim config dir>
```

Make sure you have the Python and the node available.

Run `vim -es -u vimrc -i NONE -c "PlugInstall" -c "qa"` in the vim config
directory (it takes time and it is silent; for a more interactive experience
just start vim, run `:PlugInstall` and then restart vim).

# Local customization

If `local/vimrc` and `local/gvimrc` exist, they will be read from `vimrc` and
`gvimrc` correspondingly.

If `local/vimrc-colors` exist, it will be read from vimrc in the very end
(most importantly, after `syntax on`).
