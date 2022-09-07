# Use absolute path for better access from everywhere
TOP_DIR 	:= $(shell pwd)

LIB_DIR := $(TOP_DIR)/lib

# Clear the flags from env
CPPFLAGS :=
LDFLAGS :=

# Verbose flag
ifeq ($(VERBOSE), 1)
AT =
else
AT = @
endif

# ARM ABI of the target platform
ifeq ($(TEGRA_ARMABI),)
#TEGRA_ARMABI ?= aarch64-linux-gnu
endif

# Location of the target rootfs
ifeq ($(shell uname -m), aarch64)
TARGET_ROOTFS :=
else
ifeq ($(TARGET_ROOTFS),)
#TARGET_ROOTFS=$(TOP_DIR)/build/rootfs
endif
endif

ifeq ($(shell uname -m), aarch64)
CROSS_COMPILE :=
else
#CROSS_COMPILE ?= aarch64-unknown-linux-gnu-
endif
AS             = $(AT) $(CROSS_COMPILE)as
LD             = $(AT) $(CROSS_COMPILE)ld
CC             = $(AT) $(CROSS_COMPILE)gcc
CPP            = $(AT) $(CROSS_COMPILE)g++
AR             = $(AT) $(CROSS_COMPILE)ar
NM             = $(AT) $(CROSS_COMPILE)nm
STRIP          = $(AT) $(CROSS_COMPILE)strip
OBJCOPY        = $(AT) $(CROSS_COMPILE)objcopy
OBJDUMP        = $(AT) $(CROSS_COMPILE)objdump
NVCC           = $(AT) $(CUDA_PATH)/bin/nvcc -ccbin $(filter-out $(AT), $(CPP))

# Specify the logical root directory for headers and libraries.
ifneq ($(TARGET_ROOTFS),)
#CPPFLAGS += --sysroot=$(TARGET_ROOTFS)
#LDFLAGS += \
#	-Wl,-rpath-link=$(TARGET_ROOTFS)/lib/$(TEGRA_ARMABI) \
#	-Wl,-rpath-link=$(TARGET_ROOTFS)/usr/lib/$(TEGRA_ARMABI) \
#	-Wl,-rpath-link=$(TARGET_ROOTFS)/usr/lib/$(TEGRA_ARMABI)/tegra \
#	-Wl,-rpath-link=$(TARGET_ROOTFS)/$(CUDA_PATH)/lib64
endif

# All common header files
CPPFLAGS += -std=c++11 \
	-I"$(TOP_DIR)/include"

# All common dependent libraries
LDFLAGS += \
	-lpthread
