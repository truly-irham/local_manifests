<img src="https://raw.github.com/DerpFest-AOSP/manifest/14/derp.png">

DerpFest
---------------


Let's build DerpFest for Xiaomi 12 Pro (zeus)!
---------------

To get started with Android, you'll need to get familiar with [Source Control Tools](https://source.android.com/setup/develop).
To set up your build environment and sync DerpFest, please follow this guide: [Link](https://raw.githubusercontent.com/nathanchance/android-tools/main/guides/building_aosp.txt)

**To initialize your local repository using the AOSP/CAF based DerpFest source, use a command like this:**

```bash
repo init -u https://github.com/DerpFest-AOSP/manifest.git -b 14
```
**Let's sync zeus specific trees:**
```bash
git clone https://github.com/truly-irham/local_manifests.git -b derp-14 .repo/local_manifests
```
_Note: You must delete related lines in DerpFest manifest folder to avoid duplicated manifest error during syncing._

**Sync up with this command:**
```bash
repo sync -c --force-sync --optimized-fetch --no-tags --no-clone-bundle --prune -j$(nproc --all)
```
**Apply required changes for zeus before building:**

_Note: You may want to review those changes first before applying_
```bash
cp .repo/local_manifests/changes-derp-zeus.sh ./
./changes-derp-zeus.sh
```
_Note: If the cherry-pick command failed due to conflict, you may want to resolve the conflict manually_

Building the source
---------------

The source at DerpFest is well configured for building.

**Initiate the build with:**
```bash
. build/envsetup.sh
```
**Prepare your device with:**
```bash
lunch derp_zeus-userdebug
```
**Then fire it off with:**
```bash
mka derp
```

Thanks section (zeus source)
---------------

All thanks to @ArianK16a and @Adrianyyyy and all involved (directly or indirectly) devs to make this build possible :D FYI the device, kernel and vendor trees used in this build are all based on their great trees!

Feel free to follow their trees development in this [cupid-development repo.](https://github.com/cupid-development)

Thanks section (DerpFest source)
---------------

Here's my thanks to people who made this possible:

* ABC
* AICP
* AOSiP
* AOSPA
* ArrowOS
* Bianca Project
* BootleggersROM
* CyanogenMod/LineageOS
* DirtyUnicorns
* NitrogenOS
* Nusantara-ROM
* OmniROM
* PixelExperience
* POSP
* Project Fluid
* Project Kaleidoscope
* RiceDroid
* ShapeShiftOS
* Syberia Project
* YAAP

Using our assets
---------------

**Code**

Our codebase is licensed under Apache License, Version 2.0 unless otherwise specified. Apache License 2.0 allows a variety of actions on the content as long as licensing and copyright notices are retained and included with the code and your changes to the codebase are stated.

You can read the full license text at http://www.apache.org/licenses/LICENSE-2.0

**Images & other assets**

Unless otherwise specified, all out assets, including but not limited to images, are licensed under Creative Commons Attribution-NonCommercial 4.0 International, or CC BY-NC 4.0 for short. This means that you are allowed to modify the aforementioned assets in any way you want and you are free to share the originals and/or the modified work. However, you are not allowed to use the assets for commercial purposes and you must provide attribution at all times which means you have to include a short note about the license used (CC BY-NC 4.0), the original author/authors (DerpFest) and inform about any changes that have been made. A link to the website ( derpfest.org ) should usually be included as well.

You can reach the full legal text at http://creativecommons.org/licenses/by-nc/4.0/
