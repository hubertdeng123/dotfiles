#!/usr/bin/env bash
set -euo pipefail

DOTFILES="$(cd "$(dirname "$0")" && pwd)"

link() {
  local src="$1" dst="$2"
  if [ -L "$dst" ]; then
    rm "$dst"
  elif [ -e "$dst" ]; then
    echo "  backing up $dst -> ${dst}.bak"
    mv "$dst" "${dst}.bak"
  fi
  ln -s "$src" "$dst"
  echo "  $dst -> $src"
}

# Oh My Zsh
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo "Installing Oh My Zsh..."
  RUNZSH=no sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

echo "Linking zsh configs..."
link "$DOTFILES/zsh/.zshrc"    "$HOME/.zshrc"
link "$DOTFILES/zsh/.zprofile" "$HOME/.zprofile"
link "$DOTFILES/zsh/.zshenv"   "$HOME/.zshenv"

echo "Linking git configs..."
mkdir -p "$HOME/.config/git"
link "$DOTFILES/git/.gitconfig" "$HOME/.gitconfig"
link "$DOTFILES/git/ignore"     "$HOME/.config/git/ignore"

echo "Linking tmux config..."
link "$DOTFILES/tmux/.tmux.conf" "$HOME/.tmux.conf"

echo "Done."
