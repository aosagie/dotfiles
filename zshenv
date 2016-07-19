export EDITOR=$(which vim)
export TERM="xterm-256color"

case "$OSTYPE" in
  linux*)  export JAVA_HOME="/usr/lib/jvm/java" ;;
  darwin*) export JAVA_HOME=$(/usr/libexec/java_home) ;;
  *)       echo "unknown OSTYPE: $OSTYPE" ;;
esac

typeset -U path # enforce unique paths
path=($HOME/bin /usr/local/sbin $path)

[ -f ~/.zshenv.local ] && source ~/.zshenv.local
