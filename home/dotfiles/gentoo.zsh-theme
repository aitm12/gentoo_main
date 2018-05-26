#function prompt_char {
#	if [ $UID -eq 0 ]; then echo "x"; else echo \~\>; fi
#}

PROMPT='%{$fg[white]%}x %(!.%{$fg_bold[red]%}%n.%{$fg_bold[white]%}%n) %(!.%{$fg_bold[white]%}xplrn.%{$fg[yellow]%}in) %{$fg[yellow]%}%~/ %{$fg[white]%}x%{$reset_color%} '
RPROMPT='%{$fg[white]%}%*%{$reset_color%}'
#ZSH_THEME_GIT_PROMPT_PREFIX="("
#ZSH_THEME_GIT_PROMPT_SUFFIX=") "
