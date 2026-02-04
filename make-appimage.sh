#!/bin/sh

set -eu

ARCH=$(uname -m)
export ARCH
export OUTPATH=./dist
export ADD_HOOKS="self-updater.bg.hook:x86-64-v3-check.hook"
export UPINFO="gh-releases-zsync|${GITHUB_REPOSITORY%/*}|${GITHUB_REPOSITORY#*/}|latest|*$ARCH.AppImage.zsync"
export APPNAME=Azahar
export DESKTOP=/usr/share/applications/org.azahar_emu.Azahar.desktop
export ICON=/usr/share/icons/hicolor/512x512/apps/org.azahar_emu.Azahar.png
export DEPLOY_OPENGL=1
export DEPLOY_VULKAN=1
export DEPLOY_PIPEWIRE=1

# Deploy dependencies
quick-sharun /usr/bin/azahar* /usr/lib/libgamemode.so*

# Additional changes can be done in between here

# Turn AppDir into AppImage
quick-sharun --make-appimage
