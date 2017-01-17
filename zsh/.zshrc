# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

fpath=(/usr/local/share/zsh-completions $fpath)

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
HIST_STAMPS="dd.mm.yyyy"

# User configuration
#export PYTHONPATH=/usr/local/lib/python2.7/site-packages:$PYTHONPATH

export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"
# export MANPATH="/usr/local/man:$MANPATH"

if [[ ! -d "$XDG_CACHE_HOME/zsh" ]]; then
	mkdir -p $XDG_CACHE_HOME/zsh
fi
export ANTIGEN_COMPDUMPFILE=${XDG_CACHE_HOME}/zsh/zcompdump

# bootstrap antigen {{{

if [[ ! -f $XDG_CACHE_HOME/antigen/antigen.zsh ]]; then
	git clone https://github.com/zsh-users/antigen.git $XDG_CACHE_HOME/antigen
fi
. $XDG_CACHE_HOME/antigen/antigen.zsh

# }}}

# Load oh-my-zsh
antigen use oh-my-zsh

# set theme
antigen theme leeor/oh-my-zsh-custom themes/agnoster

antigen bundle git
antigen bundle gem
antigen bundle node
antigen bundle npm
#antigen bundle ruby
antigen bundle pip
antigen bundle python
antigen bundle web-search
antigen bundle docker
antigen bundle go
antigen bundle leeor/oh-my-zsh-custom plugins/vi-mode
antigen bundle leeor/oh-my-zsh-custom plugins/tmuxifier

if [[ -f "${(%):-%x}.plugins.$(uname)" ]]; then
	for plugin in $(cat ${(%):-%x}.plugins.$(uname)); do
		antigen bundle ${plugin}
	done
fi

# syntax highlighting
antigen bundle zsh-users/zsh-syntax-highlighting

antigen apply

autoload zmv
alias mmv='noglob zmv -W'

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

_docker_fixdate() {
	if boot2docker --version; then
		CMD=boot2docker
		VMNAME=""
	elif docker-machine --version; then
		CMD=docker-machine
		VMNAME=dev
	else
		echo "Neither boot2docker nor docker-machine were found in path"
		return 1
	fi
	$CMD ssh $VMNAME "sudo /usr/local/bin/ntpclient -c 1 -s -q 200 -h pool.ntp.org"
}

export_docker() {
	#HOST=$(~/bin/machine ls -q --filter=state=Running | head -1)
	#if [[ -n $HOST ]]; then
	#		 eval $(~/bin/machine env ${HOST})
	#fi
	#export DOCKER_HOST=tcp://$(boot2docker ip 2>/dev/null):2376
	export DOCKER_HOST=tcp://192.168.59.103:2376
	#export DOCKER_CERT_PATH=/Users/leeor/.boot2docker/certs/boot2docker-vm
	#export DOCKER_TLS_VERIFY=1
}
#export_docker

DEFAULT_USER=leeor
EDITOR=nvim

# define right prompt, if it wasn't defined by a theme
RPROMPT='$(vi_mode_prompt_info) $(build_rprompt)'

export DIRCOLORS=$(dirname "${(%):-%x}")/dircolors/dircolors.ansi-dark

if [[ -f "${(%):-%x}.$(uname)" ]]; then
	source ${(%):-%x}.$(uname)
fi

if [[ -f "${(%):-%x}.local" ]]; then
	source ${(%):-%x}.local
fi
