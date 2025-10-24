#!/bin/sh

set -ex

ARCH="$(uname -m)"
REPO="https://github.com/azahar-emu/azahar.git"
GRON="https://raw.githubusercontent.com/xonixx/gron.awk/refs/heads/main/gron.awk"
URUNTIME="https://raw.githubusercontent.com/pkgforge-dev/Anylinux-AppImages/refs/heads/main/useful-tools/uruntime2appimage.sh"
SHARUN="https://raw.githubusercontent.com/pkgforge-dev/Anylinux-AppImages/refs/heads/main/useful-tools/quick-sharun.sh"

if [ "$1" = 'v3' ] && [ "$ARCH" = 'x86_64' ]; then
	echo "Making x86-64-v3 optimized build of azahar..."
	ARCH="${ARCH}_v3"
	ARCH_FLAGS="-march=x86-64-v3 -O3 -flto=thin -DNDEBUG"
elif [ "$ARCH" = 'x86_64' ]; then
	echo "Making x86-64 generic build of azahar..."
	ARCH_FLAGS="-march=x86-64 -mtune=generic -O3 -flto=thin -DNDEBUG"
else
	echo "Making aarch64 build of azahar..."
	ARCH_FLAGS="-march=armv8-a -mtune=generic -O3 -flto=thin -DNDEBUG"
fi

# Determine to build nightly or stable
if [ "DEVEL" = 'true' ]; then
	echo "Making nightly build of azahar..."
	VERSION="$(git ls-remote "$REPO" HEAD | cut -c 1-9)"
	git clone --recursive -j$(nproc) "$REPO" ./azahar
else
	echo "Making stable build of azahar..."
	wget "$GRON" -O ./gron.awk
	chmod +x ./gron.awk
	VERSION=$(wget https://api.github.com/repos/azahar-emu/azahar/tags -O - \
		| ./gron.awk | awk -F'=|"' '/name/ {print $3; exit}')
	git clone --recursive -j$(nproc) --branch "$VERSION" --single-branch "$REPO" ./azahar
fi
echo "$VERSION" > ~/version

# BUILD AZAAHR
(
	cd ./azahar
	# HACK
	sed -i '10a #include <memory>' ./src/video_core/shader/shader_jit_a64_compiler.*

	# HACK2
	sed -i '1i find_package(SPIRV-Headers)' ./externals/sirit/sirit/src/CMakeLists.txt

	# HACK3
	qpaheader=$(find /usr/include -type f -name 'qplatformnativeinterface.h' -print -quit)
	sed -i "s|#include <qpa/qplatformnativeinterface.h>|#include <$qpaheader>|" ./src/citra_qt/bootmanager.cpp

	mkdir ./build
	cd ./build
	cmake .. -DCMAKE_CXX_COMPILER=clang++    \
		-DCMAKE_C_COMPILER=clang             \
		-DCMAKE_INSTALL_PREFIX=/usr          \
		-DENABLE_QT_TRANSLATION=ON           \
		-DUSE_SYSTEM_BOOST=OFF               \
		-DCMAKE_BUILD_TYPE=Release           \
		-DUSE_DISCORD_PRESENCE=OFF           \
		-DCMAKE_C_FLAGS="$ARCH_FLAGS"        \
		-DUSE_SYSTEM_VULKAN_HEADERS=ON       \
		-DENABLE_LTO=OFF                     \
		-DENABLE_TESTS=OFF                   \
		-DENABLE_ROOM_STANDALONE=OFF         \
		-DUSE_SYSTEM_GLSLANG=ON              \
		-DCITRA_USE_PRECOMPILED_HEADERS=OFF  \
		-DCMAKE_C_COMPILER_LAUNCHER=ccache   \
		-DCMAKE_CXX_COMPILER_LAUNCHER=ccache \
		-DCMAKE_C_FLAGS="$ARCH_FLAGS"        \
		-DCMAKE_CXX_FLAGS="$ARCH_FLAGS"      \
		-Wno-dev
	cmake --build . -- -j"$(nproc)"
	ccache -s -v
	sudo make install
)
rm -rf ./azahar

# Deploy AppImage
export ADD_HOOKS="self-updater.bg.hook"
export UPINFO="gh-releases-zsync|${GITHUB_REPOSITORY%/*}|${GITHUB_REPOSITORY#*/}|latest|*$ARCH.AppImage.zsync"
export OUTNAME=Azahar-Enhanced-"$VERSION"-anylinux-"$ARCH".AppImage
export DESKTOP=/usr/share/applications/org.azahar_emu.Azahar.desktop
export ICON=/usr/share/icons/hicolor/512x512/apps/org.azahar_emu.Azahar.png
export DEPLOY_OPENGL=1 
export DEPLOY_VULKAN=1 
export DEPLOY_PIPEWIRE=1

# ADD LIBRARIES
wget --retry-connrefused --tries=30 "$SHARUN" -O ./quick-sharun
chmod +x ./quick-sharun
./quick-sharun /usr/bin/azahar* /usr/lib/libgamemode.so*

# differentiate betwee dev and stable builds
if [ "$DEVEL" = 'true' ]; then
	sed -i 's|Name=Azahar|Name=Azahar nightly|' ./AppDir/*.desktop
	UPINFO="$(echo "$UPINFO" | sed 's|latest|nightly|')"
fi

# MAKE APPIMAGE WITH URUNTIME
wget --retry-connrefused --tries=30 "$URUNTIME" -O ./uruntime2appimage
chmod +x ./uruntime2appimage
./uruntime2appimage
