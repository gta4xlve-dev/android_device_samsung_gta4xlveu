#!/bin/bash
#
# Copyright (C) 2016 The CyanogenMod Project
# Copyright (C) 2017-2020 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

set -e

DEVICE=gta4xlveu
VENDOR=samsung

# Load extract_utils and do some sanity checks
MY_DIR="${BASH_SOURCE%/*}"
if [[ ! -d "${MY_DIR}" ]]; then MY_DIR="${PWD}"; fi

ANDROID_ROOT="${MY_DIR}/../../.."

HELPER="${ANDROID_ROOT}/tools/extract-utils/extract_utils.sh"
if [ ! -f "${HELPER}" ]; then
    echo "Unable to find helper script at ${HELPER}"
    exit 1
fi
source "${HELPER}"

SRC="$1"
if [ -z "${SRC}" ]; then
    SRC="adb"
fi

VENDOR_SECURITY_PATCH=""
if [[ "${SRC}" == "adb" ]]; then
    VENDOR_SECURITY_PATCH="$(adb shell getprop ro.vendor.build.security_patch)"
elif [[ -f "${SRC}/vendor/build.prop" ]]; then
    VENDOR_SECURITY_PATCH="$(cat ${SRC}/vendor/build.prop | grep ro.vendor.build.security_patch | cut -d "=" -f 2)"
fi

if [[ "$VENDOR_SECURITY_PATCH" == "" ]]; then
    echo "Unable to determine the vendor security patch"
    exit 1
else
    echo "Vendor security patch detected as $VENDOR_SECURITY_PATCH"
fi

# Initialize the helper
setup_vendor "${DEVICE}" "${VENDOR}" "${ANDROID_ROOT}"

# Warning headers and guards
write_headers

write_makefiles "${MY_DIR}/proprietary-files.txt" true

(cat << EOF) >> $BOARDMK
VENDOR_SECURITY_PATCH := ${VENDOR_SECURITY_PATCH}
EOF

# Finish
write_footers
