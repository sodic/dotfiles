# to be able to use color names
autoload -U colors && colors

setopt PROMPT_SUBST

local indicator=$(printf '❯%0.s' {1..$((RANGER_LEVEL + 1))})
local ret_status="%(?:%{$fg_bold[green]%}$indicator :%{$fg_bold[red]%}$indicator )"
local git_info='$(git_prompt_info)'
local dir='%{$fg[blue]%}%c%{$reset_color%}'
local reset_colors='%{$reset_color%}'

if [[ $UID -eq 0 ]]; then
    local user_host='%{$terminfo[bold]$fg[red]%}%n@%m'
else
    local user_host='%{$terminfo[bold]$fg[green]%}%n@%m'
fi

PROMPT="${user_host} ➜ ${dir} ${git_info}
${ret_status}${reset_colors}"

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[blue]%}(%{$fg[yellow]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%}) %{$fg[yellow]%}✗"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%}) %{$fg[cyan]%}✓"
