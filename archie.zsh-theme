local cmd_indicator="λ "
local ret_status="%(?:%{$fg_bold[white]%}${cmd_indicator}%{$reset_color%}:%{$fg_bold[red]%}${cmd_indicator}%{$reset_color%}"
#local hostname="%{$fg_bold[green]%}$USER@$HOST%{$reset_color%}:"
local hostname="%{$fg_bold[yellow]%}$HOST%{$reset_color%}:"

#PROMPT='${hostname}%{$fg_bold[blue]%}%~%{$reset_color%}\$ '
# PROMPT='[${hostname}%{$fg_bold[blue]%}%~%{$reset_color%}]$(git_prompt_info)
# › '
PROMPT='[${hostname}%{$fg_bold[blue]%}%c%{$reset_color%}]$(git_prompt_info)
${ret_status}'

ZSH_THEME_GIT_PROMPT_PREFIX="[%{$fg_bold[yellow]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}]"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg_bold[yellow]%} ?"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[green]%} ✔"
