# vim:ft=zsh

# A theme with a minimalist prompt, even more so than nanotech's prompt!
# It is inspired by both the agnoster and bullet-train themes, and borrows from
# both while striving to keep screen real-estate usage at a bare minimum (both
# horizontal and vertical).

CURRENT_BG='NONE'
SEGMENT_SEPARATOR=''

# command execution time
if [ ! -n "${PICO_EXEC_TIME_ELAPSED+1}" ]; then
  PICO_EXEC_TIME_ELAPSED=5
fi

# Reusable segment handling functions {{{

# Begin a segment
# Takes two arguments, background and foreground. Both can be omitted,
# rendering default background/foreground.
prompt_segment() {
  local bg fg
  [[ -n $1 ]] && bg="%K{$1}" || bg="%k"
  [[ -n $2 ]] && fg="%F{$2}" || fg="%f"
  if [[ $CURRENT_BG != 'NONE' && $1 != $CURRENT_BG ]]; then
    echo -n " %{$bg%F{$CURRENT_BG}%}$SEGMENT_SEPARATOR%{$fg%}"
  else
    echo -n "%{$bg%}%{$fg%}"
  fi
  CURRENT_BG=$1
  [[ -n $3 ]] && echo -n $3' '
}

# End the prompt, closing any open segments
prompt_end() {
  if [[ -n $CURRENT_BG ]]; then
    echo -n "%{%k%F{$CURRENT_BG}%}$SEGMENT_SEPARATOR"
  else
    echo -n "%{%k%}"
  fi
  echo -n "%{%f%}"
  CURRENT_BG=''
}

# }}}

PROMPT_CHAR='»'
prompt_chars() {
	local pcol
	pcol='blue'
	[[ $RETVAL -ne 0 ]] && pcol='red'
	echo -n "%F{${pcol}}${PROMPT_CHAR}%f "
}

# execution time {{{

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
  [ $PICO_last_exec_duration -gt $PICO_EXEC_TIME_ELAPSED ] && prompt_segment 'NONE' 'yellow' "$(displaytime $PICO_last_exec_duration)"
}

# }}}

prompt_time() {
	prompt_segment 'NONE' 'green' '%D{%K:%M}'
}

prompt_custom() {
	prompt_segment ${PICO_PROMPT_CUSTOM_BG} ${PICO_PROMPT_CUSTOM_FG} "${PICO_PROMPT_CUSTOM_MSG}"
}

prompt_symbols() {
	local syms
	syms=()
	[[ $UID -eq 0 ]] && syms+="%{%F{yellow}%}⚡ "
	[[ $(jobs -l | wc -l) -gt 0 ]] && syms+="%{%F{cyan}%}⚙ "

	prompt_segment 'NONE' 'black' $syms
}

prompt_context() {
  local user="$(whoami)"
	[[ "$user" != "$PICO_DEFAULT_USER" || -n "$SSH_CLIENT" || -n "$SSH_TTY" ]] && prompt_segment 'NONE' 'blue' '%n@%m'
}

prompt_dir() {
	prompt_segment 'NONE' 'green' '[%2~]'
}

prompt_git() {
  if $(git rev-parse --is-inside-work-tree >/dev/null 2>&1); then
		echo -n $(git_prompt_info)$(git_prompt_status)' '
	fi
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
	prompt_chars
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
