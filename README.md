![Evolution X](https://github.com/Evolution-XYZ/manifest/raw/udc/Banner.png)

Let's build Evolution X for Xiaomi 12 Pro (dagda/zeus)!
---------------

## Pre-requisites and setting up build environment

LineageOS wiki covers everything necessary for setting up build environment. Please refer to [this wiki](https://lineage-wiki.mainlining.org/devices/zeus/build/) until you have successfully set up your build environment.

## Initialize local repository
```
repo init -u https://github.com/Evolution-XYZ/manifest -b udc --git-lfs
```

## Let's sync dagda/zeus specific trees!
```bash
git clone https://github.com/truly-irham/local_manifests.git -b udc .repo/local_manifests
```

## Sync up
```
repo sync -c -j$(nproc --all) --force-sync --no-clone-bundle --no-tags
```

## Apply required changes for dagda/zeus before building:

_Note: You may want to review those changes first before applying_
```bash
cp .repo/local_manifests/changes-evox-dagda.sh ./
./changes-evox-dagda.sh
```
_Note: If the cherry-pick command failed due to conflict, you may want to resolve the conflict manually_

## Build

- Set up the build environment
```bash
. build/envsetup.sh
```

- Lunch a target
```bash
lunch lineage_dagda-userdebug
```

- To start compiling
```bash
m evolution
```

Thanks section (dagda/zeus source)
---------------

All thanks to @ArianK16a and @Adrianyyyy and all involved (directly or indirectly) devs to make this build possible :D FYI the device, kernel and vendor trees used in this build are all based on their great trees!

Feel free to follow their trees development in this [cupid-development repo.](https://github.com/cupid-development)
