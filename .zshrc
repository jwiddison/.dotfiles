################################################################################
# Aliases 
################################################################################

alias a="tmux a"
alias brew="arch -arm64 brew"
alias brewtree="brew deps --tree --installed"
alias c="clear"
alias config="cd ~/.config/"
alias current-branch="git rev-parse --abbrev-ref HEAD | pbcopy && pbpaste"
alias db="start-docker-app && dc up -d postgres"
alias dc="docker-compose"
alias desktop="cd ~/Desktop/"
alias dev="cd ~/Dev/"
alias documents="cd ~/Documents/"
alias dotfiles="cd ~/.dotfiles/"
alias downloads="cd ~/Downloads/"
alias gap="git add -p"
alias gco="git checkout"
alias getcurrentip="ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1'"
alias gitlog="git log --oneline --graph --decorate --all"
alias gpom="git pull origin master"
alias gs="git status"
alias k="kubectl"
alias kctx="kubectx"
alias kill-git-branches='git branch | grep -v "master" | xargs git branch -D'
alias kittyconf="v ~/.dotfiles/kitty/kitty.conf"
alias kns="kubens"
alias last-commit-sha="git rev-parse HEAD | tr -d '[:space:]' | pbcopy && pbpaste"
alias ls="ls -alFG"
alias reloadzsh="source ~/.zshrc"
alias start-dev="~/.dotfiles/tmux/dev-startup.sh"
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
autoload -U compinit && compinit

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Configure powerlevel prompt
source ~/.dotfiles/.p10k.zsh

# Elixir / Erlang Stuff
export ERL_AFLAGS="-kernel shell_history enabled"
export KERL_BUILD_DOCS="yes"
export KERL_CONFIGURE_OPTIONS="--without-javac \
  --disable-parallel-configure \
  --with-ssl=$(brew --prefix openssl@3) \
  --with-wx-config=$(brew --prefix wxwidgets)/bin/wx-config"
