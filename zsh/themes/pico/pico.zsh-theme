# vim:ft=zsh

# A theme with a minimalist prompt, even more so than nanotech's prompt!
# It is inspired by both the agnoster and bullet-train themes, and borrows from
# both while striving to keep screen real-estate usage at a bare minimum (both
# horizontal and vertical).

# Enabled prompt segments
if [[ -z ${PICO_PROMPT_ORDER+1} ]]; then
	PICO_PROMPT_ORDER=(symbols time context dir git cmd_exec_time)
fi
if [[ -z ${PICO_RPROMPT_ORDER+1} ]]; then
	PICO_RPROMPT_ORDER=(nvm)
fi

# Prompt character
if [[ -z ${PICO_PROMPT_CHAR+1} ]]; then
	PICO_PROMPT_CHAR='»'
fi

# Segment colors {{{
if [[ -z ${PICO_CMD_TIME_BG+1} ]]; then
	PICO_CMD_TIME_BG=default
fi
if [[ -z ${PICO_CMD_TIME_FG+1} ]]; then
	PICO_CMD_TIME_FG=yellow
fi

if [[ -z ${PICO_TIME_BG+1} ]]; then
	PICO_TIME_BG=default
fi
if [[ -z ${PICO_TIME_FG+1} ]]; then
	PICO_TIME_FG=green
fi

if [[ -z ${PICO_CUSTOM_BG+1} ]]; then
	PICO_CUSTOM_BG=default
fi
if [[ -z ${PICO_CUSTOM_FG+1} ]]; then
	PICO_CUSTOM_FG=default
fi

if [[ -z ${PICO_SYMBOLS_BG+1} ]]; then
	PICO_SYMBOLS_BG=default
fi
if [[ -z ${PICO_SYMBOLS_FG+1} ]]; then
	PICO_SYMBOLS_FG=default
fi

if [[ -z ${PICO_CONTEXT_BG+1} ]]; then
	PICO_CONTEXT_BG=default
fi
if [[ -z ${PICO_CONTEXT_FG+1} ]]; then
	PICO_CONTEXT_FG=blue
fi

if [[ -z ${PICO_DIR_BG+1} ]]; then
	PICO_DIR_BG=default
fi
if [[ -z ${PICO_DIR_FG+1} ]]; then
	PICO_DIR_FG=cyan
fi

if [[ -z ${PICO_GIT_DIRTY_BG+1} ]]; then
	PICO_GIT_DIRTY_BG=default
fi
if [[ -z ${PICO_GIT_DIRTY_FG+1} ]]; then
	PICO_GIT_DIRTY_FG=yellow
fi

if [[ -z ${PICO_GIT_CLEAN_BG+1} ]]; then
	PICO_GIT_CLEAN_BG=default
fi
if [[ -z ${PICO_GIT_CLEAN_FG+1} ]]; then
	PICO_GIT_CLEAN_FG=green
fi

if [ ! -n "${PICO_NVM_BG+1}" ]; then
  PICO_NVM_BG=default
fi
if [ ! -n "${PICO_NVM_FG+1}" ]; then
  PICO_NVM_FG=green
fi
if [ ! -n "${PICO_NVM_PREFIX+1}" ]; then
  PICO_NVM_PREFIX="⬡ "
fi

# }}}

# Additional Git status indicators {{{
if [ ! -n "${PICO_GIT_AHEAD+1}" ]; then
  ZSH_THEME_GIT_PROMPT_AHEAD=" ⬆"
else
  ZSH_THEME_GIT_PROMPT_AHEAD=$PICO_GIT_AHEAD
fi
if [ ! -n "${PICO_GIT_BEHIND+1}" ]; then
  ZSH_THEME_GIT_PROMPT_BEHIND=" ⬇"
else
  ZSH_THEME_GIT_PROMPT_BEHIND=$PICO_GIT_BEHIND
fi
if [ ! -n "${PICO_GIT_DIVERGED+1}" ]; then
  ZSH_THEME_GIT_PROMPT_DIVERGED=" ⬍"
else
  ZSH_THEME_GIT_PROMPT_DIVERGED=$PICO_GIT_PROMPT_DIVERGED
fi

# }}}

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

# End the prompt, closing any open PICO_PROMPT_ORDER
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

	vcs_info
}

prompt_cmd_exec_time() {
  [ $PICO_last_exec_duration -gt $PICO_EXEC_TIME_ELAPSED ] && prompt_segment ${PICO_CMD_TIME_BG} ${PICO_CMD_TIME_FG} "$(displaytime $PICO_last_exec_duration)"
}

