################################################################################
## -- Aliases

abbr -a a "tmux a"
abbr -a aoc "cd ~/Dev/advent-of-code/"
abbr -a advent-of-code "cd ~/Dev/advent-of-code/"
abbr -a branch "current-branch"
abbr -a brewtree "brew deps --tree --installed"
abbr -a c "clear"
abbr -a config "cd ~/.config/"
abbr -a current-branch "git rev-parse --abbrev-ref HEAD | pbcopy && pbpaste"
abbr -a db "start-docker-app && dc up -d postgres"
abbr -a dbfullreset "mix ecto.drop && mix ecto.create && mix ecto.migrate"
abbr -a dc "docker-compose"
abbr -a desktop "cd ~/Desktop/"
abbr -a dev "cd ~/Dev"
abbr -a documents "cd ~/Documents/"
abbr -a dotfiles "cd ~/.dotfiles/"
abbr -a downloads "cd ~/Downloads/"
abbr -a fishconf "nvim ~/.dotfiles/config.fish"
abbr -a gap "git add -p"
abbr -a gb "git branch"
abbr -a gco "git checkout"
abbr -a getcurrentip "ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1'"
abbr -a gitlog "git log --oneline --graph --decorate --all"
abbr -a gpom "git pull origin master"
abbr -a gs "git status"
abbr -a k "kubectl"
abbr -a kill-git-branches 'git branch | grep -v "master" | xargs git branch -D'
abbr -a kns "kubens"
abbr -a last-commit-sha "git rev-parse HEAD | tr -d '[:space:]' | pbcopy && pbpaste"
abbr -a lightline "nvim ~/.dotfiles/vim/lightline.vim"
abbr -a ls "ls -alFG"
abbr -a migrate "mix ecto.migrate"
abbr -a reloadfish "source ~/.config/fish/config.fish"
abbr -a rollback "mix ecto.rollback"
abbr -a start-dev ". ~/.dotfiles/tmux/dev-startup.sh"
abbr -a start-dev "~/.dotfiles/tmux/dev-startup.sh"
abbr -a test "mix test"
abbr -a tmp "cd ~/Dev/tmp/"
abbr -a undo-last-commit "git reset --hard HEAD~1"
abbr -a up "cd .."
abbr -a uuid "uuidgen | tr \"[:upper:]\" \"[:lower:]\" | tr -d '[:space:]' | pbcopy && pbpaste"
abbr -a v "nvim" 
abbr -a vimrc "nvim ~/.dotfiles/.vimrc"
abbr -a zshrc "nvim ~/.dotfiles/.zshrc"

################################################################################
## -- Functions

# Runs a local "CI" check on an elixir project
function ci
  set -f BLUE '\033[0;34m'
  set -f GREEN '\033[0;32m'
  set -f NC '\033[0m'
  set -f SEPARATOR '--------------------------------------------\n'

  echo -e \n"$GREEN$SEPARATOR"RUNNING LOCAL CI\n$SEPARATOR$NC
  echo -e \n"$BLUE$SEPARATOR"FORMATTING\n$SEPARATOR$NC
  mix format
  echo -e DONE
  echo -e \n"$BLUE$SEPARATOR"LINTING\n$SEPARATOR$NC
  mix credo --strict
  echo -e \n"$BLUE$SEPARATOR"TESTING\n$SEPARATOR$NC
  mix test
  echo -e \n"$GREEN$SEPARATOR"DONE\n$SEPARATOR$NC
end

# Runs a local "CI" check on an elixir project (PLUS dialyzer)
function cid
  set -f BLUE '\033[0;34m'
  set -f GREEN '\033[0;32m'
  set -f NC '\033[0m'
  set -f SEPARATOR '--------------------------------------------\n'

  echo -e \n"$GREEN$SEPARATOR"RUNNING LOCAL CI\n$SEPARATOR$NC
  echo -e \n"$BLUE$SEPARATOR"FORMATTING\n$SEPARATOR$NC
  mix format
  echo -e DONE
  echo -e \n"$BLUE$SEPARATOR"LINTING\n$SEPARATOR$NC
  mix credo --strict
  echo -e \n"$BLUE$SEPARATOR"TESTING\n$SEPARATOR$NC
  mix test
  echo -e \n"$BLUE$SEPARATOR"DIALYZER\n$SEPARATOR$NC
  mix dialyzer
  echo -e \n"$GREEN$SEPARATOR"DONE\n$SEPARATOR$NC
end

function squash-branch-changes
  git reset $(git merge-base master $(git rev-parse --abbrev-ref HEAD))
end

function squash-branch-changes-main
  git reset $(git merge-base main $(git rev-parse --abbrev-ref HEAD))
end

# Checks the status of k8s pods. Assumes kubectx and kubens have set context and namespace
function watchpods --argument interval
  set -q interval[1]
  or set interval 5

  while true;
    set OUTPUT $(kubectl get pods)
    clear
    echo -n $OUTPUT
    sleep $interval;
  end
end

################################################################################
## -- Plugins

# ASDF
# If installing with git:
source ~/.asdf/asdf.fish
# If installing with homebrew:
# source /usr/local/opt/asdf/libexec/asdf.fish
# Also, run this command once after installing (git):
# $ mkdir -p ~/.config/fish/completions; and ln -s ~/.asdf/completions/asdf.fish ~/.config/fish/completions
# If installing with homebrew, run this once:
# $ echo -e "\nsource "(brew --prefix asdf)"/libexec/asdf.fish" >> ~/.config/fish/config.fish
# (And probably move what it adds to the base fish config file into here)

################################################################################
## -- Env

# Turn off the hello message on startup
set fish_greeting

# Always use nvim
set -Ux EDITOR $(which nvim)
set -Ux VISUAL $EDITOR

# Separators (For tmux/vim bars)
set -Ux LEFT_SEPARATOR ""
set -Ux LEFT_SUB_SEPARATOR "/"
set -Ux RIGHT_SEPARATOR ""
set -Ux RIGHT_SUB_SEPARATOR "/"

# Elixir / Erlang
set -Ux ERL_AFLAGS "-kernel shell_history enabled"
set -Ux KERL_BUILD_DOCS "yes"
set -Ux KERL_CONFIGURE_OPTIONS "--without-javac \
  --disable-jit \
  --disable-parallel-configure \
  --with-ssl=$(brew --prefix openssl@3) \
  --with-wx-config=$(brew --prefix wxwidgets)/bin/wx-config"
# If setting up erlang for the first time, run this once openssl@1.1 is installed:
# $ fish_add_path /usr/local/opt/openssl@1.1/bin

# TODO Decide if I actually want starship or not
# Starship (Needs to go last)
# starship init fish | source
