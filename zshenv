[[ -z $TMUX ]] && export TERM="xterm-256color" #If TMUX is on then let it handle the term colors

export FZF_DEFAULT_COMMAND="rg --files"

case "$OSTYPE" in
  linux*)
      export JAVA_HOME="/usr/lib/jvm/java"
      export EDITOR="/usr/bin/vimx"
      # export PYTHONPATH=/usr/lib/python2.7/site-packages/
      ;;
  darwin*)
      export JAVA_HOME=$(/usr/libexec/java_home -v 1.8)
      export EDITOR="/usr/local/bin/vim"
      # export PYTHONPATH=/usr/local/lib/python2.7/site-packages
      ;;
  *)
      echo "unknown OSTYPE: $OSTYPE"
      ;;
esac

typeset -U path # enforce unique paths
path=($HOME/bin $HOME/.local/bin $HOME/.cargo/bin /usr/local/sbin $path)

[ -f ~/.zshenv.local ] && source ~/.zshenv.local
