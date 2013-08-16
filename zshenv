export EDITOR="vim"
export TERM="xterm-256color"
export M2_HOME="/opt/apache-maven"
export NODE_PATH="/usr/local/lib/node_modules/:/usr/local/lib/node/"
export HOME_BIN="$HOME/bin"

typeset -U path # ensure unique paths
path=($M2_HOME/bin $HOME_BIN $path)
fpath=(/usr/local/src/zsh-completions/src/ $fpath)

# virtualenv and virtualenvwrapper configuration
export WORKON_HOME="$HOME/.virtualenvs"
export PROJECT_HOME="$HOME/Code"
export VIRTUALENV_USE_DISTRIBUTE=1

[ -f ~/.zshenv.local ] && source ~/.zshenv.local
