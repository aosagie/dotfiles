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
# Lines configured by zsh-newuser-install
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory autocd notify
unsetopt beep
bindkey -v
# End of lines configured by zsh-newuser-install

# Allow access to named colors
autoload -U colors && colors

# Set up the prompt
autoload -Uz promptinit && promptinit
prompt adam2

# Launch file types with their associated handlers
autoload -U zsh-mime-setup
zstyle ':mime:.txt:' handler $EDITOR %s
zstyle ':mime:.pdf:' handler evince %s
zsh-mime-setup

# pasting with tabs doesn't perform completion
zstyle ':completion:*' insert-tab pending

# Multi-terminal history
setopt histignorealldups sharehistory

# Aliases
alias ls='ls -F --color=auto'
alias l='ls'
alias ll='ls -la'
alias rm='rm -i'
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

# make backspace work normally in vi mode
zle -A .backward-delete-char vi-backward-delete-char

bindkey -M viins 'jj' vi-cmd-mode #'jj' enters command mode
bindkey "\e[Z" reverse-menu-complete #shift+tab
bindkey "^[[A" history-beginning-search-backward #up
bindkey "^[[B" history-beginning-search-forward #down

# virtualenv and virtualenvwrapper configuration
source /usr/local/bin/virtualenvwrapper.sh
