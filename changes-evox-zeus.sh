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

# frameworks/base
changes=(
386158 # Add 5G Ultra Wideband icon carrier config keys
386159 # Fix default values for 5G Ultra Wideband icon carrier config keys
)
repopick -g 'https://review.lineageos.org' -P frameworks/base ${changes[@]}&

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
cd ../../..
