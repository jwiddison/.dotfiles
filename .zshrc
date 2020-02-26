###############
### Aliases ###
###############

## Divvy-Specific ##
alias cash="dev && cd cash-accounts/"
alias dev="cd ~/Dev/"
alias dotfiles="cd ~/.dotfiles/"
alias expulsar="dev && cd ex_pulsar/"
alias juno="dev && cd juno/"
alias rfc="dev && cd eng-request-for-change/"
alias stardust="dev && cd stardust/"
alias startpg="./.pkg/dev/start-database.sh"
alias tmp="dev && cd tmp/"
alias vela="dev && cd vela/"

getenv () {
  export $(cat .env | xargs)
}

junoup () {
  echo "Getting environment variables:\n"
  getenv
  echo "DONE\n"
  echo "Setting up Postgres:\n"
  startpg
  echo "Getting deps:\n"
  mix deps.get
}

startpulsar() {
  echo "Starting Pulsar:\n"
  expulsar
  docker-compose -f .pkg/docker-compose.yml up -d pulsar
}

## System-wide ##
alias brewtree="brew deps --tree --installed"
alias c="code ."
alias check-the-weather="curl https://wttr.in/slc"

ci() {
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

alias cleanup-docker="docker system prune --all --force"
alias desktop="cd ~/Desktop/"
alias documents="cd ~/Documents/"
alias downloads="cd ~/Downloads/"
alias erlangv="erl -eval '{ok, Version} = file:read_file(filename:join([code:root_dir(), \"releases\", erlang:system_info(otp_release), \"OTP_VERSION\"])), io:fwrite(Version), halt()' -noshell"
alias export-vscode-extension="code --list-extensions | xargs -L 1 echo code --install-extension"
alias gb="git branch"
alias gco="git checkout"
alias getcurrentip="ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1'"
alias gitlog="git log --oneline --graph --decorate --all"
alias git-log-with-dates="git log --pretty=format:\"%h%x09%an%x09%ad%x09%s\""
alias gs="git status"
alias gp="git push origin HEAD"
alias gpom="git pull origin master"
alias kill-git-branches='git branch | grep -v "master" | xargs git branch -D'
# gls depends on CoreUtils being brew installed 
alias ls="gls -alF --group-directories-first --color=auto"
alias pr="dopen p"
alias reloadzsh="source ~/.zshrc"
alias up="cd .."
alias uuid="uuidgen | tr \"[:upper:]\" \"[:lower:]\" | tr -d '[:space:]' | pbcopy && pbpaste"
alias v="nvim" 
alias vimrc="v ~/.dotfiles/.vimrc"
alias plugins="v ~/.dotfiles/vim/.vimrc-plugins"
alias lightline="v ~/.dotfiles/vim/.vimrc-lightline"
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

## ASDF
autoload -Uz compinit
compinit
. $HOME/.asdf/asdf.sh
. $HOME/.asdf/completions/asdf.bash

## ZSH
# Zsh autocomplete
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
# Configure NerdFonts and Powerlevel9k
POWERLEVEL9K_MODE='nerdfont-complete'
source ~/.powerlevel9k/powerlevel9k.zsh-theme
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=()
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(dir vcs newline status)

plugins=(autojump)

## Kubernetes
export TILLER_NAMESPACE=default
