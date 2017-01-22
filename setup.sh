#!/usr/bin/env sh

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
)

for rcf in ${rcfiles[@]}; do
	src=$(pwd)/${rcf}
	dest=~/.$(basename ${rcf})
	[[ "${rcf#*=>}" != "" ]] && src=$(pwd)/${rcf%=>*} && dest=~/.$(basename ${rcf#*=>})
	rm -f ${dest} && ln -s ${src} ${dest}
	unset dest
done
unset rcf
unset rcfiles
