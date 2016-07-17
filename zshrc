# CONFIGURE ZPLUG
export ZPLUG_HOME=/usr/local/opt/zplug
source $ZPLUG_HOME/init.zsh

zplug "themes/bureau", from:oh-my-zsh
zplug "zsh-users/zsh-syntax-highlighting", nice:10
zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-history-substring-search"
zplug "thewtex/tmux-mem-cpu-load"

if ! zplug check; then
    zplug install
fi

zplug load --verbose

# Lines configured by zsh-newuser-install
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000
setopt appendhistory autocd notify
unsetopt beep
bindkey -v
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
zstyle :compinstall filename '/home/aosagie/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

# Better kill command completion
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,cmd'

# Allow access to named colors
autoload -U colors && colors

# Set up the prompt
autoload -Uz promptinit && promptinit

# Pasting with tabs doesn't perform completion
zstyle ':completion:*' insert-tab pending

# Multi-terminal history
setopt histignorealldups sharehistory

# Aliases
# commands prefixed with an empty space are not stored in history
alias ls=' ls -G'
alias ll=' ls -lah'
alias rm='rm -i'
alias mv='mv -i'
alias cp='cp -i'
alias grep='grep --color=auto'

# Automatically run 'ls' upon entering a new directory
function chpwd() {
    emulate -L zsh
    ls
}

# Automatically list choices on an ambiguous completion
setopt AUTO_LIST

# In conjunction with AUTO_LIST, only lists when completion is ambiguous
setopt LIST_AMBIGUOUS

# Make completion list smaller
setopt LIST_PACKED

# Allow moving through directories just by entering their names
setopt AUTO_CD

# Keep stack-based history of traversed directories that can be accessed w/ 'popd'
setopt AUTO_PUSHD

setopt PUSHD_IGNORE_DUPS

# Report status of background jobs immediately, not on next prompt
setopt NOTIFY

# Inform of running jobs when trying to exit
setopt CHECK_JOBS

# Self explanatory
setopt HIST_REDUCE_BLANKS

setopt HIST_IGNORE_SPACE

# enable command substitution in the prompt
setopt PROMPT_SUBST

# make backspace work normally in vi mode
zle -A .backward-delete-char vi-backward-delete-char

bindkey -M viins 'jj' vi-cmd-mode #enter cmd mode w/ 'jj' instead of just 'ESC'
bindkey -M vicmd 'u' undo
bindkey -M vicmd 'q' push-line #store current line then restore it after you enter new command
bindkey -M viins ' ' magic-space #history expansion works w/ space instead of just tab
bindkey -M vicmd 'k' up-line-or-search
bindkey -M vicmd 'j' down-line-or-search
bindkey "\e[Z" reverse-menu-complete #shift+tab
bindkey "^R" history-incremental-search-backward #ctrl+r
bindkey "^[[A" up-line-or-search #up
bindkey "^[[B" down-line-or-search #down

# fixes inability to ctrl-s horizontal splits in terminal vim's CtrlP
stty -ixon -ixoff

[ -f ~/.zshrc.local ] && source ~/.zshrc.local

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
