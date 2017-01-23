#!/usr/bin/env sh

set -e

#
# Install basic stuff like zsh, brew, etc.
#

platform=$(uname)
if [[ "${platform}" == 'Darwin' ]]; then
	# install brew (and zsh through it)
	if test ! $(which brew); then
		/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
	fi

	brew tap homebrew/bundle
	brew bundle --file=brew/Brewfile

	# change the current user's shell to zsh, if it isn't already
	if [[ ! $(echo $SHELL) == $(which zsh) ]]; then
		chsh -s $(which zsh)
	fi

	# install Solarized Dark colors for iTerm2
	open "iterm2/Solarized Dark.itermcolors"

	# set some nice defaults
	osx/defaults.sh
elif [[ "${platform}" == 'Linux' ]]; then
	if [[ -f /etc/redhat-release ]]; then
		sudo yum install zsh
	elif [[ -f /etc/debian_version ]]; then
		sudo apt-get install zsh
	fi
fi
unset platform

#
# Set up rcfiles symlinks
#

rcfiles=(
	zsh/zshrc
	zsh/zshrc.$(uname)
	zsh/zshrc.plugins.$(uname)
	zsh/shell_aliases
	zsh/shell_config
	zsh/shell_exports
	zsh/shell_functions
	"zsh/dircolors/dircolors.ansi-dark=>dircolors"
	wget/wgetrc
	"nvim/init.vim=>vimrc"
	tmuxifier
	tmux/tmux.conf
)

for rcf in ${rcfiles[@]}; do
	src=$(pwd)/${rcf}
	dest=~/.$(basename ${rcf})
	[[ "${rcf#*=>}" != "" ]] && src=$(pwd)/${rcf%=>*} && dest=~/.$(basename ${rcf#*=>})
	rm -f ${dest} && ln -s ${src} ${dest}
	unset src dest
done
unset rcf rcfiles
