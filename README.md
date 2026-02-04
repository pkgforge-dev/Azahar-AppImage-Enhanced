<div align="center">

# Azahar-AppImage-Enhanced 🐧

[![GitHub Downloads](https://img.shields.io/github/downloads/pkgforge-dev/Azahar-AppImage-Enhanced/total?logo=github&label=GitHub%20Downloads)](https://github.com/pkgforge-dev/Azahar-AppImage-Enhanced/releases/latest)
[![CI Build Status](https://github.com//pkgforge-dev/Azahar-AppImage-Enhanced/actions/workflows/appimage.yml/badge.svg)](https://github.com/pkgforge-dev/Azahar-AppImage-Enhanced/releases/latest)
[![Latest Stable Release](https://img.shields.io/github/v/release/pkgforge-dev/Azahar-AppImage-Enhanced)](https://github.com/pkgforge-dev/Azahar-AppImage-Enhanced/releases/latest)

<p align="center">
  <img src="https://github.com/azahar-emu/azahar/blob/master/dist/azahar.svg" width="128" />
</p>


| Latest Stable Release | Latest Nightly Relase | Upstream URL |
| :---: | :---: | :---: |
| [Click here](https://github.com/pkgforge-dev/Azahar-AppImage-Enhanced/releases/latest) | [Click here](https://github.com/pkgforge-dev/Azahar-AppImage-Enhanced/releases/tag/nightly) | [Click here](https://github.com/azahar-emu/azahar) |

Improved AppImage of cemu **independent of the host libc** which makes able to work on very very old distros as well as musl-libc distros like alpine linux. It is also **optimized for `x86-64-v3`** cpus giving a performance boost. 

</div>

---

Upstream Azahar refuses to follow the bare minimum suggested by the appimage spec of targetting the oldest still suppot ubuntu LTS release, which at the time of writting this is Ubuntu 20.04.

* https://github.com/azahar-emu/azahar/issues/127#issuecomment-2292289736

* https://github.com/azahar-emu/azahar/issues/772#issuecomment-2746320155

* https://github.com/azahar-emu/azahar/issues/985 wtf?!

* https://github.com/azahar-emu/azahar/issues/1115

This AppImage is not only able to work on such old systems, it is able to work on ubuntu **14.04** and Alpine linux (musl). The limit here being a too old kernel and not the libc.

---

AppImage made using [sharun](https://github.com/VHSgunzo/sharun) and its wrapper [quick-sharun](https://github.com/pkgforge-dev/Anylinux-AppImages/blob/main/useful-tools/quick-sharun.sh), which makes it extremely easy to turn any binary into a portable package reliably without using containers or similar tricks. 

**This AppImage bundles everything and it should work on any Linux distro, including old and musl-based ones.**

It is possible that this appimage may fail to work with appimagelauncher, I recommend these alternatives instead: 

* [AM](https://github.com/ivan-hc/AM) `am -i azahar-enhanced` or `appman -i azahar-enhanced`

* [dbin](https://github.com/xplshn/dbin) `dbin install azahar-enhanced.appimage`

* [soar](https://github.com/pkgforge/soar) `soar install azahar-enhanced`

This AppImage doesn't require FUSE to run at all, thanks to the [uruntime](https://github.com/VHSgunzo/uruntime).

This AppImage is also supplied with a self-updater by default, so any updates to this application won't be missed, you will be prompted for permission to check for updates and if agreed you will then be notified when a new update is available.

Self-updater is disabled by default if AppImage managers like [am](https://github.com/ivan-hc/AM), [soar](https://github.com/pkgforge/soar) or [dbin](https://github.com/xplshn/dbin) exist, which manage AppImage updates.

<details>
  <summary><b><i>raison d'être</i></b></summary>
    <img src="https://github.com/user-attachments/assets/d40067a6-37d2-4784-927c-2c7f7cc6104b" alt="Inspiration Image">
  </a>
</details>

---

More at: [AnyLinux-AppImages](https://pkgforge-dev.github.io/Anylinux-AppImages/)

---

# READ THIS IF YOU HAVE ISSUES

If you are on wayland (specially GNOME wayland) and get freezes or crahes you are likely affected by this issue that affects all Qt6 apps: https://github.com/pkgforge-dev/Citron-AppImage/issues/50

To fix it simply set the env variable `QT_QPA_PLATFORM=xcb`
