# Installation

Clone this repository:
```
git clone https://github.com/avysk/My-Vim-Config-8 <your vim config dir>
```

Create directories `local/undo` and `local/plugged` inside your vim
configuration directory (`~/.vim` on Linux/macOS, `~/vimfiles` on Windows).

Make sure you have the following available:
- Python (for YouCompleteMe)
- cmake (for YouCompleteMe)
- fzf (for fzf and fzf.vim)
- optional ag ("The Silver Searcher") (for fzf.vim)
- optional bat (for fzf.vim); when running on Windows you need `bash` to run WSL
    and to have bat installed inside WSL (as `bat`, not as `batcat`!)

Run `vim -es -u vimrc -i NONE -c "PlugInstall" -c "qa"` in the vim config
directory.

If you are running on Windows, edit `local/plugged/fzf.vim/bin/preview.sh` and
add one line there (around line 25):
```sh
FILE="${FILE/#\~\//$HOME/}"
FILE="${FILE//\\\\//}"           # ADD THIS LINE
if [ ! -r "$FILE" ]; then
  echo "File not found ${FILE}"
  exit 1
fi
```

# Local customization

If `local/vimrc` and `local/gvimrc` exist, they will be read from `vimrc` and
`gvimrc` correspondingly.
