# Installation

Clone this repository:
```
git clone https://github.com/avysk/My-Vim-Config-8 <your vim config dir>
```

Make sure you have the Python and the node available.

## Notes on node

You will need node (JavaScript engine) at least version 20 and npm for it. I
*think* that in Ubuntu the corresponding packages are called `nodejs` and `npm`.

## Notes on Ubuntu 22.04

Ubuntu 22.04 has a really ancient node (version 12) and ancient vim, which will
not work with `coc.nvim` plugin the configuration heavily uses. What is below
is one way to get modern versions, but keep in mind, that it is one way only,
and it describes how to install a tool, with which to install a tool, with
which to install a tool, with which to install node and vim (and modern Python,
if you wish).

### Dependencies

You will need to do the following:

1. Install `build-essential` and `libssl-dev` packages.
2. Install dependencies to build (gtk3) version of vim. The easiest way is to
   edit `/etc/apt/sources.list` and uncomment there `deb-src` lines. Then run
   `sudo apt update && sudo apt build-dep vim-gtk3`.

### Turtles all the way down

First install [rustup](https://rustup.rs). You can either follow the
instructions on the site, or use snap: `sudo snap instal rustup --classic`.
Then install with it Rust toolchain (the one in Ubuntu package is ancient and
will not work): `rustup toolchain install stable` (no `sudo`!). Then add
`$HOME/.cargo/bin` to your path and install
[mise-en-place](https://mise.jdx.dev/) tool: `cargo install mise --locked` (no
`sudo`!). Notice that [this page](https://mise.jdx.dev/installing-mise.html)
lists other methods of instaling mise, requiring no rustup and Rust, but I did
not try.

When mise is installed, add to your initialization script something like
`eval "$(mise activate bash --shims)"` (could be other command if your shell is
different).

Install node: `mise use -g node@lts`. Then install vim, it is a bit more
convoluted: `ASDF_VIM_CONFIG="--with-tlib=ncurses --enable-multibyte --enable-cscope --enable-terminal --enable-python3interp=yes --enable-gui=gtk3 --with-x" mise use -g vim`. No `sudo` again.

### Verification

- `which node` and `which npm` both should point to the
  `.local/share/mise/shims/` directory in the home directory; `node -v` should
  show version 22.16 at least;
- `which vim` and `which gvim` should point to the same place (if you had vim
  installed from the package run first `hash {,g}vim` just in case).

## Finish installation

Run `vim -es -u vimrc -i NONE -c "PlugInstall" -c "qa"` in the vim config
directory (it takes time and it is silent; for a more interactive experience
just start vim, run `:PlugInstall` and then restart vim).

# Local customization

If `local/vimrc` and `local/gvimrc` exist, they will be read from `vimrc` and
`gvimrc` correspondingly.

If `local/vimrc-colors` exist, it will be read from vimrc in the very end
(most importantly, after `syntax on`).
