# Copyright (C) 2023 The Android Open Source Project
# Copyright (C) 2023 TeamWin Recovery Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Device path
DEVICE_PATH := device/tecno/TECNO-LH7n

# For building with minimal manifest
ALLOW_MISSING_DEPENDENCIES := true
BUILD_BROKEN_DUP_RULES := true
BUILD_BROKEN_ELF_PREBUILT_PRODUCT_COPY_FILES := true
BUILD_BROKEN_PREBUILT_ELF_FILES := true

# Architecture
TARGET_ARCH := arm64
TARGET_ARCH_VARIANT := armv8-a
TARGET_CPU_ABI := arm64-v8a
TARGET_CPU_ABI2 := 
TARGET_CPU_VARIANT := generic
TARGET_CPU_VARIANT_RUNTIME := cortex-a55

TARGET_2ND_ARCH := arm
TARGET_2ND_ARCH_VARIANT := armv7-a-neon
TARGET_2ND_CPU_ABI := armeabi-v7a
TARGET_2ND_CPU_ABI2 := armeabi
TARGET_2ND_CPU_VARIANT := generic
TARGET_2ND_CPU_VARIANT_RUNTIME := cortex-a55
TARGET_USES_64_BIT_BINDER := true

# CPU sets
ENABLE_CPUSETS := true
ENABLE_SCHEDBOOST := true

# Assertation
TARGET_OTA_ASSERT_DEVICE := TECNO-LH7n

# Bootloader
TARGET_BOOTLOADER_BOARD_NAME := TECNO-LH7n
TARGET_NO_BOOTLOADER := true
TARGET_USES_UEFI := true

# MTK Hardware
BOARD_HAS_MTK_HARDWARE := true
BOARD_USES_MTK_HARDWARE := true
MTK_HARDWARE := true

# APEX
OVERRIDE_TARGET_FLATTEN_APEX := true

# Display
TARGET_SCREEN_DENSITY := 480

# A/B
AB_OTA_UPDATER := true
AB_OTA_PARTITIONS += \
    system \
    system \
    vendor \
    product \
    system_ext \
    vendor_dlkm \
    odm_dlkm \
    boot \
    vbmeta_vendor \
    vbmeta_system

# Kernel
TARGET_NO_KERNEL := true
TARGET_KERNEL_ARCH := $(TARGET_ARCH)
TARGET_KERNEL_HEADER_ARCH := $(TARGET_ARCH)
BOARD_PAGE_SIZE := 4096
BOARD_BOOT_HEADER_VERSION := 4
BOARD_DTB_OFFSET := 0x07c88000
BOARD_KERNEL_BASE := 0x3fff8000
BOARD_TAGS_OFFSET := 0x07c88000
BOARD_KERNEL_OFFSET := 0x00008000
BOARD_RAMDISK_OFFSET := 0x26f08000
BOARD_KERNEL_TAGS_OFFSET := 0x07c88000
BOARD_DTB_SIZE := 183338
BOARD_HEADER_SIZE := 2128
BOARD_KERNEL_SEPARATED_DTBO := true
BOARD_RAMDISK_USE_LZ4 := true

# Vendor command line
BOARD_VENDOR_CMDLINE := bootopt=64S3,32N2,64N2

# Args
BOARD_MKBOOTIMG_ARGS += --dtb $(TARGET_PREBUILT_DTB)
BOARD_MKBOOTIMG_ARGS += --vendor_cmdline $(BOARD_VENDOR_CMDLINE)
BOARD_MKBOOTIMG_ARGS += --pagesize $(BOARD_PAGE_SIZE) --board ""
BOARD_MKBOOTIMG_ARGS += --kernel_offset $(BOARD_KERNEL_OFFSET)
BOARD_MKBOOTIMG_ARGS += --ramdisk_offset $(BOARD_RAMDISK_OFFSET)
BOARD_MKBOOTIMG_ARGS += --tags_offset $(BOARD_TAGS_OFFSET)
BOARD_MKBOOTIMG_ARGS += --header_version $(BOARD_BOOT_HEADER_VERSION)
BOARD_MKBOOTIMG_ARGS += --dtb_offset $(BOARD_DTB_OFFSET)

# Kernel - prebuilt
TARGET_PREBUILT_DTB := $(DEVICE_PATH)/prebuilt/dtb.img

# Partitions
BOARD_FLASH_BLOCK_SIZE := 262144 # (BOARD_KERNEL_PAGESIZE * 64)
BOARD_VENDOR_BOOTIMAGE_PARTITION_SIZE := 67108864
BOARD_SUPER_PARTITION_SIZE := 9126805504 # TODO: Fix hardcoded value

 # File System
BOARD_HAS_LARGE_FILESYSTEM := true
BOARD_SYSTEMIMAGE_PARTITION_TYPE := ext4
BOARD_USERDATAIMAGE_FILE_SYSTEM_TYPE := f2fs
BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE := erofs
BOARD_PRODUCTIMAGE_FILE_SYSTEM_TYPE := erofs
BOARD_SYSTEM_EXTIMAGE_FILE_SYSTEM_TYPE := erofs

