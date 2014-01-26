ifneq ($(USE_CAMERA_STUB),true)
ifeq ($(BOARD_USES_QCOM_HARDWARE),true)
ifneq ($(BUILD_TINY_ANDROID),true)

LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

# When zero we link against libmmcamera; when 1, we dlopen libmmcamera.
DLOPEN_LIBMMCAMERA := 1

LOCAL_CFLAGS:= -DDLOPEN_LIBMMCAMERA=$(DLOPEN_LIBMMCAMERA)
BUILD_UNIFIED_CODE := true
LOCAL_CFLAGS+= -DVFE_7X27A

LOCAL_CFLAGS += -DUSE_ION

LOCAL_CFLAGS += -DCAMERA_ION_HEAP_ID=ION_CAMERA_HEAP_ID
LOCAL_CFLAGS += -DCAMERA_ZSL_ION_HEAP_ID=ION_CAMERA_HEAP_ID
LOCAL_CFLAGS += -DCAMERA_GRALLOC_HEAP_ID=GRALLOC_USAGE_PRIVATE_CAMERA_HEAP
LOCAL_CFLAGS += -DCAMERA_GRALLOC_FALLBACK_HEAP_ID=GRALLOC_USAGE_PRIVATE_CAMERA_HEAP
LOCAL_CFLAGS += -DCAMERA_GRALLOC_CACHING_ID=GRALLOC_USAGE_PRIVATE_UNCACHED #uncached
LOCAL_CFLAGS += -DCAMERA_ION_FALLBACK_HEAP_ID=ION_CAMERA_HEAP_ID
LOCAL_CFLAGS += -DCAMERA_ZSL_ION_FALLBACK_HEAP_ID=ION_CAMERA_HEAP_ID

LOCAL_HAL_FILES := \
     QCameraHAL.cpp QCameraHWI_Parm.cpp\
     QCameraHWI.cpp QCameraHWI_Preview.cpp \
     QCameraHWI_Record_7x27A.cpp QCameraHWI_Still.cpp \
     QCameraHWI_Mem.cpp QCameraHWI_Display.cpp \
     QCameraStream.cpp QualcommCamera2.cpp QCameraHWI_Rdi.cpp QCameraParameters.cpp

LOCAL_CFLAGS+= -DHW_ENCODE

LOCAL_SRC_FILES := $(MM_CAM_FILES) $(LOCAL_HAL_FILES)

LOCAL_CFLAGS+= -DNUM_PREVIEW_BUFFERS=4 -D_ANDROID_

LOCAL_CFLAGS+= -DUSE_NEON_CONVERSION
  
LOCAL_C_INCLUDES += $(TARGET_OUT_INTERMEDIATES)/KERNEL_OBJ/usr/include
LOCAL_ADDITIONAL_DEPENDENCIES := $(TARGET_OUT_INTERMEDIATES)/KERNEL_OBJ/usr
LOCAL_C_INCLUDES += \
     $(TARGET_OUT_HEADERS)/mm-still/mm-omx \
     hardware/qcom/display-$(TARGET_QCOM_DISPLAY_VARIANT)/libgralloc \
     hardware/qcom/media-$(TARGET_QCOM_MEDIA_VARIANT)/libstagefrighthw \
     hardware/qcom/media-$(TARGET_QCOM_MEDIA_VARIANT)/mm-core/inc \
     frameworks/base/services/camera/libcameraservice \
     $(LOCAL_PATH)/mm-camera-interface


LOCAL_SHARED_LIBRARIES := \
    libcamera_client \
    libcutils \
    liblog \
    libui \
    libutils \
    libmmjpeg \
    libimage-jpeg-enc-omx-comp \
    libmmstillomx
 
LOCAL_SHARED_LIBRARIES += libmmcamera_interface2

LOCAL_SHARED_LIBRARIES+= libbinder libhardware

      LOCAL_CFLAGS += -include bionic/libc/kernel/common/linux/socket.h

ifeq ($(DLOPEN_LIBMMCAMERA),1)
    LOCAL_SHARED_LIBRARIES += libdl
    LOCAL_CFLAGS += -DDLOPEN_LIBMMCAMERA
else
    LOCAL_SHARED_LIBRARIES += liboemcamera
endif

$(shell mkdir -p $(OUT)/obj/SHARED_LIBRARIES/libmmjpeg_intermediates/)
$(shell touch $(OUT)/obj/SHARED_LIBRARIES/libmmjpeg_intermediates/export_includes)
$(shell mkdir -p $(OUT)/obj/SHARED_LIBRARIES/libimage-jpeg-enc-omx-comp_intermediates/)
$(shell touch $(OUT)/obj/SHARED_LIBRARIES/libimage-jpeg-enc-omx-comp_intermediates/export_includes)
$(shell mkdir -p $(OUT)/obj/SHARED_LIBRARIES/libmmstillomx_intermediates/)
$(shell touch $(OUT)/obj/SHARED_LIBRARIES/libmmstillomx_intermediates/export_includes)

LOCAL_MODULE_PATH := $(TARGET_OUT_SHARED_LIBRARIES)/hw
LOCAL_MODULE := camera.$(TARGET_BOARD_PLATFORM)
LOCAL_MODULE_TAGS := optional
include $(BUILD_SHARED_LIBRARY)
endif # BUILD_TINY_ANDROID
endif # BOARD_USES_QCOM_HARDWARE
endif # USE_CAMERA_STUB

include $(LOCAL_PATH)/mm-camera-interface/Android.mk
