# .dotfiles

My dotfiles. To get set up:

## Install Homebrew

```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

## Git

Generate new SSH key, and add to github/gitlab

```sh
sh-keygen -t ed25519 -C jordan.widdison@gmail.com
cat ~/.ssh/{{filename}}.pub
```
If you don't have git (MacOS):

```sh
xcode-select --install
```

## Clone Dotfiles Repo

```sh
git clone git@github.com:jwiddison/.dotfiles.git
```

This will make you install the xcode developer tools if you haven't already.

## System Config Files

Copy the example config files for fish, vim, tmux, etc out of the dotfiles repo and into your system config files.
Also copy over the .gitignore and .gitconfig.

```sh
cp ~/.dotfiles/example_system_config_files/.vimrc ~/.vimrc
cp ~/.dotfiles/example_system_config_files/init.vim ~/.config/nvim/init.vim
cp ~/.dotfiles/example_system_config_files/.tmux.conf ~/.tmux.conf
cp ~/.dotfiles/example_system_config_files/config.fish ~/.config/fish/config.fish
cp ~/.dotfiles/.gitignore ~/.gitignore
cp ~/.dotfiles/.gitconfig ~/.gitconfig
```

## Change shell to fish

```sh
chsh -s $(which fish)
```

## Brew Install All the Things

TODO: Figure out if I still need the `arch -arm64` prefix anymore.
I probably don't.

```sh
arch -arm64 brew install fish neovim tmux ranger the_silver_searcher highlight
```

## Ranger

We already brew-installed `highlight` which we need for highlighed previews

Generate ranger's config file:

```sh
ranger --copy-config=scope
```

Change the line with `HIGHLIGHT_STYLE` to

```sh
HIGHLIGHT_STYLE=base16/material
```

Or whatever theme you want for the previews

## Install Ghostty Terminal

[Download Link](https://ghostty.org/download)

## Vundle

```sh
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
```

## COC

If COC is giving you an error about `coc.nvim] build/index.js not found, please compile coc.nvim by: npm run build` 
change into the `~/.vim/bundle/coc.nvim/` folder and run `yarn install ; yarn build`. Make sure you have
some version of node installed via asdf, and brew install yarn if you need it.

## Fonts

Fonts are included in `fonts/` if you need them.
You shouldn't need them though.
Ghostty includes a nerdfont-patched version of JetBrains Mono already.

## TMUX

TODO: This section MIGHT not be necessary with Ghostty.
If everything looks fine, just ignore this part.

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

## ASDF (tool version manager)

```sh
arch -arm64 brew install coreutils curl git
git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.8.0
```

The necessary fish config should already be in your shell profile
(Note the difference depending on whether or not you're on a 0.8 version or higher)
You might need to change how it does the completions stuff.
[This Article](https://stackoverflow.com/questions/13762280/zsh-compinit-insecure-directories) is helpful if there are issues

### Erlang

NOTE: I think brew stopped distributing openssl 1.1.
Might need to figure out something else here.
Although, I don't think it's required after OTP 25.

```sh
arch -arm64 brew install autoconf wxwidgets openssl@1.1 libxslt fop
asdf plugin-add erlang
```
Might be worth looking into the new-ish thing to pull pre-built binaries

### Elixir

```sh
arch -arm64 brew install unzip
asdf plugin-add elixir
```

### Node (Required for COC)

```sh
arch -arm64 brew install yarn gpg gawk
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
