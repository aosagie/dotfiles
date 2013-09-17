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
prompt adam1

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
alias ls='ls -F --color=auto --group-directories-first'
alias tree='tree -C'
alias l='ls'
alias ll='ls -lah'
alias lll='tree -d'
alias rm='rm -i'
alias grep='grep --color=auto'
alias pjson='python -mjson.tool | pygmentize -l javascript'
alias jps='jps -l'
alias mkscalaproject='mkdir -p src/{main,test}/{scala,java,resources}'

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

# make backspace work normally in vi mode
zle -A .backward-delete-char vi-backward-delete-char

bindkey -M viins 'jj' vi-cmd-mode #enter cmd mode w/ 'jj' instead of just 'ESC'
bindkey -M vicmd 'u' undo
bindkey -M vicmd 'q' push-line #store current line then restore it after you enter new command
bindkey -M viins ' ' magic-space #history expansion works w/ space instead of just tab
bindkey "\e[Z" reverse-menu-complete #shift+tab
bindkey "^R" history-incremental-search-backward #ctrl+r
bindkey "^[[A" up-line-or-search #up
bindkey "^[[B" down-line-or-search #down

# virtualenv and virtualenvwrapper configuration
source /usr/local/bin/virtualenvwrapper.sh

# fixes inability to ctrl-s horizontal splits in terminal vim's CtrlP
stty -ixon -ixoff

# git and svn info in the command line
autoload -Uz vcs_info

zstyle ':vcs_info:*' stagedstr ' %F{28}●'
zstyle ':vcs_info:*' unstagedstr ' %F{11}●'
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:(sv[nk]|bzr):*' branchformat '%b%F{1}:%F{11}%r'
zstyle ':vcs_info:*' enable git svn
precmd () {
    if [[ -z $(git ls-files --other --exclude-standard 2> /dev/null) ]] {
        zstyle ':vcs_info:*' formats ' [ %F{green}%b%c%u%F{blue} ]'
    } else {
        zstyle ':vcs_info:*' formats ' [ %F{green}%b%c%u %F{red}●%F{blue} ]'
    }

    vcs_info
}

setopt prompt_subst
RPROMPT='%F{blue}${vcs_info_msg_0_}%F{blue} %(?/%F{blue}/%F{red})% %{$reset_color%}'

[ -f ~/.zshrc.local ] && source ~/.zshrc.local
