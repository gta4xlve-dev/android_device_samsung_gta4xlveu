ifeq ($(TARGET_DEVICE),gta4xlveu)
# Generate a tar package which includes the recovery and vbmeta
RECOVERYTAR_DEPS := $(PRODUCT_OUT)/recovery.img $(PRODUCT_OUT)/vbmeta.img

INSTALLED_RECOVERYTAR_TARGET := $(PRODUCT_OUT)/recovery-$(LINEAGE_VERSION).tar
$(INSTALLED_RECOVERYTAR_TARGET): $(RECOVERYTAR_DEPS)
	@echo "Recovery and vbmeta package: $@"
	$(hide) tar -cf $@ -C $(PRODUCT_OUT) recovery.img vbmeta.img

.PHONY: recoverytar
recoverytar: $(INSTALLED_RECOVERYTAR_TARGET)

$(BUILT_TARGET_FILES_PACKAGE): $(INSTALLED_RECOVERYTAR_TARGET)
endif
