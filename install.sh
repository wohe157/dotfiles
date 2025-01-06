#!/bin/sh
case "$(uname -s)" in
Darwin*) os=macos ;;
Linux*) os=linux ;;
*) os=unknown ;;
esac

if [ "$os" != macos ]; then
  echo "The current OS is not yet supported."
fi

has() {
  [ -x "$(command -v "$1")" ]
}

if [ "$os" = macos ]; then
  has brew || bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  has git || brew install git
  has stow || brew install stow
fi

(
  if [ "$(basename "$PWD")" != "dotfiles" ]; then
    target_dir=$HOME/dotfiles
    [ -d "$target_dir" ] || git clone https://github.com/wohe157/dotfiles "$target_dir"
    cd "$target_dir"
  fi

  tpm=~/.config/tmux/plugins/tpm
  [ -d "$tpm" ] || (mkdir -p "$(dirname "$tpm")" && git clone https://github.com/tmux-plugins/tpm "$tpm")

  if [ "$os" = macos ]; then
    chmod +x macos-defaults.sh
    ./macos-defaults.sh
    stow --target="$HOME" */
    brew bundle --no-lock --no-upgrade
  fi

  has nvim && nvim --headless '+Lazy! sync' +qa
  has pipx && while read -r pkg; do pipx install "$pkg" || true; done <python-packages
)
