#!/bin/bash
set -e

source "build/envsetup.sh";
source "vendor/lineage/build/envsetup.sh";

# Source: https://gitlab.com/cupid-development/automated-builds/-/raw/main/repopicks.sh

# vendor/lineage
changes=(
367044 # android: merge_dtbs: Respect miboard-id while merging
)
repopick -f -g https://review.lineageos.org -P vendor/lineage ${changes[@]}&

# hardware/xiaomi
changes=(
405259 # fingerprint: Move UDFPS handler and extension out of HIDL
404720 # aidl: fingerprint: Initial stub service
404721 # aidl: fingerprint: Initial Xiaomi implementation
408093 # aidl: fingerprint: Eat vendor acquired messages
408771 # aidl: fingerprint: Allow setting more than one sensor location
)
repopick -f -g https://review.lineageos.org -P hardware/xiaomi ${changes[@]}&

wait

# Build kernel with KernelSU from main branch
cd kernel/xiaomi/sm8450
curl -LSs "https://raw.githubusercontent.com/tiann/KernelSU/main/kernel/setup.sh" | bash -s main
git add --all
git commit -m "Build kernel with KernelSU from main branch"
cd ../../..
