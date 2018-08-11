[[ -z $TMUX ]] && export TERM="xterm-256color" #If TMUX is on then let it handle the term colors

export FZF_DEFAULT_COMMAND="rg --files"

case "$OSTYPE" in
  linux*) [ -f ~/.zshenv.linux.local ] && source ~/.zshenv.linux.local ;;
  darwin*) [ -f ~/.zshenv.osx.local ] && source ~/.zshenv.osx.local ;;
  *) echo "unknown OSTYPE: $OSTYPE" ;;
esac

typeset -U path # enforce unique paths
path=($HOME/bin $HOME/.cargo/bin /usr/local/sbin $path)
