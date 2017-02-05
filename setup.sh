#!/usr/bin/env sh

set -e

#
# Install basic stuff like zsh, brew, etc.
#

platform=$(uname)
if [ "${platform}" = "Darwin" ]; then
	# install brew (and zsh through it)
	if test ! $(command -v brew); then
		/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
	fi

	brew tap homebrew/bundle
	brew bundle --file=brew/Brewfile

	ZSH_BINARY=$(command -v zsh)
	# change the current user's shell to zsh, if it isn't already
	if [ "$SHELL" != "$ZSH_BINARY" ]; then
		# need to make which the path return by command -v zsh is in /etc/shells
		if ! grep "$ZSH_BINARY" /etc/shells; then
			echo "Need to add $ZSH_BINARY to /etc/shells"
			echo $ZSH_BINARY | sudo tee -a /etc/shells
		fi
		chsh -s $(command -v zsh)
	fi

	# install Solarized Dark colors for iTerm2
	open "iterm2/Solarized Dark.itermcolors"

	# set some nice defaults
	osx/defaults.sh
elif [ "${platform}" = 'Linux' ]; then
	if [ "$SHELL" != $(command -v zsh) ]; then
		if [ -f /etc/redhat-release ]; then
			sudo yum install zsh
		elif [ -f /etc/debian_version ]; then
			sudo apt-get install zsh
		fi

		chsh -s $(command -v zsh)
	fi
fi
unset platform

#
# Set up rcfiles symlinks
#

rcfiles="
	zsh/zshrc
	zsh/zshrc.$(uname)
	zsh/zshrc.plugins.$(uname)
	zsh/shell_aliases
	zsh/shell_config
	zsh/shell_exports
	zsh/shell_functions
	zsh/dircolors/dircolors.ansi-dark=>.dircolors
	git/gitconfig
	wget/wgetrc
	nvim/init.vim=>.vimrc
	nvim=>.config/nvim
	tmuxifier
	tmux/tmux.conf
"

for rcf in ${rcfiles}; do
	src=$(pwd)/${rcf}
	dest=~/.$(basename ${rcf})
	case ${rcf} in
		*"=>"*)
			src=$(pwd)/${rcf%"=>"*}
			dest=~/${rcf#*"=>"}
			;;
	esac
	rm -f ${dest} && ln -s ${src} ${dest}
	unset src dest
done
unset rcf rcfiles
