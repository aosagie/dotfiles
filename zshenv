export EDITOR="vim"
export TERM="xterm-256color"
export MAVEN_HOME="/opt/apache-maven/bin"
export NODE_PATH="/usr/local/lib/node_modules/:/usr/local/lib/node/"

typeset -U path
path=($MAVEN_HOME $path)

# virtualenv and virtualenvwrapper configuration
export WORKON_HOME="$HOME/.virtualenvs"
export PROJECT_HOME="$HOME/workspace"
export VIRTUALENV_USE_DISTRIBUTE=1
