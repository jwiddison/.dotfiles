Setup:

Install Homebrew

```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

Generate new SSH key, and add to github

```sh
sh-keygen -t ed25519 -C jordan.widdison@gmail.com
```

Clone dotfiles repo

```sh
git clone git@github.com:jwiddison/.dotfiles.git
```

Install Kitty Terminal

```sh
curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin
```

Update Kitty Icon to use new icon from dotfiles repo

Brew install things you need

```sh
brew install neovim tmux ranger the_silver_searcher
```
