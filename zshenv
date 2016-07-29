export TERM="xterm-256color"

case "$OSTYPE" in
  linux*)
      export JAVA_HOME="/usr/lib/jvm/java"
      export EDITOR="/usr/bin/vim"
      ;;
  darwin*)
      export JAVA_HOME=$(/usr/libexec/java_home)
      export EDITOR="/usr/local/bin/vim"
      ;;
  *)
      echo "unknown OSTYPE: $OSTYPE" ;;
esac

typeset -U path # enforce unique paths
path=($HOME/bin /usr/local/sbin $path)

[ -f ~/.zshenv.local ] && source ~/.zshenv.local
