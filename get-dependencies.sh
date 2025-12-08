#!/bin/sh

set -eux
ARCH="$(uname -m)"
EXTRA_PACKAGES="https://raw.githubusercontent.com/pkgforge-dev/Anylinux-AppImages/refs/heads/main/useful-tools/get-debloated-pkgs.sh"

echo "Installing build dependencies..."
echo "---------------------------------------------------------------"
pacman -Syu --noconfirm \
	base-devel           \
	boost                \
	boost-libs           \
	catch2               \
	ccache               \
	clang                \
	cmake                \
	curl                 \
	crypto++             \
	doxygen              \
	ffmpeg               \
	fmt                  \
	gamemode             \
	git                  \
	glslang              \
	glu                  \
	graphviz             \
	hidapi               \
	libinih              \
	libvpx               \
	libxi                \
	libxkbcommon-x11     \
	libxss               \
	libzip               \
	lld                  \
	llvm                 \
	mesa                 \
	meson                \
	ninja                \
	nlohmann-json        \
	pipewire-audio       \
	pulseaudio           \
	pulseaudio-alsa      \
	qt6-base             \
	qt6ct                \
	qt6-multimedia       \
	qt6-tools            \
	rapidjson            \
	sdl2                 \
	spirv-headers        \
	unzip                \
	vulkan-headers       \
	vulkan-mesa-layers   \
	wget                 \
	xcb-util-cursor      \
	xcb-util-image       \
	xcb-util-renderutil  \
	xcb-util-wm          \
	xorg-server-xvfb     \
	zip                  \
	zsync


echo "Installing debloated packages..."
echo "---------------------------------------------------------------"
wget --retry-connrefused --tries=30 "$EXTRA_PACKAGES" -O ./get-debloated-pkgs.sh
chmod +x ./get-debloated-pkgs.sh
./get-debloated-pkgs.sh --add-common
