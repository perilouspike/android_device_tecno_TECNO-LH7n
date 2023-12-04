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

# Configure base.mk
$(call inherit-product, $(SRC_TARGET_DIR)/product/base.mk)

# Configure core_64_bit.mk
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)

# Configure launch_with_vendor_ramdisk.mk
$(call inherit-product, $(SRC_TARGET_DIR)/product/virtual_ab_ota/launch_with_vendor_ramdisk.mk)

# Configure emulated_storage.mk
$(call inherit-product, $(SRC_TARGET_DIR)/product/emulated_storage.mk)

# Configure twrp config common.mk
$(call inherit-product, vendor/twrp/config/common.mk)

# Inherit from TECNO-LH7n device
$(call inherit-product, device/tecno/TECNO-LH7n/device.mk)

# Device Target Name
PRODUCT_RELEASE_NAME := TECNO-LH7n

# Device identifier
PRODUCT_DEVICE := TECNO-LH7n
PRODUCT_NAME := twrp_TECNO-LH7n
PRODUCT_BRAND := TECNO
PRODUCT_MODEL := TECNO LH7n
PRODUCT_MANUFACTURER := tecno

PRODUCT_GMS_CLIENTID_BASE := android-$(PRODUCT_RRAND)

# Hide Reflash TWRP
PRODUCT_BUILD_PROP_OVERRIDES += ro.twrp.vendor_boot=true
