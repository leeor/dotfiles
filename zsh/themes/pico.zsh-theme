# vim:ft=zsh

prompt_symbols() {
	local syms
	syms=()
	[[ $UID -eq 0 ]] && syms+="%{%F{yellow}%}⚡ "
	[[ $(jobs -l | wc -l) -gt 0 ]] && syms+="%{%F{cyan}%}⚙  "

	echo -n $syms
}

prompt_time() {
	echo -n '%F{green}%D{%K:%M} '
}

prompt_dir() {
	echo -n '%F{green}%2c '
}

prompt_git() {
  if $(git rev-parse --is-inside-work-tree >/dev/null 2>&1); then
		echo -n $(git_prompt_info)$(git_prompt_status)' '
	fi
}

prompt_end() {
	local pcol
	pcol='blue'
	[[ $RETVAL -ne 0 ]] && pcol='red'
	echo -n "%F{${pcol}}»%f "
}

build_prompt() {
  RETVAL=$?
	prompt_symbols
	prompt_time
	prompt_dir
	prompt_git
	prompt_end
}

PROMPT='$(build_prompt)'

ZSH_THEME_GIT_PROMPT_PREFIX="%F{yellow}\ue0a0 "
ZSH_THEME_GIT_PROMPT_SUFFIX="%f"
ZSH_THEME_GIT_PROMPT_DIRTY=" %F{red}✘%f"
ZSH_THEME_GIT_PROMPT_CLEAN=" %F{green}✔%F{black}"
ZSH_THEME_GIT_PROMPT_ADDED=" %F{green}✚%F{black}"
ZSH_THEME_GIT_PROMPT_MODIFIED=" %F{blue}✹%F{black}"
ZSH_THEME_GIT_PROMPT_DELETED=" %F{red}✖%F{black}"
ZSH_THEME_GIT_PROMPT_UNTRACKED=" %F{yellow}✭%F{black}"
ZSH_THEME_GIT_PROMPT_RENAMED=" ➜"
ZSH_THEME_GIT_PROMPT_UNMERGED=" ═"
ZSH_THEME_GIT_PROMPT_AHEAD=" ⬆"
ZSH_THEME_GIT_PROMPT_BEHIND=" ⬇"
ZSH_THEME_GIT_PROMPT_DIVERGED=" ⬍"
