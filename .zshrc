#######################
### Jordan Widdison ###
#######################

# Bring in functions
source ~/.dotfiles/zsh/.zshrc.functions
source ~/.dotfiles/zsh/.zshrc.just-for-fun

###############
### Aliases ###
###############

## Divvy ##
alias cash="dev && cd cash-accounts/ && source .env"
alias config="cd ~/.config/"
alias dev="cd ~/Dev/"
alias divvy-elixir-protos="dev && cd elixir_divvy_protobuf/"
alias divvy-protos="dev && cd divvy-protobuf/"
alias dotfiles="cd ~/.dotfiles/"
alias go="start-underwriting-session"
alias juno="dev && cd juno/"
alias rfc="dev && cd eng-request-for-change/"
alias stardust="dev && cd stardust/"
alias start-home-dev-session="~/.dotfiles/tmux/home-dev-startup.sh"
alias start-cash-session="~/.dotfiles/tmux/cash-startup.sh"
alias start-underwriting-session="~/.dotfiles/tmux/underwriting-startup.sh"
alias startpg="./.pkg/dev/start-database.sh"
alias tmp="dev && cd tmp/"
alias under="underwriting"
alias underwriting="dev && cd underwriting/ && source .env"
alias vela="dev && cd vela/"

## System ##
alias a="tmux a"
alias brewtree="brew deps --tree --installed"
alias c="clear"
alias check-the-weather="curl https://wttr.in/slc"
alias cleanup-docker="docker system prune --all --force"
alias dc="docker-compose"
alias desktop="cd ~/Desktop/"
alias documents="cd ~/Documents/"
alias downloads="cd ~/Downloads/"
alias export-vscode-extension="code --list-extensions | xargs -L 1 echo code --install-extension"
alias gap="git add -p"
alias gb="git branch"
alias gco="git checkout"
alias getcurrentip="ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1'"
alias git-log-with-dates="git log --pretty=format:\"%h%x09%an%x09%ad%x09%s\""
alias gitlog="git log --oneline --graph --decorate --all"
alias gpom="git pull origin master"
alias gs="git status"
alias k="kubectl"
alias kill-git-branches='git branch | grep -v "master" | xargs git branch -D'
alias kns="kubens"
alias ls="ls -alFG"
alias migrate="mix ecto.migrate"
alias n="ranger"
alias pr="dopen p"
alias reload="source ~/.zshrc"
alias reloadzsh="reload"
alias rollback="mix ecto.rollback"
alias undo-last-commit="git reset --hard HEAD~1"
alias up="cd .."
alias uuid="uuidgen | tr \"[:upper:]\" \"[:lower:]\" | tr -d '[:space:]' | pbcopy && pbpaste"
alias v="nvim" 
alias vimrc="v ~/.dotfiles/.vimrc"
alias zshrc="v ~/.dotfiles/.zshrc"

## Rails ##
alias dbfullreset="bundle exec rails db:drop db:create db:migrate db:seed db:fixtures:load"
alias kill-rails='kill -9 $(lsof -i tcp:3000 -t)'
alias rails_migrate="bundle exec rails db:migrate"
alias rc="bundle exec rails c"
alias rs="bundle exec rails s"
alias rsb="bundle exec rails s -b 0.0.0.0"
alias rsp="bundle exec rails s -p 3001"
alias rsp2="bundle exec rails s -p 3002"

####################
### Other Config ###
####################

# Always use nvim
export EDITOR="/usr/local/bin/nvim"
export VISUAL="$EDITOR"

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
source ~/.dotfiles/.p10k.zsh

# Kubernetes
export TILLER_NAMESPACE=default
