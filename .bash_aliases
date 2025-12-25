alias fd="cd  && cd \$(find -L ~ -type d -print | fzf)"
alias f="cd \"\$(find ~/{Projects,Documents,Work} -maxdepth 6 -type d | fzf)\""
alias ff="cd \"\$(find ~/{Projects,Documents,Work} -type d | fzf)\""
alias gb="git checkout \$(git branch | fzf)"
alias gc="git commit"
alias gcm="git commit -m"
alias gsc="git switch -c"
alias grd="git restore ."
alias gs="git status"
alias gd="git diff"
alias vim="nvim"
alias t="tmux"
alias tl="tmux list-sessions"
alias ta="tmux attach -t"

cherry_pick_from() {
  local src_branch="$1"

  if [ -z "$src_branch" ]; then
    echo "usage: cherry_pick_from <source-branch>" >&2
    return 1
  fi

  # ensure branch exists
  git show-ref --verify --quiet "refs/heads/$src_branch" || {
    echo "branch not found: $src_branch" >&2
    return 1
  }

  # pick commits (oldest at top)
  local picks
  picks=$(git log --oneline --first-parent "$src_branch" |
    fzf --multi --prompt="pick two commits (oldest → newest)> ") || return 1

  local one two
  one=$(printf "%s\n" "$picks" | sed -n '1p' | awk '{print $1}')
  two=$(printf "%s\n" "$picks" | sed -n '2p' | awk '{print $1}')

  if [ -z "$one" ] || [ -z "$two" ]; then
    echo "you must select exactly two commits" >&2
    return 1
  fi

  # ensure correct ancestry
  if ! git merge-base --is-ancestor "$one" "$two"; then
    echo "first commit is not an ancestor of the second" >&2
    return 1
  fi

  git cherry-pick "$one^..$two"
}

_cherry_pick_from() {
    local branches
    branches=(${(f)"$(git for-each-ref --format='%(refname:short)' refs/heads)")})
    _values "branch" $branches
}

compdef _cherry_pick_from cherry_pick_from
