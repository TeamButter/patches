# Copyright (C) 2009 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# we have the common sources, plus some device-specific stuff
sources := \
    AppOpsManager.cpp \
    Binder.cpp \
    BpBinder.cpp \
    BufferedTextOutput.cpp \
    Debug.cpp \
    IAppOpsCallback.cpp \
    IAppOpsService.cpp \
    IInterface.cpp \
    IMemory.cpp \
    IPCThreadState.cpp \
    IPermissionController.cpp \
    IServiceManager.cpp \
    MemoryDealer.cpp \
    MemoryBase.cpp \
    MemoryHeapBase.cpp \
    MemoryHeapIon.cpp \
    Parcel.cpp \
    PermissionCache.cpp \
    ProcessState.cpp \
    Static.cpp \
    TextOutput.cpp \

LOCAL_PATH:= $(call my-dir)

$(warning sec:${USE_PROJECT_SEC})

include $(CLEAR_VARS)
ifeq ($(USE_PROJECT_SEC),true)
LOCAL_C_INCLUDES := $(LOCAL_PATH) \
$(TOP)/external/sqlite/dist
LOCAL_SHARED_LIBRARIES := libsqlite
LOCAL_CFLAGS += -DUSE_PROJECT_SEC
LOCAL_LDFLAGS += $(TOP)/frameworks/native/libs/libsecbinder/libsecbinder.a
endif
LOCAL_LDLIBS += -lpthread
LOCAL_MODULE := libbinder
LOCAL_SHARED_LIBRARIES += liblog libcutils libutils
LOCAL_C_INCLUDES += \
    $(TARGET_OUT_INTERMEDIATES)/KERNEL/usr/include/video/ \
    $(TARGET_OUT_INTERMEDIATES)/KERNEL/
LOCAL_SRC_FILES := $(sources)
include $(BUILD_SHARED_LIBRARY)

include $(CLEAR_VARS)
LOCAL_LDLIBS += -lpthread
LOCAL_MODULE := libbinder
LOCAL_STATIC_LIBRARIES += libutils
LOCAL_SRC_FILES := $(sources)
LOCAL_C_INCLUDES += \
    $(TARGET_OUT_INTERMEDIATES)/KERNEL/usr/include/video/ \
    $(TARGET_OUT_INTERMEDIATES)/KERNEL/
include $(BUILD_STATIC_LIBRARY)
