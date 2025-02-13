alias fd="cd  && cd \$(find -L ~ -type d -print | fzf)"
alias f="cd && cd \"\$(find {Projects,Documents,Work} -maxdepth 10 -type d | fzf)\""
alias gc="git checkout \$(git branch | fzf)"
alias gsc="git switch -c"
alias gs="git status"
alias gd="git diff"
alias ta="tmux attach -t"
alias vim="nvim"
