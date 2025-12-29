#!/usr/bin/env -S PYTHONPATH=../../../tools/extract-utils python3
#
# SPDX-FileCopyrightText: 2024 The LineageOS Project
# SPDX-License-Identifier: Apache-2.0
#

from extract_utils.file import File
from extract_utils.fixups_blob import (
    BlobFixupCtx,
    blob_fixup,
    blob_fixups_user_type,
)
from extract_utils.fixups_lib import (
    lib_fixup_remove,
    lib_fixups,
    lib_fixups_user_type,
)
from extract_utils.main import (
    ExtractUtils,
    ExtractUtilsModule,
)
from extract_utils.tools import (
    llvm_objdump_path,
)
from extract_utils.utils import (
    run_cmd,
)

namespace_imports = [
    "device/samsung/gta4xlveu",
    "hardware/qcom-caf/wlan",
    "hardware/qcom-caf/sm8150",
    "vendor/qcom/opensource/commonsys-intf/display",
    "vendor/qcom/opensource/dataservices",
    "vendor/qcom/opensource/display",
]


def lib_fixup_vendor_suffix(lib: str, partition: str, *args, **kwargs):
    return f'{lib}_{partition}' if partition == 'vendor' else None


lib_fixups: lib_fixups_user_type = {
    **lib_fixups,
    (
        'libc2dcolorconvert',
        'libplatformconfig',
        'libwpa_client',
    ): lib_fixup_remove,
}


blob_fixups: blob_fixups_user_type = {
    (
        'vendor/lib64/hw/gatekeeper.mdfpp.so',
        'vendor/lib64/libkeymaster_helper.so',
        'vendor/lib64/libskeymaster4device.so',
    ): blob_fixup()
        .replace_needed('libcrypto.so', 'libcrypto-v33.so'),
    (
        'vendor/lib/libwvhidl.so',
        'vendor/lib/mediadrm/libwvdrmengine.so',
    ): blob_fixup()
        .add_needed('libcrypto_shim.so'),
    (
        'vendor/lib/libscaler_hw.unifunc.so',
        'vendor/lib/libscaler_sw.unifunc.so',
        'vendor/lib64/libscaler_hw.unifunc.so',
        'vendor/lib64/libscaler_sw.unifunc.so',
    ) : blob_fixup()
        .add_needed('libui_shim.so'),
    'vendor/etc/init/vendor.samsung.hardware.camera.provider@4.0-service.rc': blob_fixup()
        .regex_replace('    interface vendor.samsung.hardware.camera.provider@4.0::ISehCameraProvider legacy/0\n', ''),
}  # fmt: skip

module = ExtractUtilsModule(
    'gta4xlveu',
    'samsung',
    blob_fixups=blob_fixups,
    lib_fixups=lib_fixups,
    namespace_imports=namespace_imports,
)

if __name__ == '__main__':
    utils = ExtractUtils.device(module)
    utils.run()
