[[ -z $TMUX ]] && export TERM="xterm-256color" #If TMUX is on then let it handle the term colors

case "$OSTYPE" in
  linux*)
      export JAVA_HOME="/usr/lib/jvm/java"
      export EDITOR="/usr/bin/vim"
      export PYTHONPATH=/usr/lib/python2.7/site-packages/
      ;;
  darwin*)
      export JAVA_HOME=$(/usr/libexec/java_home)
      export EDITOR="/usr/local/bin/vim"
      export PYTHONPATH=/usr/local/lib/python2.7/site-packages
      ;;
  *)
      echo "unknown OSTYPE: $OSTYPE" ;;
esac

export FZF_DEFAULT_COMMAND="rg --files --follow"

typeset -U path # enforce unique paths
path=($HOME/bin /usr/local/sbin $path)

[ -f ~/.zshenv.local ] && source ~/.zshenv.local
