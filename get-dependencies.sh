#!/bin/sh

set -eu
ARCH=$(uname -m)

echo "Installing package dependencies..."
echo "---------------------------------------------------------------"
pacman -Syu --noconfirm \
	boost                \
	boost-libs           \
	catch2               \
	ccache               \
	clang                \
	cmake                \
	crypto++             \
	doxygen              \
	fmt                  \
	gamemode             \
	glslang              \
	glu                  \
	graphviz             \
	hidapi               \
	libinih              \
	libvpx               \
	libxi                \
	libxss               \
	libzip               \
	lld                  \
	llvm                 \
	meson                \
	ninja                \
	nlohmann-json        \
	pipewire-audio       \
	pipewire-jack        \
	pulseaudio           \
	pulseaudio-alsa      \
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
	zip


echo "Installing debloated packages..."
echo "---------------------------------------------------------------"
get-debloated-pkgs --add-common ffmpeg-mini

echo "Building Azahar..."
echo "---------------------------------------------------------------"
REPO="https://github.com/azahar-emu/azahar.git"

case "$ARCH" in
	x86_64)  set -- -march=x86-64-v3 -O3;;
	aarch64) set -- -march=armv8-a -mtune=generic -O3;;
	*)       >&2 echo "ERROR: Unkown arch: $ARCH"; exit 1;;
esac

git clone --recursive "$REPO" ./azahar
cd ./azahar

if [ "${DEVEL_RELEASE-}" = 1 ]; then
	git rev-parse --short HEAD > ~/version
else
	git fetch --tags origin
	TAG=$(git tag --sort=-v:refname | grep -vi 'rc\|alpha' | head -1)
	git checkout "$TAG"
	echo "$TAG" > ~/version
fi

git submodule update --init --recursive -j$(nproc)

# HACK
sed -i '10a #include <memory>' ./src/video_core/shader/shader_jit_a64_compiler.*
# HACK2
sed -i '1i find_package(SPIRV-Headers)' ./externals/sirit/sirit/src/CMakeLists.txt
# HACK3
qpaheader=$(find /usr/include -type f -name 'qplatformnativeinterface.h' -print -quit)
sed -i "s|#include <qpa/qplatformnativeinterface.h>|#include <$qpaheader>|" ./src/citra_qt/bootmanager.cpp

mkdir -p ./build
cd ./build

cmake ../ -G Ninja \
	-DCMAKE_CXX_COMPILER=clang++         \
	-DCMAKE_C_COMPILER=clang             \
	-DCMAKE_INSTALL_PREFIX=/usr          \
	-DENABLE_QT_TRANSLATION=ON           \
	-DUSE_SYSTEM_BOOST=OFF               \
	-DCMAKE_BUILD_TYPE=Release           \
	-DUSE_SYSTEM_VULKAN_HEADERS=ON       \
	-DENABLE_LTO=OFF                     \
	-DENABLE_TESTS=OFF                   \
	-DENABLE_ROOM_STANDALONE=OFF         \
	-DUSE_SYSTEM_GLSLANG=ON              \
	-DCITRA_USE_PRECOMPILED_HEADERS=OFF  \
	-DCMAKE_C_COMPILER_LAUNCHER=ccache   \
	-DCMAKE_CXX_COMPILER_LAUNCHER=ccache \
	-DCMAKE_C_FLAGS="$*"                 \
	-DCMAKE_CXX_FLAGS="$*"               \
	-Wno-dev

ninja
sudo ninja install
ccache -s -v
