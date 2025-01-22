# Store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Make sure zinit is installed
if [ ! -d "$ZINIT_HOME" ]; then
    mkdir -p "$(dirname $ZINIT_HOME)"
    git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"

# Syntax highlighting for commands
zinit light zsh-users/zsh-syntax-highlighting

# Completions
zinit light zsh-users/zsh-completions
zinit light Aloxaf/fzf-tab

# Load Completions
# Every 24h this will result in a slower launch as it checks if the cache needs
# to be reloaded
autoload -Uz compinit
for dump in ~/.zcompdump(N.mh+24); do
  compinit
done
compinit -C

# Snippets
zinit snippet OMZP::git

# Auto-suggestions
zinit light zsh-users/zsh-autosuggestions

# Enable fzf shell integrations
eval "$(fzf --zsh)"

# Set keybindings to emacs mode
bindkey -e

# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Case insensitive completion with colours
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'

# Aliases
alias ls='ls --color'
source ~/.dotfiles/.bash_aliases

eval "$(starship init zsh)"

