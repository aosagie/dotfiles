# zmodload zsh/zprof #PROFILING
# Configure Zplug
export ZPLUG_HOME=~/.zplug
source $ZPLUG_HOME/init.zsh

zplug "zsh-users/zsh-syntax-highlighting", defer:2 #https://github.com/zsh-users/zsh-syntax-highlighting#why-must-zsh-syntax-highlightingzsh-be-sourced-at-the-end-of-the-zshrc-file
# zplug "zdharma-continuum/fast-syntax-highlighting" #This doesn't work that well
zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-history-substring-search", defer:3 #https://github.com/zsh-users/zsh-history-substring-search#user-content-usage
zplug "ael-code/zsh-colored-man-pages"
# zplug "jeffreytse/zsh-vi-mode" #Scrolling thru history is slow when this is on
# zplug "lukechilds/zsh-nvm"
# zplug "zsh-users/zsh-autosuggestions"
# zplug "plugins/gradle", from:oh-my-zsh # Override broken: /usr/share/zsh/5.5.1/functions/_gradle
zplug "marlonrichert/zsh-hist"
zplug "kutsan/zsh-system-clipboard"
zplug "Aloxaf/fzf-tab"

if ! zplug check; then
  zplug install
fi

zplug load #--verbose

fpath=(~/.zsh/completion $fpath)
if type brew &>/dev/null; then
  fpath=($(brew --prefix)/share/zsh/site-functions ${fpath})
fi

typeset -U path # enforce unique paths
path=($HOME/bin $HOME/.local/bin $HOME/.cargo/bin /usr/local/sbin $path) #Online suggested updating PATH in zshrc instead of zshenv since many environments end up overwriting zshenv changes

# Lines configured by zsh-newuser-install
HISTFILE=~/.zsh_history
SAVEHIST=100000
HISTSIZE=$(($SAVEHIST*1.2)) #Required by zsh-hist: https://github.com/marlonrichert/zsh-hist/blob/670bebd942754ab8c4e9312a6e7027ef17751e6b/functions/hist#L31
unsetopt beep
bindkey -v #Vi mode
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _complete _ignored
zstyle ':completion:*' expand suffix
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' insert-unambiguous true
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' list-suffixes true
zstyle ':completion:*' matcher-list '' 'm:{[:lower:]}={[:upper:]}' '+r:|[._-/]=** r:|=**'
zstyle ':completion:*' menu select=1
zstyle ':completion:*' original true
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle :compinstall filename '$HOME/.zshrc'

autoload -Uz compinit && compinit -i
# End of lines added by compinstall

# Better kill command completion
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,cmd'

# Use fzf-tab with tmux's popup functionality
zstyle ':fzf-tab:*' fzf-command ftb-tmux-popup
zstyle ':fzf-tab:*' fzf-flags '-i' # make fzf case insensitive
# force zsh not to show completion menu, which allows fzf-tab to capture the unambiguous prefix
zstyle ':completion:*' menu no


# Allow access to named colors
autoload -U colors && colors

# Set up the prompt
autoload -Uz promptinit && promptinit

# Pasting with tabs doesn't perform completion
zstyle ':completion:*' insert-tab pending

# Aliases
# commands prefixed with an empty space are not stored in history
case "$OSTYPE" in
  linux*)
    alias ls=' ls -F --color=auto --group-directories-first'
    if type "vimx" > /dev/null; then
      alias vim='vimx' #vim-x11 is used in order to integrate with the clipboard
    fi
    alias vi='vim'
    alias open='xdg-open'
    alias trash='trash-put'
    ;;
  darwin*)
    alias ls=' gls -F --color=auto --group-directories-first'
    alias zcat='gzcat'
    alias cut='gcut'
    alias trash='trash -F'
    ;;
  *)
    echo "unknown OSTYPE: $OSTYPE"
    ;;
esac
alias ll=' ls -lah'
alias rm='rm -i'
alias mv='mv -i'
alias cp='cp -i'
alias rg='rg --smart-case'

# Automatically run 'ls' upon entering a new directory
function chpwd() {
    emulate -L zsh
    ls
}

setopt AUTO_LIST # Automatically list choices on an ambiguous completion
setopt LIST_AMBIGUOUS # In conjunction with AUTO_LIST, only lists when completion is ambiguous
setopt LIST_PACKED # Make completion list smaller
setopt AUTO_CD # Allow moving through directories just by entering their names
setopt AUTO_PUSHD # Keep stack-based history of traversed directories that can be accessed w/ 'popd'
setopt PUSHD_IGNORE_DUPS
setopt NOTIFY # Report status of background jobs immediately, not on next prompt
setopt CHECK_JOBS # Inform of running jobs when trying to exit
setopt PROMPT_SUBST # Command substitution in the prompt
setopt INTERACTIVE_COMMENTS # Allow comments in the command line
setopt HIST_REDUCE_BLANKS
setopt HIST_IGNORE_SPACE
setopt HIST_IGNORE_ALL_DUPS HIST_IGNORE_DUPS
setopt HIST_EXPIRE_DUPS_FIRST
setopt SHARE_HISTORY # Multi-terminal history
setopt APPEND_HISTORY

# Make backspace work normally in vi mode
zle -A .backward-delete-char vi-backward-delete-char

bindkey -M viins 'jj' vi-cmd-mode #enter cmd mode w/ 'jj' instead of just 'ESC'
bindkey -M vicmd 'u' undo
bindkey -M vicmd 'q' push-line #store current line then restore it after you enter new command
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down
bindkey "\e[Z" reverse-menu-complete #shift+tab
# bindkey "^R" history-incremental-search-backward #ctrl+r
bindkey "^[[A" up-line-or-search #up
bindkey "^[[B" down-line-or-search #down

# Turn off terminal driver flow control
# Fixes inability to ctrl-s horizontal splits in terminal vim's CtrlP
stty -ixon -ixoff

ZLE_REMOVE_SUFFIX_CHARS=$' \t\n;&' # Prevent zsh from swallowing space before pipe character i.e. |

KEYTIMEOUT=20 # Give some time to enter two key vi commands - like 'jj'

[ -f ~/.zshrc.local ] && source ~/.zshrc.local

eval "$(starship init zsh)"

# zprof #PROFILING