# }}}

prompt_time() {
	prompt_segment ${PICO_TIME_BG} ${PICO_TIME_FG} '%D{%K:%M}'
}

prompt_custom() {
	if [[ -n ${PICO_PROMPT_CUSTOM_MSG+1} ]]; then
		prompt_segment ${PICO_CUSTOM_BG} ${PICO_CUSTOM_FG} ${PICO_PROMPT_CUSTOM_MSG}
	fi
}

prompt_symbols() {
	local syms
	syms=()
	[[ $UID -eq 0 ]] && syms+="⚡ "
	[[ $(jobs -l | wc -l) -gt 0 ]] && syms+="⚙ "

	prompt_segment ${PICO_SYMBOLS_BG} ${PICO_SYMBOLS_FG} $syms
}

prompt_context() {
  local user="$(whoami)"
	[[ "$user" != "$PICO_DEFAULT_USER" || -n "$SSH_CLIENT" || -n "$SSH_TTY" ]] && prompt_segment ${PICO_CONTEXT_BG} ${PICO_CONTEXT_FG} '%n@%m'
}

prompt_dir() {
	prompt_segment ${PICO_DIR_BG} ${PICO_DIR_FG} '[%2~]'
}

prompt_git() {
  local PL_BRANCH_CHAR
  () {
    local LC_ALL="" LC_CTYPE="en_US.UTF-8"
    PL_BRANCH_CHAR=$'\ue0a0'         # 
  }
  local ref dirty mode repo_path
  repo_path=$(git rev-parse --git-dir 2>/dev/null)

  if $(git rev-parse --is-inside-work-tree >/dev/null 2>&1); then
    dirty=$(parse_git_dirty)
    ref=$(git symbolic-ref HEAD 2> /dev/null) || ref="➦ $(git rev-parse --short HEAD 2> /dev/null)"
    if [[ -n $dirty ]]; then
      prompt_segment ${PICO_GIT_DIRTY_BG} ${PICO_GIT_DIRTY_FG}
		else
      prompt_segment ${PICO_GIT_CLEAN_BG} ${PICO_GIT_CLEAN_FG}
    fi

    if [[ -e "${repo_path}/BISECT_LOG" ]]; then
      mode=" <B>"
    elif [[ -e "${repo_path}/MERGE_HEAD" ]]; then
      mode=" >M<"
    elif [[ -e "${repo_path}/rebase" || -e "${repo_path}/rebase-apply" || -e "${repo_path}/rebase-merge" || -e "${repo_path}/../.dotest" ]]; then
      mode=" >R>"
    fi

		echo -n "${ref/refs\/heads\//$PL_BRANCH_CHAR }${vcs_info_msg_0_%% }$(git_prompt_status)${mode} "
	fi
}

# NVM: Node version manager
prompt_nvm() {
  local nvm_prompt
  if type nvm >/dev/null 2>&1; then
    nvm_prompt=$(nvm current 2>/dev/null)
    [[ "${nvm_prompt}x" == "x" ]] && return
  else
    nvm_prompt="$(node --version)"
  fi
  nvm_prompt=${nvm_prompt}
  prompt_segment $PICO_NVM_BG $PICO_NVM_FG $PICO_NVM_PREFIX$nvm_prompt
}

prompt_chars() {
	local pcol
	pcol='blue'
	[[ $RETVAL -ne 0 ]] && pcol='red'
	echo -n "%F{${pcol}}${PICO_PROMPT_CHAR}%f "
}

build_prompt() {
  RETVAL=$?

	for segment in ${PICO_PROMPT_ORDER}; do
		prompt_$segment
	done

	prompt_end
	prompt_chars
}

build_rprompt() {
	for segment in ${PICO_RPROMPT_ORDER}; do
		prompt_$segment
	done
}

PROMPT='$(build_prompt)'
RPROMPT="$RPROMPT"' $(build_rprompt)'

prompt_pico_setup() {
	autoload -Uz vcs_info

	setopt promptsubst

	zstyle ':vcs_info:*' enable git
	zstyle ':vcs_info:*' get-revision true
	zstyle ':vcs_info:*' check-for-changes true
	zstyle ':vcs_info:*' stagedstr '✚'
	zstyle ':vcs_info:*' unstagedstr '●'
	zstyle ':vcs_info:*' formats ' %u%c'
	zstyle ':vcs_info:*' actionformats ' %u%c'
}

prompt_pico_setup
