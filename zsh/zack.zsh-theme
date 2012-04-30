PROMPT=$'%{$fg_bold[green]%}%n@%m %{$fg[blue]%}%D{[%I:%M:%S]} %{$reset_color%}%{$fg[white]%}%{$fg_bold[red]%}[%{$reset_color%}%~$fg_bold[red]%}]%{$reset_color%}%{$reset_color%} $(git_prompt_info) $(git_prompt_status)\
%{$fg_bold[blue]%}$%{$reset_color%} '

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[green]%}["
ZSH_THEME_GIT_PROMPT_SUFFIX="]%{$reset_color%}"
#ZSH_THEME_GIT_PROMPT_DIRTY=" %{$fg[red]%}*%{$fg[green]%}"
ZSH_THEME_GIT_PROMPT_DIRTY=""
ZSH_THEME_GIT_PROMPT_CLEAN=""

ZSH_THEME_GIT_PROMPT_ADDED="%{$fg_bold[green]%} ✚"
ZSH_THEME_GIT_PROMPT_MODIFIED="%{$fg_bold[blue]%} ✹"
ZSH_THEME_GIT_PROMPT_DELETED="%{$fg_bold[red]%} ✖"
ZSH_THEME_GIT_PROMPT_RENAMED="%{$fg_bold[magenta]%} ➜"
ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg_bold[yellow]%} ═"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg_bold[cyan]%} ✭"

#ZSH_THEME_GIT_PROMPT_ADDED="%{$fg[green]%} A"
#ZSH_THEME_GIT_PROMPT_MODIFIED="%{$fg[blue]%} M"
#ZSH_THEME_GIT_PROMPT_DELETED="%{$fg[red]%} D"
#ZSH_THEME_GIT_PROMPT_RENAMED="%{$fg[magenta]%} R"
#ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg[yellow]%} U"
#ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[cyan]%} X"
