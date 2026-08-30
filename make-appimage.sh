#!/bin/sh

set -eu

ARCH=$(uname -m)
export ARCH
export OUTPATH=./dist
export ADD_HOOKS="self-updater.hook"
export UPINFO="gh-releases-zsync|${GITHUB_REPOSITORY%/*}|${GITHUB_REPOSITORY#*/}|latest|*$ARCH.AppImage.zsync"
export ICON=https://raw.githubusercontent.com/SpacingBat3/WebCord/refs/heads/master/sources/assets/icons/app.png
export STARTUPWMCLASS=WebCord
export DEPLOY_PIPEWIRE=1
export DEPLOY_OPENGL=1
export DEPLOY_VULKAN=1

# Deploy dependencies
quick-sharun ./AppDir/bin/*

# Turn AppDir into AppImage
quick-sharun --make-appimage

# Test the app for 12 seconds, if the app normally quits before that time
# then skip this or check if some flag can be passed that makes it stay open
quick-sharun --simple-test ./dist/*.AppImage
