[[ -z $TMUX ]] && export TERM="xterm-256color" #If TMUX is on then let it handle the term colors

export FZF_DEFAULT_COMMAND="rg --files"
export RIPGREP_CONFIG_PATH="$HOME/.ripgreprc"
export ZVM_VI_ESCAPE_BINDKEY="jj"

case "$OSTYPE" in
  linux*)
      export JAVA_HOME="/etc/alternatives/jre"
      if type "vimx" > /dev/null; then
        export EDITOR=$(which vimx) #vimx is vim with xterm clipboard support
      else
        export EDITOR=$(which vim)
      fi
      # export PYTHONPATH=/usr/lib/python2.7/site-packages/
      ;;
  darwin*)
      export JAVA_HOME=$(/usr/libexec/java_home -v 17)
      export EDITOR=$(which vim)
      # export PYTHONPATH=/usr/local/lib/python2.7/site-packages
      ;;
  *)
      echo "unknown OSTYPE: $OSTYPE"
      ;;
esac

[ -f ~/.zshenv.local ] && source ~/.zshenv.local
