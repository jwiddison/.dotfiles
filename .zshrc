################################################################################
# Aliases 
################################################################################

# Divvy
alias cannonball="kafka-cannonball"
alias community="dev && cd community-project/"
alias community-admin="dev && cd community-project/community-admin/"
alias community-api="dev && cd community-project/community/ && source .env"
alias community-mobile="dev && cd community-project/community-mobile/"
alias divvy-elixir-protos="dev && cd elixir_divvy_protobuf/"
alias divvy-protos="dev && cd divvy-protobuf/"
alias ecr-login="dev && ./ecr-login --registry-id 544781154255 && cd -"
alias divvy-flink="dev && cd divvy-flink/"
alias homework="dev && cd homework/"
alias iex-runner="dev && cd iex-runner/"
alias juno="dev && cd juno/"
alias kafka-cannonball="dev && cd kafka-cannonball/"
alias money-mover="dev && cd money-mover/"
alias onboarding="dev && cd onboarding/ && source .env"
alias rfc="dev && cd eng-request-for-change/"
alias stardust="dev && cd stardust/"
alias start-dev="~/.dotfiles/tmux/dev-startup.sh"
alias start-uw="~/.dotfiles/tmux/underwriting-startup.sh"
alias test="mix test"
alias tmp="dev && cd tmp/"
alias underwriting="dev && cd underwriting/ && source .env"
alias uw="underwriting"

# General
alias a="tmux a"
alias advent-of-code="dev && cd tmp/advent_of_code/"
alias branch="current-branch"
alias brewtree="brew deps --tree --installed"
alias c="clear"
alias cb="cargo build"
alias cleanup-docker="docker system prune --all --force"
alias config="cd ~/.config/"
alias cr="cargo run"
alias ct="cargo test"
alias current-branch="git rev-parse --abbrev-ref HEAD | pbcopy && pbpaste"
alias db="start-docker-app && dc up -d postgres"
alias dbfullreset="mix ecto.drop && mix ecto.create && mix ecto.migrate"
alias dc="docker-compose"
alias desktop="cd ~/Desktop/"
alias dev="cd ~/Dev/"
alias documents="cd ~/Documents/"
alias dotfiles="cd ~/.dotfiles/"
alias downloads="cd ~/Downloads/"
alias gap="git add -p"
alias gb="git branch"
alias gco="git checkout"
alias getcurrentip="ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1'"
alias gitlog="git log --oneline --graph --decorate --all"
alias gpom="git pull origin master"
alias gs="git status"
alias k="kubectl"
alias kill-git-branches='git branch | grep -v "master" | xargs git branch -D'
alias kittyconf="v ~/.dotfiles/kitty/kitty.conf"
alias kns="kubens"
alias last-commit-sha="git rev-parse HEAD | tr -d '[:space:]' | pbcopy && pbpaste"
alias lightline="v ~/.dotfiles/vim/lightline.vim"
alias ls="ls -alFG"
alias migrate="mix ecto.migrate"
alias reload="source ~/.zshrc"
alias reloadzsh="reload"
alias rollback="mix ecto.rollback"
alias undo-last-commit="git reset --hard HEAD~1"
alias up="cd .."
alias uuid="uuidgen | tr \"[:upper:]\" \"[:lower:]\" | tr -d '[:space:]' | pbcopy && pbpaste"
alias v="nvim" 
alias vimrc="v ~/.dotfiles/.vimrc"
alias zshrc="v ~/.dotfiles/.zshrc"

################################################################################
# Functions
################################################################################

