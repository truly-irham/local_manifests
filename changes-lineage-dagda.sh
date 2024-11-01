#!/bin/bash
set -e

source "build/envsetup.sh";
source "vendor/lineage/build/envsetup.sh";

# Source: https://gitlab.com/cupid-development/automated-builds/-/raw/main/repopicks.sh

# hardware/qcom-caf/sm8450/audio/primary-hal
changes=(
406470 # configs: Allow setsockopt syscall for qcom c2audio
406471 # hal: Guard primary audio HAL in case target provides prebuilt
406472 # hal: Move audio primary HAL guard
406473 # hal: Depend on agmserver and palserver headers
)
repopick -g https://review.lineageos.org -P hardware/qcom-caf/sm8450/audio/primary-hal ${changes[@]}&

# hardware/qcom-caf/sm8450/display
changes=(
397275 # gralloc: Allow devices to opt-in for YCrCb camera video encode
)
repopick -g https://review.lineageos.org -P hardware/qcom-caf/sm8450/display ${changes[@]}&

wait

# Build kernel with KernelSU from main branch
cd kernel/xiaomi/sm8450
curl -LSs "https://raw.githubusercontent.com/tiann/KernelSU/main/kernel/setup.sh" | bash -s main
git add --all
git commit -m "Build kernel with KernelSU from main branch"
cd ../../..
