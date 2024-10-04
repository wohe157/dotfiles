#!/bin/sh
set -ex

# Dock
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock tilesize -int 64
defaults write com.apple.dock magnification -bool false
defaults write com.apple.dock show-process-indicators -bool false
defaults write com.apple.dock show-recents -bool false
defaults write com.apple.dock minimize-to-application -bool false
defaults write com.apple.dock mineffect -string scale
defaults write com.apple.dock launchanim -bool false

# Finder
defaults write com.apple.finder AppleShowAllFiles -bool true
defaults write com.apple.finder FXPreferredViewStyle -string clmv
defaults write com.apple.finder FXDefaultSearchScope -string SCcf
defaults write com.apple.finder FXRemoveOldTrashItems -bool true
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true
defaults write com.apple.finder _FXSortFoldersFirst -bool true
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

killall Dock
killall Finder
