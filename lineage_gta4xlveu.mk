# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit some common LineageOS configurations
$(call inherit-product, vendor/lineage/config/common_full_tablet.mk)

# Inherit device-specific configurations
$(call inherit-product, device/samsung/gta4xlveu/device.mk)

PRODUCT_DEVICE := gta4xlveu
PRODUCT_NAME := lineage_gta4xlveu
PRODUCT_BRAND := samsung
PRODUCT_MANUFACTURER := samsung
