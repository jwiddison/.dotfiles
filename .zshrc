# ============================================================================ #
# ==== .zshrc - Jordan Widdison ============================================== #
# ============================================================================ #

################################################################################
# Aliases 
################################################################################

### Work #######################################################################
alias cash="dev && cd cash-accounts/ && source .env"
alias config="cd ~/.config/"
alias community="dev && cd community-project/"
alias community-admin="dev && cd community-project/community-admin/"
alias community-api="dev && cd community-project/community/ && source .env"
alias community-mobile="dev && cd community-project/community-mobile/"
alias dev="cd ~/Dev/"
alias divvy-elixir-protos="dev && cd elixir_divvy_protobuf/"
alias divvy-protos="dev && cd divvy-protobuf/"
alias ecr-login="dev && ./ecr-login --registry-id 544781154255 && cd -"
alias go="start-underwriting-session"
alias juno="dev && cd juno/"
alias onboarding="dev && cd onboarding/ && source .env"
alias pii="dev && cd pii/"
alias rfc="dev && cd eng-request-for-change/"
alias rg="~/.dotfiles/tmux/home-dev-startup.sh"
alias ride-guides="dev && cd ride_guides_api/"
alias stardust="dev && cd stardust/"
alias start-community="~/.dotfiles/tmux/home-dev-startup.sh"
alias start-juno-pg="./.pkg/dev/start-database.sh"
alias start-juno-session="~/.dotfiles/tmux/juno-startup.sh"
alias start-underwriting-session="~/.dotfiles/tmux/underwriting-startup.sh"
alias start-uw="start-underwriting-session"
alias start-vault="cd ~/Dev/pii/ && ./bin/dev up -d && cd -"
alias tmp="dev && cd tmp/"
alias u="underwriting"
alias underwriting="dev && cd underwriting/ && source .env"
alias uw="underwriting"
alias vela="dev && cd vela/"

function junoup {
  echo "Setting Up Juno:\n"
  cd ~/Dev/juno/
  echo "Getting environment variables:\n"
  export $(cat .env | xargs)
  echo "DONE\n"
  echo "Setting up Postgres:\n"
  start-juno-pg
  echo "Getting deps:\n"
  mix deps.get
}

function uwup-nokafka {
  BLUE='\033[0;34m'
  GREEN='\033[0;32m'
  NC='\033[0m'
  SEPARATOR='--------------------------------------------\n'

  echo -e "\n${GREEN}${SEPARATOR}SETTING UP UNDERWRITING\n${SEPARATOR}${NC}"
  cd ~/Dev/underwriting
  source .env
  echo -e "\n${BLUE}${SEPARATOR}STARTING POSTGRES\n${SEPARATOR}${NC}"
  docker-compose -f .pkg/dev/docker-compose.yml up -d postgres
  echo -e "\n${BLUE}${SEPARATOR}STARTING REDIS\n${SEPARATOR}${NC}"
  docker-compose -f .pkg/dev/docker-compose.yml up -d redis
  echo -e "\n${BLUE}${SEPARATOR}STARTING VAULT & CONSUL\n${SEPARATOR}${NC}"
  cd ~/Dev/pii
  ./bin/dev up -d
  cd -
  echo -e "\n${BLUE}${SEPARATOR}GETTING DEPS\n${SEPARATOR}${NC}"
  mix deps.get
  echo -e "\n${BLUE}${SEPARATOR}SETTING UP DATABASE\n${SEPARATOR}${NC}"
  mix ecto.setup
  echo -e "\n${GREEN}${SEPARATOR}DONE\n${SEPARATOR}${NC}"
}

function uwup {
  BLUE='\033[0;34m'
  GREEN='\033[0;32m'
  NC='\033[0m'
  SEPARATOR='--------------------------------------------\n'

  echo -e "\n${GREEN}${SEPARATOR}SETTING UP UNDERWRITING\n${SEPARATOR}${NC}"
  cd ~/Dev/underwriting
  source .env
  echo -e "\n${BLUE}${SEPARATOR}STARTING POSTGRES\n${SEPARATOR}${NC}"
  docker-compose -f .pkg/dev/docker-compose.yml up -d postgres
  echo -e "\n${BLUE}${SEPARATOR}STARTING REDIS\n${SEPARATOR}${NC}"
  docker-compose -f .pkg/dev/docker-compose.yml up -d redis
  echo -e "\n${BLUE}${SEPARATOR}STARTING KAFKA\n${SEPARATOR}${NC}"
  docker-compose -f .pkg/dev/docker-compose.yml up -d kafka
  docker-compose -f .pkg/dev/docker-compose.yml up -d kafka-cannonball kafka-connect-ui kafka-ui
  echo -e "\n${BLUE}${SEPARATOR}STARTING VAULT & CONSUL\n${SEPARATOR}${NC}"
  cd ~/Dev/pii
  ./bin/dev up -d
  cd -
  echo -e "\n${BLUE}${SEPARATOR}GETTING DEPS\n${SEPARATOR}${NC}"
  mix deps.get
  echo -e "\n${BLUE}${SEPARATOR}SETTING UP DATABASE\n${SEPARATOR}${NC}"
  mix ecto.setup
  echo -e "\n${GREEN}${SEPARATOR}DONE\n${SEPARATOR}${NC}"
}

