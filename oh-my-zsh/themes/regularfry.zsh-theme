
ZSH_THEME_GIT_PROMPT_PREFIX=" %{$fg[green]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[red]%}!"
ZSH_THEME_GIT_PROMPT_CLEAN=""

function prompt_char {
	if [ "$(whoami)" = "root" ]; then echo "%{$fg[red]%}#%{$reset_color%}"; else echo $; fi
}

VENV_STR=""
if [ ! -z "${VIRTUAL_ENV}" ]; then
  VENV_STR="[env:${VIRTUAL_ENV}]"
fi

PROMPT='%(?, ,%{$fg[red]%}FAIL%{$reset_color%}
)
%{$fg[green]%}[%*] %{$fg[magenta]%}%n%{$reset_color%}@%{$fg[yellow]%}%m%{$reset_color%}: %{$fg_bold[blue]%}%~%{$reset_color%}$(git_prompt_info) %{$VENV_STR%}
%_ $(prompt_char) '

RPROMPT='%{$reset_color%}'
