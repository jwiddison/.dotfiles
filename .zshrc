# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

###############
### Aliases ###
###############

## Divvy-Specific ##
alias cash="dev && cd cash-accounts/"
alias config="cd ~/.config/"
alias dev="cd ~/Dev/"
alias dotfiles="cd ~/.dotfiles/"
alias expulsar="dev && cd ex_pulsar/"
alias juno="dev && cd juno/"
alias rfc="dev && cd eng-request-for-change/"
alias stardust="dev && cd stardust/"
alias startpg="./.pkg/dev/start-database.sh"
alias tmp="dev && cd tmp/"
alias vela="dev && cd vela/"
alias vexpulsar="expulsar && v"
alias vvela="vela && v"

## Divvy-Specific Functions

function change_kitty_theme {
  # See themes at: https://github.com/dexpota/kitty-themes#user-content-3024-day
  rm ~/.config/kitty/theme.conf
  ln -s ./kitty-themes/themes/$1.conf ~/.config/kitty/theme.conf
}

function ci {
  echo "Formatting:\n"
  mix format
  echo "Checking Formatting:\n"
  mix format --check-formatted
  echo "Linting:\n"
  mix credo
  echo "Security:\n"
  mix sobelow
  echo "Testing:\n"
  mix test
  echo "Dialyzer:\n"
  mix dialyzer
}

function junoup {
  echo "Getting environment variables:\n"
  export $(cat .env | xargs)
  echo "DONE\n"
  echo "Setting up Postgres:\n"
  startpg
  echo "Getting deps:\n"
  mix deps.get
}

function pulsar-admin {
  docker exec -it $(docker ps --format "{{ .Image }} {{ .ID }}" |
  grep apachepulsar/pulsar |
  awk '{ print $2 }') bin/pulsar-admin
}

function startpulsar {
  expulsar
  echo "Starting Pulsar:\n"
  docker-compose -f .pkg/docker-compose.yml up -d pulsar
}

## System-wide ##
alias brewtree="brew deps --tree --installed"
alias c="clear"
alias check-the-weather="curl https://wttr.in/slc"
alias cleanup-docker="docker system prune --all --force"
alias dc="docker-compose"
alias desktop="cd ~/Desktop/"
alias documents="cd ~/Documents/"
alias downloads="cd ~/Downloads/"
alias erlangv="erl -eval '{ok, Version} = file:read_file(filename:join([code:root_dir(), \"releases\", erlang:system_info(otp_release), \"OTP_VERSION\"])), io:fwrite(Version), halt()' -noshell"
alias export-vscode-extension="code --list-extensions | xargs -L 1 echo code --install-extension"
alias gap="git add -p"
alias gb="git branch"
alias gco="git checkout"
alias getcurrentip="ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1'"
alias git-log-with-dates="git log --pretty=format:\"%h%x09%an%x09%ad%x09%s\""
alias gitlog="git log --oneline --graph --decorate --all"
alias gp="git push origin HEAD"
alias gpom="git pull origin master"
alias gs="git status"
alias k="kubectl"
alias kill-git-branches='git branch | grep -v "master" | xargs git branch -D'
alias kns="kubens"
alias lightline="v ~/.dotfiles/vim/.vimrc-lightline"
# gls depends on CoreUtils being brew installed 
# alias ls="gls -alF --group-directories-first --color=auto"
alias ls="ls -alFG"
alias plugins="v ~/.dotfiles/vim/.vimrc-plugins"
alias pr="dopen p"
alias reloadzsh="source ~/.zshrc"
alias see-kitty-themes="open https://github.com/dexpota/kitty-themes#user-content-3024-day"
alias up="cd .."
alias uuid="uuidgen | tr \"[:upper:]\" \"[:lower:]\" | tr -d '[:space:]' | pbcopy && pbpaste"
alias v="nvim" 
alias vimrc="v ~/.dotfiles/.vimrc"
alias zshrc="v ~/.dotfiles/.zshrc"

## Rails ##
alias dbfullreset="bundle exec rails db:drop db:create db:migrate db:seed db:fixtures:load"
alias kill-rails='kill -9 $(lsof -i tcp:3000 -t)'
alias migrate="bundle exec rails db:migrate"
alias rc="bundle exec rails c"
alias rs="bundle exec rails s"
alias rsb="bundle exec rails s -b 0.0.0.0"
alias rsp="bundle exec rails s -p 3001"
alias rsp2="bundle exec rails s -p 3002"

####################
### Other Config ###
####################

# Make tmux happy
export TERM="xterm-256color"

## ASDF
autoload -Uz compinit
compinit
. $HOME/.asdf/asdf.sh
. $HOME/.asdf/completions/asdf.bash

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Configure powerlevel prompt
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Powerlevel10k
source ~/.powerlevel10k/powerlevel10k.zsh-theme

# Kubernetes
export TILLER_NAMESPACE=default
