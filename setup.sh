#!/usr/bin/env bash
set -e

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"
platform=$(uname)

echo "=== Setting up dotfiles for $platform ==="

# Install Homebrew if missing
if ! command -v brew &>/dev/null; then
  echo "Installing Homebrew..."
  if [ "$platform" = "Darwin" ]; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    eval "$(/opt/homebrew/bin/brew shellenv)"
  elif [ "$platform" = "Linux" ]; then
    NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
  fi
fi

# Install brew packages
if [ -f "$DOTFILES_DIR/brew/Brewfile" ]; then
  echo "Installing brew packages..."
  brew bundle --file="$DOTFILES_DIR/brew/Brewfile" 2>&1 | tail -20 || true
fi

# Set shell to zsh if not already
ZSH_BINARY=$(command -v zsh 2>/dev/null)
if [ -n "$ZSH_BINARY" ] && [ "$SHELL" != "$ZSH_BINARY" ]; then
  if [ "$platform" = "Darwin" ]; then
    if ! grep -q "$ZSH_BINARY" /etc/shells; then
      echo "$ZSH_BINARY" | sudo tee -a /etc/shells
    fi
    chsh -s "$ZSH_BINARY"
  elif [ "$platform" = "Linux" ]; then
    sudo chsh -s "$ZSH_BINARY" "$(whoami)" 2>/dev/null || true
  fi
fi

# macOS-specific defaults
if [ "$platform" = "Darwin" ] && [ -f "$DOTFILES_DIR/osx/defaults.sh" ]; then
  echo "Applying macOS defaults..."
  bash "$DOTFILES_DIR/osx/defaults.sh"
fi

# Create needed directories
mkdir -p ~/.config ~/.cache/vim/swap

# Set up rcfiles symlinks
rcfiles="
  zsh/zshrc
  zsh/zshrc.$(uname)
  zsh/zshrc.plugins.$(uname)
  zsh/shell_aliases
  zsh/shell_config
  zsh/shell_exports
  zsh/shell_functions
  zsh/dircolors/dircolors.ansi-dark=>.dircolors
  zsh/fzf.zsh
  git/gitconfig
  wget/wgetrc
  nvim/init.vim=>.vimrc
  nvim=>.config/nvim
  tmuxifier
  tmux/tmux.conf
  kitty/kitty.conf=>.config/kitty/kitty.conf
  ag/agignore
"

for rcf in ${rcfiles}; do
  src="$DOTFILES_DIR/${rcf}"
  dest="$HOME/.$(basename ${rcf})"

  case ${rcf} in
    *"=>"*)
      src="$DOTFILES_DIR/${rcf%"=>"*}"
      dest="$HOME/${rcf#*"=>"}"
      ;;
  esac

  # Skip files that don't exist (e.g., zshrc.plugins.Linux may be empty)
  if [ ! -e "$src" ]; then
    continue
  fi

  # Create parent directory if needed
  mkdir -p "$(dirname "$dest")"

  rm -f "$dest" && ln -s "$src" "$dest"
done

echo "=== Dotfiles setup complete ==="