### System #####################################################################
alias a="tmux a"
alias brewtree="brew deps --tree --installed"
alias c="clear"
alias check-the-weather="curl https://wttr.in/slc"
alias cleanup-docker="docker system prune --all --force"
alias dbfullreset="mix ecto.drop && mix ecto.create && mix ecto.migrate"
alias dc="docker-compose"
alias desktop="cd ~/Desktop/"
alias documents="cd ~/Documents/"
alias dotfiles="cd ~/.dotfiles/"
alias downloads="cd ~/Downloads/"
alias gap="git add -p"
alias gb="git branch"
alias gco="git checkout"
alias getcurrentip="ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1'"
alias git-log-with-dates="git log --pretty=format:\"%h%x09%an%x09%ad%x09%s\""
alias gitlog="git log --oneline --graph --decorate --all"
alias gpom="git pull origin master"
alias gs="git status"
alias jw="dev && cd jw/"
alias k="kubectl"
alias kill-git-branches='git branch | grep -v "master" | xargs git branch -D'
alias kittyconf="v ~/.dotfiles/kitty/kitty.conf"
alias kns="kubens"
alias last-commit-sha="git rev-parse HEAD | tr -d '[:space:]' | pbcopy && pbpaste"
alias ls="ls -alFG"
alias migrate="mix ecto.migrate"
alias n="ranger"
alias pr="dopen p"
alias reload-tmux="tmux source-file ~/.tmux.conf"
alias reload="source ~/.zshrc"
alias reloadzsh="reload"
alias rollback="mix ecto.rollback"
alias undo-last-commit="git reset --hard HEAD~1"
alias up="cd .."
alias uuid="uuidgen | tr \"[:upper:]\" \"[:lower:]\" | tr -d '[:space:]' | pbcopy && pbpaste"
alias v="nvim" 
alias vimrc="v ~/.dotfiles/.vimrc"
alias zshrc="v ~/.dotfiles/.zshrc"

### Rails ######################################################################
# alias dbfullreset="bundle exec rails db:drop db:create db:migrate db:seed db:fixtures:load"
# alias kill-rails='kill -9 $(lsof -i tcp:3000 -t)'
# alias rails_migrate="bundle exec rails db:migrate"
# alias rc="bundle exec rails c"
# alias rs="bundle exec rails s"
# alias rsb="bundle exec rails s -b 0.0.0.0"
# alias rsp="bundle exec rails s -p 3001"
# alias rsp2="bundle exec rails s -p 3002"

### Elixir #####################################################################
export ERL_AFLAGS="-kernel shell_history enabled"

### Functions ##################################################################
function credo {
  echo "Linting:\n"
  mix credo --strict
  echo "Linting Test Files:\n"
  mix credo -C tests --strict
}

function ci {
  BLUE='\033[0;34m'
  GREEN='\033[0;32m'
  NC='\033[0m'
  SEPARATOR='--------------------------------------------\n'

  echo -e "\n${GREEN}${SEPARATOR}RUNNING LOCAL CI\n${SEPARATOR}${NC}"
  echo -e "\n${BLUE}${SEPARATOR}FORMATTING\n${SEPARATOR}${NC}"
  mix format
  echo -e "\n${BLUE}${SEPARATOR}CHECKING FORMATTING\n${SEPARATOR}${NC}"
  mix format --check-formatted
  echo -e "\n${BLUE}${SEPARATOR}LINTING\n${SEPARATOR}${NC}"
  mix credo --strict
  echo -e "\n${BLUE}${SEPARATOR}LINTING TEST FILES\n${SEPARATOR}${NC}"
  mix credo -C tests --strict
  echo -e "\n${BLUE}${SEPARATOR}TESTING\n${SEPARATOR}${NC}"
  mix test
  echo -e "\n${GREEN}${SEPARATOR}DONE\n${SEPARATOR}${NC}"
}

################################################################################
# Other Config
################################################################################

# Always use nvim
export EDITOR="/usr/local/bin/nvim"
export VISUAL="$EDITOR"

# ASDF
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
