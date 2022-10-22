# sync rom
repo init --depth=1 -u https://github.com/AOSPA/manifest.git -b topaz -g default,-mips,-darwin,-notdefault
git clone https://github.com/pa-stelt/local_manifest --depth 1 -b topaz .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
source build/envsetup.sh
lunch aospa_miatoll-userdebug
./rom-build.sh miatoll -t userdebug


# upload rom
# If you need to upload json/multiple files too then put like this 'rclone copy out/target/product/mido/*.zip cirrus:mido -P  rclone copy out/target/product/mido/*.zip.json cirrus:mido -P'
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
