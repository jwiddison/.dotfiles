# Dev Setup Help

Just some notes about all the steps to set up my dev environment

## Homebrew
```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

## Git

Generate new SSH key, and add to github

```sh
sh-keygen -t ed25519 -C jordan.widdison@gmail.com
```

## Clone dotfiles repo

```sh
git clone git@github.com:jwiddison/.dotfiles.git
```

This will make you install the xcode developer tools. That's good.

## System Config files

Copy the example config files for kitty, zsh, vim, and tmux out of the
dotfiles repo and into your system config files.
Also copy over the .gitignore and .gitconfig.

```sh
cp ~/.dotfiles/.vimrc ~/.vimrc
cp ~/.dotfiles/.zshrc ~/.zshrc
cp ~/.dotfiles/.tmux.conf ~/.tmux.conf
cp ~/.dotfiles/kitty/kitty.conf ~/.config/kitty/kitty.conf
cp ~/.dotfiles/.gitignore ~/.gitignore
cp ~/.dotfiles/.gitconfig ~/.gitconfig
```

## Ranger

We already brew-installed `highlight` which we need for highlighed previews

Generate the config file:

```sh
ranger --copy-config=scope
```

Change the line with `HIGHLIGHT_STYLE` to

```sh
HIGHLIGHT_STYLE=base16/material
```

Or whatever theme you want for the previews

## Install Kitty Terminal

```sh
curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin
```

Or you can get a DMG from their [github releases](https://github.com/kovidgoyal/kitty/releases) if on an Apple silicon macs

You can also update kitty to use the icon included in the dotfiles repo if you want.

## Brew Install

```sh
brew install neovim tmux ranger the_silver_searcher highlight
```

## Vundle

```sh
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
```

## Prezto

```sh
git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"

setopt EXTENDED_GLOB
for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
  ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
done
```

Change the prompt theme .zpreztorc to
```
zstyle ':prezto:module:prompt' theme 'powerlevel10k'
```

It should pull the config from dotfiles automagically.

Can also add `'autosuggestions'` to the list at the top
and remove `'history-substring-search' \`

## Fonts

# TODO

[Nerd Font Icons](https://www.nerdfonts.com/cheat-sheet)

## TMUX

[Make Italics / Colors Work With TMUX](https://medium.com/@dubistkomisch/how-to-actually-get-italics-and-true-colour-to-work-in-iterm-tmux-vim-9ebe55ebc2be)

To fix the colors/fonts/italics in TMUX:

Create xterm-256color-italic.terminfo:

```
xterm-256color-italic|xterm with 256 colors and italic,
  sitm=\E[3m, ritm=\E[23m,
  use=xterm-256color,
```

And tmux-256color.terminfo:

```
tmux-256color|tmux with 256 colors,
  ritm=\E[23m, rmso=\E[27m, sitm=\E[3m, smso=\E[7m, Ms@,
  khome=\E[1~, kend=\E[4~,
  use=xterm-256color, use=screen-256color,
```

Then to install them, run:

```sh
tic -x xterm-256color-italic.terminfo
tic -x tmux-256color.terminfo
```

After running that you can safely delete these files

## ASDF

```sh
brew install coreutils curl git
git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.8.0
```

The necessary zsh config should already be in the .zshrc
(Note the difference depending on whether or not you're on a 0.8 version or higher)
You might need to change how it does the completions stuff.
[This Article](https://stackoverflow.com/questions/13762280/zsh-compinit-insecure-directories) is helpful if there are issues

### Erlang

```sh
brew install autoconf wxmac
asdf plugin-add erlang
```

Might be worth looking into the new-ish thing to pull pre-built binaries

### Elixir

```sh
brew install unzip
asdf plugin-add elixir
```

### Node

```sh
brew install gpg gawk
asdf plugin-add nodejs
```

## Elixir-LS

```sh
git clone https://github.com/elixir-lsp/elixir-ls
cd elixir-ls
mix deps.get
mix compile
mix elixir_ls.release -o rel
```