# Dynamic Partition
BOARD_MAIN_SIZE := 9122611200
BOARD_SUPER_PARTITION_GROUPS := main
BOARD_MAIN_PARTITION_LIST := \
    system \
    system_ext \
    vendor \
    product\ system_ext \
    vendor_dlkm \
    odm_dlkm

BOARD_PARTITION_LIST := $(call to-upper, $(BOARD_MAIN_PARTITION_LIST))
$(foreach p, $(BOARD_PARTITION_LIST), $(eval BOARD_$(p)IMAGE_FILE_SYSTEM_TYPE := erofs))
$(foreach p, $(BOARD_PARTITION_LIST), $(eval TARGET_COPY_OUT_$(p) := $(call to-lower, $(p))))

# Platform
PRODUCT_PLATFORM := mt6833
TARGET_BOARD_PLATFORM := $(PRODUCT_PLATFORM)

# Recovery
TARGET_NO_RECOVERY := true
TARGET_RECOVERY_PIXEL_FORMAT := RGBX_8888
TARGET_USERIMAGES_USE_EXT4 := true
TARGET_USERIMAGES_USE_F2FS := true

# Fstab Path
TARGET_RECOVERY_FSTAB := $(DEVICE_PATH)/recovery/root/system/etc/recovery.fstab

# Copy fstab to ensure the first stage boot mounts everything we need.
PRODUCT_COPY_FILES += $(DEVICE_PATH)/fstab.$(TARGET_BOARD_PLATFORM):$(TARGET_COPY_OUT_RECOVERY)/root/first_stage_ramdisk/fstab.$(TARGET_BOARD_PLATFORM)
PRODUCT_COPY_FILES += $(DEVICE_PATH)/fstab.$(TARGET_BOARD_PLATFORM):$(TARGET_COPY_OUT_RECOVERY)/root/vendor/etc/fstab.$(TARGET_BOARD_PLATFORM)
PRODUCT_COPY_FILES += $(DEVICE_PATH)/fstab.$(TARGET_BOARD_PLATFORM):$(TARGET_COPY_OUT_VENDOR)/etc/fstab.$(TARGET_BOARD_PLATFORM)

# Workaround for error copying vendor files to recovery ramdisk
TARGET_COPY_OUT_PRODUCT := product
TARGET_COPY_OUT_VENDOR := vendor
TARGET_COPY_OUT_SYSTEM_EXT := system_ext

# System as root
BOARD_SUPPRESS_SECURE_ERASE := true
BOARD_BUILD_SYSTEM_ROOT_IMAGE := false
BOARD_HAS_NO_SELECT_BUTTON := true

# Verified Boot
BOARD_AVB_ENABLE := true
BOARD_AVB_MAKE_VBMETA_IMAGE_ARGS += --flags 3

# Hack: prevent anti rollback
PLATFORM_VERSION := 13
PLATFORM_SECURITY_PATCH := 2099-12-31
BOOT_SECURITY_PATCH := $(PLATFORM_SECURITY_PATCH)
VENDOR_SECURITY_PATCH := $(PLATFORM_SECURITY_PATCH)
PLATFORM_VERSION_LAST_STABLE := $(PLATFORM_VERSION)

# Properties
TARGET_SYSTEM_PROP += $(DEVICE_PATH)/system.prop

# Vendor_boot recovery ramdisk
BOARD_USES_RECOVERY_AS_BOOT :=
BOARD_USES_GENERIC_KERNEL_IMAGE := true
BOARD_MOVE_RECOVERY_RESOURCES_TO_VENDOR_BOOT := true
BOARD_EXCLUDE_KERNEL_FROM_RECOVERY_IMAGE := 
BOARD_MOVE_GSI_AVB_KEYS_TO_VENDOR_BOOT :=

# TWRP Configuration
TW_THEME := portrait_hdpi
TW_SCREEN_BLANK_ON_BOOT := true
TW_INPUT_BLACKLIST := "hbtp_vm"
TARGET_USES_MKE2FS := true
TW_INCLUDE_FASTBOOTD := true

# Crypto
#TW_INCLUDE_CRYPTO := true
#TW_INCLUDE_CRYPTO_FBE := true
#BOARD_USES_METADATA_PARTITION := true
#TW_INCLUDE_FBE_METADATA_DECRYPT := true
#TW_USE_FSCRYPT_POLICY := 2

# Set brightness path and level
TW_BRIGHTNESS_PATH := "/sys/class/leds/lcd-backlight/brightness"
TW_DEFAULT_BRIGHTNESS := 500
TW_MAX_BRIGHTNESS := 1000

# Debug
TWRP_INCLUDE_LOGCAT := true
TARGET_USES_LOGD := true

# Maintainer/Version
TW_DEVICE_VERSION := perilouspike

# Use Toolbox instead of Busybox
TW_USE_TOOLBOX := true

# Include binaries
TW_INCLUDE_RESETPROP := true
TW_INCLUDE_REPACKTOOLS := true
TW_INCLUDE_LIBRESETPROP := true

# Excludes
TW_EXCLUDE_APEX := true
TW_EXCLUDE_TWRP_APP := true
TW_EXCLUDE_NANO := true
TW_EXCLUDE_PYTHON := true
