LOCAL_PATH := $(call my-dir)

ifeq ($(TARGET_DEVICE),gta4xlveu)
include $(call all-subdir-makefiles,$(LOCAL_PATH))
endif
