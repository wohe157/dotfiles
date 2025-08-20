#!/bin/sh

[ -x "$(command -v "brew")" ] || bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew bundle --no-lock --no-upgrade

stow --target="$HOME" */

chmod +x setup-macos-defaults && ./setup-macos-defaults
chmod +x setup-python && ./setup-python