function advent-ci {
  BLUE='\033[0;34m'
  GREEN='\033[0;32m'
  NC='\033[0m'
  SEPARATOR='--------------------------------------------\n'

  echo -e "\n${GREEN}${SEPARATOR}RUNNING LOCAL CI\n${SEPARATOR}${NC}"
  echo -e "\n${BLUE}${SEPARATOR}FORMATTING\n${SEPARATOR}${NC}"
  mix format
  echo -e "\n${BLUE}${SEPARATOR}LINTING\n${SEPARATOR}${NC}"
  mix credo --strict
  echo -e "\n${BLUE}${SEPARATOR}TESTING\n${SEPARATOR}${NC}"
  mix test
  echo -e "\n${BLUE}${SEPARATOR}DIALYZER\n${SEPARATOR}${NC}"
  mix dialyzer
  echo -e "\n${GREEN}${SEPARATOR}DONE\n${SEPARATOR}${NC}"
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
  # Someday
  # echo -e "\n${BLUE}${SEPARATOR}DIALYZER\n${SEPARATOR}${NC}"
  # mix dialyzer
  echo -e "\n${GREEN}${SEPARATOR}DONE\n${SEPARATOR}${NC}"
}

function credo {
  BLUE='\033[0;34m'
  NC='\033[0m'
  SEPARATOR='--------------------------------------------\n'

  echo -e "\n${BLUE}${SEPARATOR}LINTING\n${SEPARATOR}${NC}"
  mix credo --strict
  echo -e "\n${BLUE}${SEPARATOR}LINTING TEST FILES\n${SEPARATOR}${NC}"
  mix credo -C tests --strict
}

function squash-branch-changes {
  git reset $(git merge-base master $(current-branch))
}
function squash-branch-changes-main {
  git reset $(git merge-base main $(current-branch))
}

function start-docker-app {
  if (! docker version > /dev/null 2>&1 ); then
    BLUE='\033[0;34m'
    GREEN='\033[0;32m'
    NC='\033[0m'
    SEPARATOR='--------------------------------------------\n'
    echo -e "\n${GREEN}${SEPARATOR}STARTING DOCKER APP\n${SEPARATOR}${BLUE}"
    open /Applications/Docker.app
    echo -n "Waiting for Docker to launch."
    while (! docker version > /dev/null 2>&1 ); do
      echo -n "."
      sleep 1
    done
    echo -e "\n\n${GREEN}${SEPARATOR}DONE\n${SEPARATOR}${NC}"
  fi
}

function watchpods() {
  while true; do
    OUTPUT=$(kubectl get pods)
    clear
    echo -n "${OUTPUT}"
    sleep ${1:-5}
  done
}

################################################################################
# Other
################################################################################

# Always use nvim
export EDITOR="/opt/homebrew/bin/nvim"
export VISUAL="$EDITOR"

# ASDF
. $HOME/.asdf/asdf.sh
fpath=(${ASDF_DIR}/completions $fpath)

# ZSH autocomplete
autoload -U compinit && compinit

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Configure powerlevel prompt
source ~/.dotfiles/.p10k.zsh

# Kubernetes
export TILLER_NAMESPACE=default

# Elixir Stuff
# For the shell history
export ERL_AFLAGS="-kernel shell_history enabled"
# Make OpenSSL happy for Erlang
export PATH="/usr/local/opt/openssl@1.1/bin:$PATH"
# For compiling erlang
export KERL_CONFIGURE_OPTIONS="--disable-debug --without-javac --with-ssl=$(brew --prefix openssl@1.1)"
# Enable erlang docs for IEx help function
export KERL_BUILD_DOCS="yes"

# Scala Stuff
# # JVM installed by coursier
export JAVA_HOME="/Users/jordanwiddison/Library/Java/JavaVirtualMachines/corretto-1.8.0_362/Contents/Home"
# export JAVA_HOME="/Users/jordanwiddison/Library/Caches/Coursier/arc/https/github.com/AdoptOpenJDK/openjdk8-binaries/releases/download/jdk8u292-b10/OpenJDK8U-jdk_x64_mac_hotspot_8u292b10.tar.gz/jdk8u292-b10/Contents/Home"
# coursier install directory
export PATH="$PATH:/Users/jordanwiddison/Library/Application Support/Coursier/bin"

# Brew happy with BCLI
export LIBRARY_PATH="$(brew --prefix)/lib"
export CPATH="$(brew --prefix)/include"
