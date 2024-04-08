#!/bin/bash
set -e

source "build/envsetup.sh";
source "vendor/evolution/build/envsetup.sh";

# Reference/Source: https://xdaforums.com/t/development-of-lineageos-and-oss-kernel-for-xiaomi-sm-gen-4-5-10-devices.4589247/

# device/qcom/sepolicy_vndr/sm8450
changes=(
383884 # sepolicy_vndr: update sepolicy for health HAL service
)
repopick -g 'https://review.lineageos.org' -P device/qcom/sepolicy_vndr/sm8450 ${changes[@]}&

# hardware/xiaomi
changes=(
352657 # Add dummy sensors sub HAL
352658 # sensors: Make sensor batch function virtual
352659 # sensors: Make sensor run function virtual
352660 # sensors: Make sensor flush function virtual
352661 # sensors: Make sensor set mode operation function virtual
352662 # sensors: Move one shot sensor out of main class
352663 # sensors: Fix locking around setOperationMode and activate
352664 # sensors: Add udfps long press sensor
352665 # sensors: Handle fod_pressed_state without coordinates
363160 # hidl: biometrics: fingerprint: Add enroll methods to udfps handler
)
repopick -g 'https://review.lineageos.org' -P hardware/xiaomi ${changes[@]}&

wait

# hardware/qcom-caf/sm8450/display
cd hardware/qcom-caf/sm8450/display
git pull https://github.com/LineageOS/android_hardware_qcom_display refs/changes/99/384299/1
cd ../../../../

# Build kernel with KernelSU from main branch
cd kernel/xiaomi/sm8450
curl -LSs "https://raw.githubusercontent.com/tiann/KernelSU/main/kernel/setup.sh" | bash -s main
git add --all
git commit -m "Build kernel with KernelSU from main branch"

## Kernel changes needed to fix fod bugs
# Revert "input: touchscreen: fts_spi: Change enable_touch_raw argument to int"
git revert bed962031b69bb2631bf04009f0079ecc4ed29b6
# Revert "input: touchscreen: xiaomi: Get rid of notify buf spam"
git revert c0661c5fcde39971988261c218965d13116a95f9
# Revert "[WIP] input: touchscreen: xiaomi: Reverse from stock module"
git revert ece512e186d65f0522483871ee9e4b1e4e45507a
# Reapply "input: touchscreen: xiaomi: Implement touch_thp_film"
git revert 93250170f8ad3a29ac62a1a0f83649af4b8dcd00
# Revert "input: touchsreen: xiaomi: Import updated header from M11"
git revert 2ecbc6be1670837b29cb7b12717e3a7e00415f99

cd ../../..
