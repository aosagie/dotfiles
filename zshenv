export EDITOR="vim"
export TERM="xterm-256color"
export MAVEN_HOME="/opt/apache-maven/bin"
export NODE_PATH="/usr/local/lib/node_modules/:/usr/local/lib/node/"
export TMUX_BIN="/opt/tmux/bin"

typeset -U path # ensure unique paths
path=($TMUX_BIN $MAVEN_HOME $path)

# virtualenv and virtualenvwrapper configuration
export WORKON_HOME="$HOME/.virtualenvs"
export PROJECT_HOME="$HOME/Code"
export VIRTUALENV_USE_DISTRIBUTE=1
