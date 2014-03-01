LOCAL_PATH:= $(call my-dir)
include $(CLEAR_VARS)

# files that live under device/lge/msm7x27a-common/rootdir/etc/

include $(CLEAR_VARS)
LOCAL_MODULE       := init.lge-shared.rc
LOCAL_MODULE_TAGS  := optional eng
LOCAL_MODULE_CLASS := ETC
LOCAL_SRC_FILES    := etc/init.lge-shared.rc
LOCAL_MODULE_PATH  := $(TARGET_ROOT_OUT)
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE       := init.target.rc
LOCAL_MODULE_TAGS  := optional eng
LOCAL_MODULE_CLASS := ETC
LOCAL_SRC_FILES    := etc/init.target.rc
LOCAL_MODULE_PATH  := $(TARGET_ROOT_OUT)
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE       := init.lge.usb.rc
LOCAL_MODULE_TAGS  := optional eng
LOCAL_MODULE_CLASS := ETC
LOCAL_SRC_FILES    := etc/init.lge.usb.rc
LOCAL_MODULE_PATH  := $(TARGET_ROOT_OUT)
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE       := init.qcom.post_boot.sh
LOCAL_MODULE_TAGS  := optional eng
LOCAL_MODULE_CLASS := ETC
LOCAL_SRC_FILES    := etc/init.qcom.post_boot.sh
LOCAL_MODULE_PATH  := $(TARGET_OUT_ETC)
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE       := init.qcom.efs.sync.sh
LOCAL_MODULE_TAGS  := optional eng
LOCAL_MODULE_CLASS := ETC
LOCAL_SRC_FILES    := etc/init.qcom.efs.sync.sh
LOCAL_MODULE_PATH  := $(TARGET_OUT_ETC)
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE       := init.lge.target.sh
LOCAL_MODULE_TAGS  := optional eng
LOCAL_MODULE_CLASS := ETC
LOCAL_SRC_FILES    := etc/init.lge.target.sh
LOCAL_MODULE_PATH  := $(TARGET_OUT_ETC)
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE       := init.qcom.baseband.sh
LOCAL_MODULE_TAGS  := optional eng
LOCAL_MODULE_CLASS := ETC
LOCAL_SRC_FILES    := etc/init.qcom.baseband.sh
LOCAL_MODULE_PATH  := $(TARGET_OUT_ETC)
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE       := hostapd.accept
LOCAL_MODULE_TAGS  := optional eng
LOCAL_MODULE_CLASS := ETC
LOCAL_SRC_FILES    := etc/hostapd/hostapd.accept
LOCAL_MODULE_PATH  := $(TARGET_OUT_ETC)/hostapd
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE       := hostapd.deny
LOCAL_MODULE_TAGS  := optional eng
LOCAL_MODULE_CLASS := ETC
LOCAL_SRC_FILES    := etc/hostapd/hostapd.deny
LOCAL_MODULE_PATH  := $(TARGET_OUT_ETC)/hostapd
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE       := hostapd_default.conf
LOCAL_MODULE_TAGS  := optional eng
LOCAL_MODULE_CLASS := ETC
LOCAL_SRC_FILES    := etc/hostapd/hostapd_default.conf
LOCAL_MODULE_PATH  := $(TARGET_OUT_ETC)/hostapd
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE       := wpa_supplicant_overlay.conf
LOCAL_MODULE_TAGS  := optional eng
LOCAL_MODULE_CLASS := ETC
LOCAL_SRC_FILES    := etc/wifi/wpa_supplicant_overlay.conf
LOCAL_MODULE_PATH  := $(TARGET_OUT_ETC)/wifi
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE       := p2p_supplicant_overlay.conf
LOCAL_MODULE_TAGS  := optional eng
LOCAL_MODULE_CLASS := ETC
LOCAL_SRC_FILES    := etc/wifi/p2p_supplicant_overlay.conf
LOCAL_MODULE_PATH  := $(TARGET_OUT_ETC)/wifi
include $(BUILD_PREBUILT)
