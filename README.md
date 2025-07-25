# Azahar-AppImage-Enhanced 🐧

[![GitHub Downloads](https://img.shields.io/github/downloads/pkgforge-dev/Azahar-AppImage-Enhanced/total?logo=github&label=GitHub%20Downloads)](https://github.com/pkgforge-dev/Azahar-AppImage-Enhanced/releases/latest)
[![CI Build Status](https://github.com//pkgforge-dev/Azahar-AppImage-Enhanced/actions/workflows/stable.yml/badge.svg)](https://github.com/pkgforge-dev/Azahar-AppImage-Enhanced/releases/latest)

Improved AppImage of Azahar **independent of the host libc** and added bonus `x86_64_v3` optimizations.

* [Latest Stable Release](https://github.com/pkgforge-dev/Azahar-AppImage-Enhanced/releases/latest)

* [Latest Nightly Release](https://github.com/pkgforge-dev/Azahar-AppImage-Enhanced/releases/tag/nightly)

Upstream Azahar refuses to follow the bare minimum suggested by the appimage spec of targetting the oldest still suppot ubuntu LTS release, which at the time of writting this is Ubuntu 20.04.

* https://github.com/azahar-emu/azahar/issues/127#issuecomment-2292289736

* https://github.com/azahar-emu/azahar/issues/772#issuecomment-2746320155

* https://github.com/azahar-emu/azahar/issues/985 wtf?!

* https://github.com/azahar-emu/azahar/issues/1115

This AppImage is not only able to work on such old systems, it is able to work on ubuntu **14.04** and Alpine linux (musl). The limit here being a too old kernel and not the libc.

---

AppImage made using [sharun](https://github.com/VHSgunzo/sharun), which makes it extremely easy to turn any binary into a portable package without using containers or similar tricks.

**This AppImage bundles everything and should work on any linux distro, even on musl based ones.**

It is possible that this appimage may fail to work with appimagelauncher, I recommend these alternatives instead: 

* [AM](https://github.com/ivan-hc/AM) `am -i azahar-enhanced` or `appman -i azahar-enhanced`

* [dbin](https://github.com/xplshn/dbin) `dbin install azahar-enhanced.appimage`

* [soar](https://github.com/pkgforge/soar) `soar install azahar-enhanced`

This appimage works without fuse2 as it can use fuse3 instead, it can also work without fuse at all thanks to the [uruntime](https://github.com/VHSgunzo/uruntime)

<details>
  <summary><b><i>raison d'être</i></b></summary>
    <img src="https://github.com/user-attachments/assets/d40067a6-37d2-4784-927c-2c7f7cc6104b" alt="Inspiration Image">
  </a>
</details>

---

More at: [AnyLinux-AppImages](https://pkgforge-dev.github.io/Anylinux-AppImages/) 
