precmd() { if [ $? -eq 0 ]; then NCOLOR="white"; else NCOLOR="red"; fi }

function get_host {
	echo '@'$HOST
}

PROMPT='%{$fg[$NCOLOR]%}> %{$reset_color%}'
RPROMPT='%c/$(git_prompt_info)'

ZSH_THEME_GIT_PROMPT_DIRTY="%{:$fg[yellow]%}X%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_PREFIX="["
ZSH_THEME_GIT_PROMPT_SUFFIX="]"
