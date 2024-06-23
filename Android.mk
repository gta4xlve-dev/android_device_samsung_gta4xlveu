LOCAL_PATH := $(call my-dir)

ifeq ($(TARGET_DEVICE),gta4xlveu)
include $(call all-subdir-makefiles,$(LOCAL_PATH))

FIRMWARE_MOUNT_POINT := $(TARGET_OUT_VENDOR)/firmware_mnt
$(FIRMWARE_MOUNT_POINT): $(LOCAL_INSTALLED_MODULE)
	@echo "Creating $(FIRMWARE_MOUNT_POINT)"
	@mkdir -p $(TARGET_OUT_VENDOR)/firmware_mnt

FIRMWARE_MODEM_MOUNT_POINT := $(TARGET_OUT_VENDOR)/firmware-modem
$(FIRMWARE_MODEM_MOUNT_POINT): $(LOCAL_INSTALLED_MODULE)
	@echo "Creating $(FIRMWARE_MODEM_MOUNT_POINT)"
	@mkdir -p $(TARGET_OUT_VENDOR)/firmware-modem

DSP_MOUNT_POINT := $(TARGET_OUT_VENDOR)/dsp
$(DSP_MOUNT_POINT): $(LOCAL_INSTALLED_MODULE)
	@echo "Creating $(DSP_MOUNT_POINT)"
	@mkdir -p $(TARGET_OUT_VENDOR)/dsp

EGL_SYMLINKS := $(TARGET_OUT_VENDOR)/lib/
$(EGL_SYMLINKS): $(LOCAL_INSTALLED_MODULE)
	mkdir -p $@
	$(hide) ln -sf egl/libEGL_adreno.so $@/libEGL_adreno.so
	$(hide) ln -sf egl/libGLESv2_adreno.so $@/libGLESv2_adreno.so


EGL64_SYMLINKS := $(TARGET_OUT_VENDOR)/lib64/
$(EGL64_SYMLINKS): $(LOCAL_INSTALLED_MODULE)
	mkdir -p $@
	$(hide) ln -sf egl/libEGL_adreno.so $@/libEGL_adreno.so
	$(hide) ln -sf egl/libGLESv2_adreno.so $@/libGLESv2_adreno.so

ALL_DEFAULT_INSTALLED_MODULES += $(FIRMWARE_MOUNT_POINT) $(FIRMWARE_MODEM_MOUNT_POINT) $(DSP_MOUNT_POINT)
ALL_DEFAULT_INSTALLED_MODULES += $(EGL_SYMLINKS) $(EGL64_SYMLINKS)

endif
