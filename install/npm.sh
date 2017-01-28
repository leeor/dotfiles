#!/usr/bin/env zsh

# Using zsh so that we have nvm available through a plugin

#
# This script configures my Node.js development setup. Note that
# nvm is installed by the zsh-nvm plugin.
#

if ! command -v nvm 2>&1 > /dev/null; then
	# nvm is provided through a ZSH plugin
	echo >&2 "Please install the ZSH nvm plugin: lukechilds/zsh-nvm"
	return 1
else
  echo "Installing a stable version of Node..."

  # Install the latest stable version of node
  nvm install stable

  # Switch to the installed version
  nvm use node

  # Use the stable version of node by default
  nvm alias default node
fi

# All `npm install <pkg>` commands will pin to the version that was available at the time you run the command
npm config set save-exact = true

# Globally install with npm
# To list globally installed npm packages and version: npm list -g --depth=0
#
# Some descriptions:
#
# diff-so-fancy — sexy git diffs
# git-recent — Type `git recent` to see your recent local git branches
# git-open — Type `git open` to open the GitHub page or website for a repository
packages=(
	diff-so-fancy
	git-recent
	git-open
	nodemon
	yo
)

npm install -g "${packages[@]}"
unset packages
