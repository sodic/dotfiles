local ret_status="%(?:%{$fg_bold[green]%}❯ :%{$fg_bold[red]%}❯ )"

local venv_prompt='$(virtualenv_prompt_info)'
local git_info='$(git_prompt_info)'
local dir='%{$fg[blue]%}%c%{$reset_color%}'
local reset_colors='%{$reset_color%}'

if [[ $UID -eq 0 ]]; then
    local user_host='%{$terminfo[bold]$fg[red]%}%n@%m'
else
    local user_host='%{$terminfo[bold]$fg[cyan]%}%n@%m'
fi

PROMPT="${venv_prompt}${user_host} ➜ ${dir} ${git_info}
${ret_status}${reset_colors}"
# old prompt PROMPT='%{$fg_bold[green]%}$USER@%{$fg_bold[green]%}%M ${ret_status} %{$fg[cyan]%}%c%{$reset_color%} $(git_prompt_info)'

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[cyan]%}(%{$fg[yellow]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[cyan]%}) %{$fg[yellow]%}✗"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[cyan]%}) %{$fg[cyan]%}✓"
