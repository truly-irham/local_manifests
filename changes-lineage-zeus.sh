#!/bin/bash
set -e

source "build/envsetup.sh";
source "vendor/lineage/build/envsetup.sh";

# frameworks/base
changes=(
386158 # Add 5G Ultra Wideband icon carrier config keys
386159 # Fix default values for 5G Ultra Wideband icon carrier config keys
)
repopick -f -P frameworks/base ${changes[@]}&

# vendor/lineage
changes=(
367044 # android: merge_dtbs: Respect miboard-id while merging
)
repopick -f -P vendor/lineage ${changes[@]}&

wait

## Kernel changes needed to fix fod bugs
cd kernel/xiaomi/sm8450

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
