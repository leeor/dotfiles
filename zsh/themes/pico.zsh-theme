# vim:ft=zsh

# A theme with a minimalist prompt, even more so than nanotech's prompt!
# It is inspired by both the agnoster and bullet-train themes, and borrows from
# both while striving to keep screen real-estate usage at a bare minimum (both
# horizontal and vertical).

# command execution time
if [ ! -n "${PICO_EXEC_TIME_ELAPSED+1}" ]; then
  PICO_EXEC_TIME_ELAPSED=5
fi

# Based on http://stackoverflow.com/a/32164707/3859566
function displaytime {
  local T=$1
  local D=$((T/60/60/24))
  local H=$((T/60/60%24))
  local M=$((T/60%60))
  local S=$((T%60))
  [[ $D > 0 ]] && printf '%dd' $D
  [[ $H > 0 ]] && printf '%dh' $H
  [[ $M > 0 ]] && printf '%dm' $M
  printf '%ds' $S
}

# Prompt previous command execution time (from bullet-train theme)
preexec() {
  cmd_timestamp=`date +%s`
}

precmd() {
  local stop=`date +%s`
  local start=${cmd_timestamp:-$stop}
  let PICO_last_exec_duration=$stop-$start
  cmd_timestamp=''
}

prompt_cmd_exec_time() {
  [ $PICO_last_exec_duration -gt $PICO_EXEC_TIME_ELAPSED ] && echo -n "%F{yellow}$(displaytime $PICO_last_exec_duration)%f "
}

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

prompt_context() {
  local user="$(whoami)"
	[[ "$user" != "$PICO_DEFAULT_USER" || -n "$SSH_CLIENT" || -n "$SSH_TTY" ]] && echo -n '%F{blue}%n@%m%f '
}

prompt_dir() {
	echo -n '%F{green}[%2~]%f '
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

prompt_custom() {
	echo -n "$(eval ${RPROMPT_CUSTOM}) "
}

build_prompt() {
  RETVAL=$?
	prompt_symbols
	prompt_time
	prompt_context
	prompt_dir
	prompt_git
	prompt_cmd_exec_time
	prompt_end
}

build_rprompt() { }

PROMPT='$(build_prompt)'
RPROMPT="$RPROMPT"' $(build_rprompt)'

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
