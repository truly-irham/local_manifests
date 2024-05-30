#!/bin/bash
set -e

source "build/envsetup.sh";
source "vendor/derp/build/envsetup.sh";

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
352664 # sensors: Create sysfs polling one shot sensor
392967 # sensors: Let the reading of poll fd be configurable
392968 # sensors: Add SysfsPollingOneShotSensor constructor without enable path
392969 # sensors: Add udfps long press sensor using SysfsPollingOneShotSensor
352665 # sensors: Handle fod_pressed_state without coordinates
363160 # hidl: biometrics: fingerprint: Add enroll methods to udfps handler
392965 # vibrator: effect: Create double click effect from click if necessary
392966 # vibrator: effect: Fallback to click if an effect is missing
)
repopick -g 'https://review.lineageos.org' -P hardware/xiaomi ${changes[@]}&

# vendor/qcom/opensource/vibrator
changes=(
392952 # vibrator: Use a better check for primitive effects
)
repopick -g 'https://review.lineageos.org' -P vendor/qcom/opensource/vibrator ${changes[@]}&

wait

# Build kernel with KernelSU from main branch
cd kernel/xiaomi/sm8450
curl -LSs "https://raw.githubusercontent.com/tiann/KernelSU/main/kernel/setup.sh" | bash -s main
git add --all
git commit -m "Build kernel with KernelSU from main branch"

## Kernel changes needed to fix fod bugs
# Revert "input: touchscreen: fts_spi: Change enable_touch_raw argument to int"
git revert d21b9ed388ecb92507b6f419c154f1a986e857a0 
# Revert "input: touchscreen: xiaomi: Get rid of notify buf spam"
git revert 8771494695f2bf0a07cfd25558aa0cc587285b6f
# Revert "[WIP] input: touchscreen: xiaomi: Reverse from stock module"
git revert 5072e0d2522c7ac6224f6fae122b93e530ba26c5 
# Reapply "input: touchscreen: xiaomi: Implement touch_thp_film"
git revert e208d317cd43bcdb4167d5f4886b365a8fdf1141 
# Revert "input: touchsreen: xiaomi: Import updated header from M11"
git revert 5341aa543f2bc9fd1fd4d83c3189a6463d6469cd 

cd ../../..
