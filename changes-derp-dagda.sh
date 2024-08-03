#!/bin/bash
set -e

source "build/envsetup.sh";
source "vendor/derp/build/envsetup.sh";

# Source: https://gist.github.com/Gelbpunkt/699551aebc5ae12c821ad2ea18b21409

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
392969 # sensors: sensors: Implement udfps long press sensor
393396 # sensors: Implement single tap sensor
393397 # sensors: Implement double tap sensor
392965 # vibrator: effect: Create double click effect from click if necessary
392966 # vibrator: effect: Fallback to click if an effect is missing
)
repopick -g 'https://review.lineageos.org' -P hardware/xiaomi ${changes[@]}&

wait

# Build kernel with KernelSU from main branch
cd kernel/xiaomi/sm8450
curl -LSs "https://raw.githubusercontent.com/tiann/KernelSU/main/kernel/setup.sh" | bash -s main
git add --all
git commit -m "Build kernel with KernelSU from main branch"
cd ../../..

# Revert "kernel: Update default clang version to r510928"
cd vendor/derp
git revert 6fab2c3
cd ../..

# Update lint-baseline.txt
cd frameworks/base
git remote | grep -q "^temp-repo$" || git remote add temp-repo https://github.com/truly-irham/frameworks_base_derpfest.git
git fetch temp-repo
git cherry-pick d07525c
cd ../..
