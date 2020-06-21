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

#These get added to zsh's git completion in /usr/local/share/zsh/functions/_git or /usr/share/zsh/5.7.1/functions/_git
_git-restore() {
  local curcontext="$curcontext" state line expl ret=1
  local -A opt_args

  _arguments -C -s -S \
    '(-s --source)'{-s,--source}'[specify which tree-ish to checkout from]:source tree:->sources' \
    '(-S --staged)'{-S,--staged}'[restore the index]' \
    '(-W --worktree)'{-W,--worktree}'[restore the working tree (default)]' \
    '--ignore-unmerged[ignore unmerged entries]' \
    '--overlay[never remove files when restoring]' '!(--overlay)--no-overlay' \
    '(-q --quiet --no-progress)'{-q,--quiet}'[suppress feedback messages]' \
    '--recurse-submodules=-[control recursive updating of submodules]::checkout:__git_commits' \
    '(-q --quiet --progress)--no-progress[suppress progress reporting]' \
    '(--no-progress)--progress[force progress reporting]' \
    '(-m --merge)'{-m,--merge}'[perform a 3-way merge with the new branch]' \
    '--conflict=[change how conflicting hunks are presented]:conflict style [merge]:(merge diff3)' \
    '(-2 --ours -3 --theirs -m --merge)'{-2,--ours}'[checkout our version for unmerged files]' \
    '(-2 --ours -3 --theirs -m --merge)'{-3,--theirs}'[checkout their version for unmerged files]' \
    '(-p --patch)'{-p,--patch}'[select hunks interactively]' \
    "--ignore-skip-worktree-bits[don't limit pathspecs to sparse entries only]" \
    '*:path spec:->pathspecs' && ret=0

  case $state in
    pathspecs)
      if [[ -z ${opt_args[(I)-s|--source|-S|--staged]} ]] &&
  # use index as a default base unless -S is specified
  __git_ignore_line __git_modified_files
      then
  ret=0
      else
  __git_ignore_line __git_tree_files ${PREFIX:-.} ${(Qv)opt_args[(i)-s|--source]:-HEAD} && ret=0
      fi
    ;;
    sources)
      # if a path has already been specified, use it to select commits
      git_commit_opts=(-- $line)
      __git_commits_prefer_recent -O expl:git_commit_opts && ret=0
    ;;
  esac

  return ret
}

_git-switch() {
  local curcontext="$curcontext" state line expl ret=1
  local -A opt_args

  _arguments -C -s -S \
    '(-c --create -C --force-create -d --detach --orphan --ignore-other-worktrees 1)'{-c,--create}'[create and switch to a new branch]:branch:->branches' \
    '(-c --create -C --force-create -d --detach --orphan --ignore-other-worktrees 1)'{-C,--force-create}'[create/reset and switch to a branch]:branch:->branches' \
    "(--guess --orphan 2)--no-guess[don't second guess 'git switch <no-such-branch>']" \
    "(--no-guess -t --track -d --detach --orphan 2)--guess[second guess 'git switch <no-such-branch> (default)]" \
    '(-f --force --discard-changes -m --merge --conflict)'{-f,--force,--discard-changes}'[throw away local modifications]' \
    '(-q --quiet --no-progress)'{-q,--quiet}'[suppress feedback messages]' \
    '--recurse-submodules=-[control recursive updating of submodules]::checkout:__git_commits' \
    '(-q --quiet --progress)--no-progress[suppress progress reporting]' \
    '--progress[force progress reporting]' \
    '(-m --merge --discard-changes --orphan)'{-m,--merge}'[perform a 3-way merge with the new branch]' \
    '(--discard-changes --orphan)--conflict=[change how conflicting hunks are presented]:conflict style [merge]:(merge diff3)' \
    '(-d --detach -c --create -C --force-create --ignore-other-worktrees --orphan --guess --no-guess 1)'{-d,--detach}'[detach HEAD at named commit]' \
    '(-t --track --no-track --guess --orphan 1)'{-t,--track}'[set upstream info for new branch]' \
    "(-t --track --guess --orphan 1)--no-track[don't set upstream info for a new branch]" \
    '(-c --create -C --force-create -d --detach --ignore-other-worktrees -m --merge --conflict -t --track --guess --no-track -t --track)--orphan[create new unparented branch]: :__git_branch_names' \
    '!--overwrite-ignore' \
    "(-c --create -C --force-create -d --detach --orphan)--ignore-other-worktrees[don't check if another worktree is holding the given ref]" \
    '1: :->branches' \
    '2:start point:->start-points' && ret=0

  case $state in
    branches)
      if [[ -n ${opt_args[(i)--guess]} ]]; then
  # --guess is the default but if it has been explictly specified,
  # we'll only complete remote branches
  __git_remote_branch_names_noprefix && ret=0
      else
  _alternative \
    'branches::__git_branch_names' \
    'remote-branch-names-noprefix::__git_remote_branch_names_noprefix' && ret=0
      fi
    ;;
    start-points)
      if [[ -n ${opt_args[(I)-t|--track|--no-track]} ]]; then
  # with an explicit --track, stick to remote branches
  # same for --no-track because it'd be meaningless with anything else
  __git_heads_remote && ret=0
      else
  __git_revisions && ret=0
      fi
    ;;
  esac

  return ret
}

[ -f ~/.zshenv.local ] && source ~/.zshenv.local
