#  File: Makefile
#
#  Copyright 2014-2022 NXP
#
#  NXP CONFIDENTIAL
#  The source code contained or described herein and all documents related to
#  the source code (Materials) are owned by NXP, its
#  suppliers and/or its licensors. Title to the Materials remains with NXP,
#  its suppliers and/or its licensors. The Materials contain
#  trade secrets and proprietary and confidential information of NXP, its
#  suppliers and/or its licensors. The Materials are protected by worldwide copyright
#  and trade secret laws and treaty provisions. No part of the Materials may be
#  used, copied, reproduced, modified, published, uploaded, posted,
#  transmitted, distributed, or disclosed in any way without NXP's prior
#  express written permission.
#
#  No license under any patent, copyright, trade secret or other intellectual
#  property right is granted to or conferred upon you by disclosure or delivery
#  of the Materials, either expressly, by implication, inducement, estoppel or
#  otherwise. Any license under such intellectual property rights must be
#  express and approved by NXP in writing.
#
#  Alternatively, this software may be distributed under the terms of GPL v2.
#  SPDX-License-Identifier:    GPL-2.0
#

CONFIG_COMPATDIR=n
ifeq ($(CONFIG_COMPATDIR), y)
COMPATDIR=/lib/modules/$(KERNELVERSION_X86)/build/compat-wireless-3.2-rc1-1/include
CC ?=		$(CROSS_COMPILE)gcc -I$(COMPATDIR)
else
CC ?=		$(CROSS_COMPILE)gcc -I$(COMPATDIR)
endif

LD ?=		$(CROSS_COMPILE)ld
BACKUP=		/root/backup
YMD=		`date +%Y%m%d%H%M`

#############################################################################
# Configuration Options
#############################################################################
# Multi-chipsets
CONFIG_SD8887=n
CONFIG_SD8897=n
CONFIG_USB8897=n
CONFIG_PCIE8897=n
CONFIG_SD8977=n
CONFIG_SD8978=n
CONFIG_USB8978=n
CONFIG_SD8997=y
CONFIG_USB8997=n
CONFIG_PCIE8997=n
CONFIG_SD8987=y
CONFIG_SD9097=n
CONFIG_SD9177=n
CONFIG_SD8801=n
CONFIG_USB8801=n
CONFIG_USB9097=n
CONFIG_PCIE9097=n
CONFIG_SD9098=n
CONFIG_USB9098=n
CONFIG_PCIE9098=n
CONFIG_SDNW62X=n
CONFIG_PCIENW62X=n
CONFIG_USBNW62X=n


# Debug Option
# DEBUG LEVEL n/1/2:
# n: NO DEBUG
# 1: Only PRINTM(MMSG,...), PRINTM(MFATAL,...), ...
# 2: All PRINTM()
CONFIG_DEBUG=1

# Enable STA mode support
CONFIG_STA_SUPPORT=y

# Enable uAP mode support
CONFIG_UAP_SUPPORT=y

# Enable WIFIDIRECT support
CONFIG_WIFI_DIRECT_SUPPORT=y


# Re-association in driver
CONFIG_REASSOCIATION=y


# Manufacturing firmware support
CONFIG_MFG_CMD_SUPPORT=y

# OpenWrt support
CONFIG_OPENWRT_SUPPORT=n

# Big-endian platform
CONFIG_BIG_ENDIAN=n

#ifdef EMBEDDED_AUTH
# Enable driver based authenticator
CONFIG_DRV_EMBEDDED_AUTHENTICATOR=n
#endif

#ifdef EMBEDDED_SUPP
# Enable driver based supplicant
CONFIG_DRV_EMBEDDED_SUPPLICANT=n
#endif

ifeq ($(CONFIG_DRV_EMBEDDED_SUPPLICANT), y)
CONFIG_EMBEDDED_SUPP_AUTH=y
else
ifeq ($(CONFIG_DRV_EMBEDDED_AUTHENTICATOR), y)
CONFIG_EMBEDDED_SUPP_AUTH=y
endif
endif

#ifdef SDIO_MMC
# SDIO suspend/resume
CONFIG_SDIO_SUSPEND_RESUME=y
#endif

# DFS testing support
CONFIG_DFS_TESTING_SUPPORT=y

# Multi-channel support
CONFIG_MULTI_CHAN_SUPPORT=y




#32bit app over 64bit kernel support
CONFIG_USERSPACE_32BIT_OVER_KERNEL_64BIT=n


#############################################################################
# Select Platform Tools
#############################################################################

MODEXT = ko
ccflags-y += -I$(PWD)/mlan
ccflags-y += -DLINUX



#if defined(EMBEDDED_SUPP) || defined(EMBEDDED_AUTH)
ifeq ($(CONFIG_EMBEDDED_SUPP_AUTH), y)
ccflags-y += -I$(M)/mlan/esa
ccflags-y += -I$(M)/mlan/esa/common
endif
#endif



ARCH ?= arm64
CONFIG_IMX_SUPPORT=y
ifeq ($(CONFIG_IMX_SUPPORT),y)
ccflags-y += -DIMX_SUPPORT
ifneq ($(ANDROID_PRODUCT_OUT),)
ccflags-y += -DIMX_ANDROID
CONFIG_ANDROID_KERNEL=y
endif
endif
#KERNELDIR ?= /usr/src/arm/linux_5_10_y_kernel/linux-nxp
#CROSS_COMPILE ?= /opt/fsl-imx-internal-xwayland/5.10-gatesgarth/sysroots/x86_64-pokysdk-linux/usr/bin/aarch64-poky-linux/aarch64-poky-linux-

LD += -S

BINDIR = ../bin_wlan
APPDIR= $(shell if test -d "mapp"; then echo mapp; fi)

#############################################################################
# Compiler Flags
#############################################################################

	ccflags-y += -I$(KERNELDIR)/include

	ccflags-y += -DFPNUM='"92"'

ifeq ($(CONFIG_DEBUG),1)
	ccflags-y += -DDEBUG_LEVEL1
endif

ifeq ($(CONFIG_DEBUG),2)
	ccflags-y += -DDEBUG_LEVEL1
	ccflags-y += -DDEBUG_LEVEL2
	DBG=	-dbg
endif

ifeq ($(CONFIG_64BIT), y)
	ccflags-y += -DMLAN_64BIT
endif

ifeq ($(CONFIG_STA_SUPPORT),y)
	ccflags-y += -DSTA_SUPPORT
ifeq ($(CONFIG_REASSOCIATION),y)
	ccflags-y += -DREASSOCIATION
endif
else
CONFIG_WIFI_DIRECT_SUPPORT=n
CONFIG_STA_WEXT=n
CONFIG_STA_CFG80211=n
endif

ifeq ($(CONFIG_UAP_SUPPORT),y)
	ccflags-y += -DUAP_SUPPORT
else
CONFIG_WIFI_DIRECT_SUPPORT=n
CONFIG_UAP_WEXT=n
CONFIG_UAP_CFG80211=n
endif

ifeq ($(CONFIG_WIFI_DIRECT_SUPPORT),y)
	ccflags-y += -DWIFI_DIRECT_SUPPORT
endif

ifeq ($(CONFIG_MFG_CMD_SUPPORT),y)
	ccflags-y += -DMFG_CMD_SUPPORT
endif

ifeq ($(CONFIG_BIG_ENDIAN),y)
	ccflags-y += -DBIG_ENDIAN_SUPPORT
endif

ifeq ($(CONFIG_USERSPACE_32BIT_OVER_KERNEL_64BIT),y)
	ccflags-y += -DUSERSPACE_32BIT_OVER_KERNEL_64BIT
endif

#ifdef SDIO_MMC
ifeq ($(CONFIG_SDIO_SUSPEND_RESUME),y)
	ccflags-y += -DSDIO_SUSPEND_RESUME
endif
#endif

ifeq ($(CONFIG_MULTI_CHAN_SUPPORT),y)
	ccflags-y += -DMULTI_CHAN_SUPPORT
endif

ifeq ($(CONFIG_DFS_TESTING_SUPPORT),y)
	ccflags-y += -DDFS_TESTING_SUPPORT
endif


ifeq ($(CONFIG_ANDROID_KERNEL), y)
	ccflags-y += -DANDROID_KERNEL
endif

ifeq ($(CONFIG_OPENWRT_SUPPORT), y)
	ccflags-y += -DOPENWRT
endif

ifeq ($(CONFIG_T50), y)
	ccflags-y += -DT50
	ccflags-y += -DT40
	ccflags-y += -DT3T
endif

ifeq ($(CONFIG_SD8887),y)
	CONFIG_SDIO=y
	ccflags-y += -DSD8887
endif
ifeq ($(CONFIG_SD8897),y)
	CONFIG_SDIO=y
	ccflags-y += -DSD8897
endif
ifeq ($(CONFIG_SD8977),y)
	CONFIG_SDIO=y
	ccflags-y += -DSD8977
endif
ifeq ($(CONFIG_SD8978),y)
	CONFIG_SDIO=y
	ccflags-y += -DSD8978
endif
ifeq ($(CONFIG_SD8997),y)
	CONFIG_SDIO=y
	ccflags-y += -DSD8997
endif
ifeq ($(CONFIG_SD8987),y)
	CONFIG_SDIO=y
	ccflags-y += -DSD8987
endif
ifeq ($(CONFIG_SD9097),y)
	CONFIG_SDIO=y
	ccflags-y += -DSD9097
endif
ifeq ($(CONFIG_SDNW62X),y)
	CONFIG_SDIO=y
	ccflags-y += -DSDNW62X
endif
ifeq ($(CONFIG_SD9177),y)
	CONFIG_SDIO=y
	ccflags-y += -DSD9177
endif
ifeq ($(CONFIG_SD8801),y)
	CONFIG_SDIO=y
	ccflags-y += -DSD8801
endif
ifeq ($(CONFIG_SD9098),y)
	CONFIG_SDIO=y
	ccflags-y += -DSD9098
endif
ifeq ($(CONFIG_USB8801),y)
	CONFIG_MUSB=y
	ccflags-y += -DUSB8801
endif
ifeq ($(CONFIG_USB8897),y)
	CONFIG_MUSB=y
	ccflags-y += -DUSB8897
endif
ifeq ($(CONFIG_USB8997),y)
	CONFIG_MUSB=y
	ccflags-y += -DUSB8997
endif
ifeq ($(CONFIG_USB8978),y)
	CONFIG_MUSB=y
	ccflags-y += -DUSB8978
endif
ifeq ($(CONFIG_USB9097),y)
	CONFIG_MUSB=y
	ccflags-y += -DUSB9097
endif
ifeq ($(CONFIG_USBNW62X),y)
	CONFIG_MUSB=y
	ccflags-y += -DUSBNW62X
endif
ifeq ($(CONFIG_USB9098),y)
	CONFIG_MUSB=y
	ccflags-y += -DUSB9098
endif
ifeq ($(CONFIG_PCIE8897),y)
	CONFIG_PCIE=y
	ccflags-y += -DPCIE8897
endif
ifeq ($(CONFIG_PCIE8997),y)
	CONFIG_PCIE=y
	ccflags-y += -DPCIE8997
endif
ifeq ($(CONFIG_PCIE9097),y)
	CONFIG_PCIE=y
	ccflags-y += -DPCIE9097
endif
ifeq ($(CONFIG_PCIE9098),y)
	CONFIG_PCIE=y
	ccflags-y += -DPCIE9098
endif
ifeq ($(CONFIG_PCIENW62X),y)
	CONFIG_PCIE=y
	ccflags-y += -DPCIENW62X
endif
ifeq ($(CONFIG_SDIO),y)
	ccflags-y += -DSDIO
	ccflags-y += -DSDIO_MMC
endif
ifeq ($(CONFIG_MUSB),y)
	ccflags-y += -DUSB
endif
ifeq ($(CONFIG_PCIE),y)
	ccflags-y += -DPCIE
endif

ifeq ($(CONFIG_MAC80211_SUPPORT),y)
	ccflags-y += -DMAC80211_SUPPORT
endif
ifeq ($(CONFIG_MAC80211_SUPPORT_UAP),y)
	ccflags-y += -DMAC80211_SUPPORT_UAP
endif
ifeq ($(CONFIG_MAC80211_SUPPORT_MESH),y)
	ccflags-y += -DMAC80211_SUPPORT_MESH
endif

# add -Wno-packed-bitfield-compat when GCC version greater than 4.4
GCC_VERSION := $(shell echo `gcc -dumpversion | cut -f1-2 -d.` \>= 4.4 | sed -e 's/\./*100+/g' | bc )
ifeq ($(GCC_VERSION),1)
	ccflags-y += -Wno-packed-bitfield-compat
endif
WimpGCC_VERSION := $(shell echo `gcc -dumpversion | cut -f1 -d.`| bc )
ifeq ($(shell test $(WimpGCC_VERSION) -ge 7; echo $$?),0)
ccflags-y += -Wimplicit-fallthrough=3
endif
#ccflags-y += -Wunused-but-set-variable
#ccflags-y += -Wmissing-prototypes
#ccflags-y += -Wold-style-definition
#ccflags-y += -Wtype-limits
#ccflags-y += -Wsuggest-attribute=format
#ccflags-y += -Wmissing-include-dirs
#ccflags-y += -Wshadow
#ccflags-y += -Wsign-compare
#ccflags-y += -Wunused-macros
#ccflags-y += -Wmissing-field-initializers
#ccflags-y += -Wstringop-truncation
#ccflags-y += -Wmisleading-indentation
#ccflags-y += -Wunused-const-variable
#############################################################################
# Make Targets
#############################################################################

ifneq ($(KERNELRELEASE),)

ifeq ($(CONFIG_WIRELESS_EXT),y)
ifeq ($(CONFIG_WEXT_PRIV),y)
	# Enable WEXT for STA
	CONFIG_STA_WEXT=y
	# Enable WEXT for uAP
	CONFIG_UAP_WEXT=y
else
# Disable WEXT for STA
	CONFIG_STA_WEXT=n
# Disable WEXT for uAP
	CONFIG_UAP_WEXT=n
endif
endif

# Enable CFG80211 for STA
ifeq ($(CONFIG_CFG80211),y)
	CONFIG_STA_CFG80211=y
else
ifeq ($(CONFIG_CFG80211),m)
	CONFIG_STA_CFG80211=y
else
	CONFIG_STA_CFG80211=n
endif
endif

# OpenWrt
ifeq ($(CONFIG_OPENWRT_SUPPORT), y)
ifeq ($(CPTCFG_CFG80211),y)
	CONFIG_STA_CFG80211=y
else
ifeq ($(CPTCFG_CFG80211),m)
	CONFIG_STA_CFG80211=y
else
	CONFIG_STA_CFG80211=n
endif
endif
endif

# Enable CFG80211 for uAP
ifeq ($(CONFIG_CFG80211),y)
	CONFIG_UAP_CFG80211=y
else
ifeq ($(CONFIG_CFG80211),m)
	CONFIG_UAP_CFG80211=y
else
	CONFIG_UAP_CFG80211=n
endif
endif

# OpenWrt
ifeq ($(CONFIG_OPENWRT_SUPPORT), y)
ifeq ($(CPTCFG_CFG80211),y)
	CONFIG_STA_CFG80211=y
else
ifeq ($(CPTCFG_CFG80211),m)
	CONFIG_STA_CFG80211=y
else
	CONFIG_STA_CFG80211=n
endif
endif
endif

ifneq ($(CONFIG_STA_SUPPORT),y)
	CONFIG_WIFI_DIRECT_SUPPORT=n
	CONFIG_STA_WEXT=n
	CONFIG_STA_CFG80211=n
endif

ifneq ($(CONFIG_UAP_SUPPORT),y)
	CONFIG_WIFI_DIRECT_SUPPORT=n
	CONFIG_UAP_WEXT=n
	CONFIG_UAP_CFG80211=n
endif

ifeq ($(CONFIG_STA_SUPPORT),y)
ifeq ($(CONFIG_STA_WEXT),y)
	ccflags-y += -DSTA_WEXT
endif
ifeq ($(CONFIG_STA_CFG80211),y)
	ccflags-y += -DSTA_CFG80211
endif
endif
ifeq ($(CONFIG_UAP_SUPPORT),y)
ifeq ($(CONFIG_UAP_WEXT),y)
	ccflags-y += -DUAP_WEXT
endif
ifeq ($(CONFIG_UAP_CFG80211),y)
	ccflags-y += -DUAP_CFG80211
endif
endif

print:
ifeq ($(CONFIG_STA_SUPPORT),y)
ifeq ($(CONFIG_STA_WEXT),n)
ifeq ($(CONFIG_STA_CFG80211),n)
	@echo "Can not build STA without WEXT or CFG80211"
	exit 2
endif
endif
endif
ifeq ($(CONFIG_UAP_SUPPORT),y)
ifeq ($(CONFIG_UAP_WEXT),n)
ifeq ($(CONFIG_UAP_CFG80211),n)
	@echo "Can not build UAP without WEXT or CFG80211"
	exit 2
endif
endif
endif


#ifdef EMBEDDED_AUTH
ifeq ($(CONFIG_DRV_EMBEDDED_AUTHENTICATOR), y)
    ccflags-y += -DDRV_EMBEDDED_AUTHENTICATOR
endif
#endif

#ifdef EMBEDDED_SUPP
ifeq ($(CONFIG_DRV_EMBEDDED_SUPPLICANT), y)
    ccflags-y += -DDRV_EMBEDDED_SUPPLICANT
endif
#endif


MOALOBJS =	mlinux/moal_main.o \
		mlinux/moal_ioctl.o \
		mlinux/moal_shim.o \
		mlinux/moal_eth_ioctl.o \
		mlinux/moal_init.o

MLANOBJS =	mlan/mlan_shim.o mlan/mlan_init.o \
		mlan/mlan_txrx.o \
		mlan/mlan_cmdevt.o mlan/mlan_misc.o \
		mlan/mlan_cfp.o \
		mlan/mlan_module.o

MLANOBJS += mlan/mlan_wmm.o
ifeq ($(CONFIG_MUSB),y)
MLANOBJS += mlan/mlan_usb.o
endif
ifeq ($(CONFIG_SDIO),y)
MLANOBJS += mlan/mlan_sdio.o
endif
ifeq ($(CONFIG_PCIE),y)
MLANOBJS += mlan/mlan_pcie.o
endif
MLANOBJS += mlan/mlan_11n_aggr.o
MLANOBJS += mlan/mlan_11n_rxreorder.o
MLANOBJS += mlan/mlan_11n.o
MLANOBJS += mlan/mlan_11ac.o
MLANOBJS += mlan/mlan_11ax.o
MLANOBJS += mlan/mlan_11d.o
MLANOBJS += mlan/mlan_11h.o
ifeq ($(CONFIG_STA_SUPPORT),y)
MLANOBJS += mlan/mlan_meas.o
MLANOBJS += mlan/mlan_scan.o \
			mlan/mlan_sta_ioctl.o \
			mlan/mlan_sta_rx.o \
			mlan/mlan_sta_tx.o \
			mlan/mlan_sta_event.o \
			mlan/mlan_sta_cmd.o \
			mlan/mlan_sta_cmdresp.o \
			mlan/mlan_join.o
ifeq ($(CONFIG_STA_WEXT),y)
MOALOBJS += mlinux/moal_priv.o \
            mlinux/moal_wext.o
endif
endif
ifeq ($(CONFIG_UAP_SUPPORT),y)
MLANOBJS += mlan/mlan_uap_ioctl.o
MLANOBJS += mlan/mlan_uap_cmdevent.o
MLANOBJS += mlan/mlan_uap_txrx.o
MOALOBJS += mlinux/moal_uap.o
ifeq ($(CONFIG_UAP_WEXT),y)
MOALOBJS += mlinux/moal_uap_priv.o
MOALOBJS += mlinux/moal_uap_wext.o
endif
endif
ifeq ($(CONFIG_STA_CFG80211),y)
MOALOBJS += mlinux/moal_cfg80211.o
MOALOBJS += mlinux/moal_cfg80211_util.o
MOALOBJS += mlinux/moal_sta_cfg80211.o
endif
ifeq ($(CONFIG_UAP_CFG80211),y)
MOALOBJS += mlinux/moal_cfg80211.o
MOALOBJS += mlinux/moal_cfg80211_util.o
MOALOBJS += mlinux/moal_uap_cfg80211.o
endif

ifdef CONFIG_PROC_FS
MOALOBJS += mlinux/moal_proc.o
MOALOBJS += mlinux/moal_debug.o
endif

ifeq ($(CONFIG_MAC80211_SUPPORT),y)
MOALOBJS += mlinux/moal_mac80211.o
MLANOBJS += mlan/mlan_mac80211.o
endif



#if defined(EMBEDDED_SUPP) || defined(EMBEDDED_AUTH)
ifeq ($(CONFIG_EMBEDDED_SUPP_AUTH), y)
MLANOBJS += mlan/esa/common/crypto_api.o \
			mlan/esa/common/aes_cmac_rom.o \
			mlan/esa/common/crypt_new_rom.o \
			mlan/esa/common/pmkCache.o \
			mlan/esa/common/pmkCache_rom.o \
			mlan/esa/common/parser.o \
			mlan/esa/common/parser_rom.o \
			mlan/esa/keyMgmtApStaCommon.o \
			mlan/esa/hostsa_init.o \
			mlan/esa/authenticator_api.o
endif
#endif


#ifdef EMBEDDED_SUPP
ifeq ($(CONFIG_DRV_EMBEDDED_SUPPLICANT),y)
MLANOBJS += mlan/esa/keyMgmtSta.o \
			mlan/esa/keyMgmtSta_rom.o \
			mlan/esa/supplicant.o
endif
#endif

#ifdef EMBEDDED_AUTH
ifeq ($(CONFIG_DRV_EMBEDDED_AUTHENTICATOR),y)
MLANOBJS += mlan/esa/AssocAp_srv_rom.o \
			mlan/esa/keyMgmtAp_rom.o \
			mlan/esa/keyMgmtAp.o
endif
#endif

obj-m := mlan.o
mlan-objs := $(MLANOBJS)

ifeq ($(CONFIG_MUSB),y)
MOALOBJS += mlinux/moal_usb.o
endif
ifeq ($(CONFIG_SDIO),y)
MOALOBJS += mlinux/moal_sdio_mmc.o
endif
ifeq ($(CONFIG_PCIE),y)
MOALOBJS += mlinux/moal_pcie.o
endif
obj-m += moal.o
moal-objs := $(MOALOBJS)

# Otherwise we were called directly from the command line; invoke the kernel build system.
else

default:
	$(MAKE) -C $(KERNEL_DIR) M=$(PWD)  modules

endif

###############################################################

export		CC LD ccflags-y KERNELDIR

ifeq ($(CONFIG_STA_SUPPORT),y)
ifeq ($(CONFIG_UAP_SUPPORT),y)
.PHONY: mapp/mlanconfig mapp/mlan2040coex mapp/mlanevent mapp/uaputl mapp/mlanutl clean distclean
else
.PHONY: mapp/mlanconfig mapp/mlanevent mapp/mlan2040coex mapp/mlanutl clean distclean
endif
else
ifeq ($(CONFIG_UAP_SUPPORT),y)
.PHONY: mapp/mlanevent mapp/uaputl clean distclean
endif
endif
	@echo "Finished Making NXP Wlan Linux Driver"

ifeq ($(CONFIG_STA_SUPPORT),y)
mapp/mlanconfig:
	$(MAKE) -C $@
mapp/mlanutl:
	$(MAKE) -C $@
mapp/mlan2040coex:
	$(MAKE) -C $@
endif
ifeq ($(CONFIG_UAP_SUPPORT),y)
mapp/uaputl:
	$(MAKE) -C $@
endif
ifeq ($(CONFIG_WIFI_DIRECT_SUPPORT),y)
mapp/wifidirectutl:
	$(MAKE) -C $@
endif
mapp/mlanevent:
	$(MAKE) -C $@

echo:

appsbuild:

	@if [ ! -d $(BINDIR) ]; then \
		mkdir $(BINDIR); \
	fi

ifeq ($(CONFIG_STA_SUPPORT),y)
	cp -f README $(BINDIR)
	cp -f README_MLAN $(BINDIR)
	cp -f README_RBC $(BINDIR)
ifneq ($(APPDIR),)
	$(MAKE) -C mapp/mlanconfig $@ INSTALLDIR=$(BINDIR)
	$(MAKE) -C mapp/mlanutl $@ INSTALLDIR=$(BINDIR)
	$(MAKE) -C mapp/mlan2040coex $@ INSTALLDIR=$(BINDIR)
endif
endif
ifeq ($(CONFIG_UAP_SUPPORT),y)
	cp -f README_UAP $(BINDIR)
ifneq ($(APPDIR),)
	$(MAKE) -C mapp/uaputl $@ INSTALLDIR=$(BINDIR)
endif
endif
ifeq ($(CONFIG_WIFI_DIRECT_SUPPORT),y)
	cp -f README_WIFIDIRECT $(BINDIR)
	cp -rpf script/wifidirect $(BINDIR)
ifneq ($(APPDIR),)
	$(MAKE) -C mapp/wifidirectutl $@ INSTALLDIR=$(BINDIR)
endif
endif
ifneq ($(APPDIR),)
	$(MAKE) -C mapp/mlanevent $@ INSTALLDIR=$(BINDIR)
endif

build:		echo default

	@if [ ! -d $(BINDIR) ]; then \
		mkdir $(BINDIR); \
	fi

	cp -f mlan.$(MODEXT) $(BINDIR)/mlan$(DBG).$(MODEXT)

	cp -f moal.$(MODEXT) $(BINDIR)/moal$(DBG).$(MODEXT)
	cp -rpf script/load $(BINDIR)/
	cp -rpf script/unload $(BINDIR)/

ifeq ($(CONFIG_STA_SUPPORT),y)
	cp -f README $(BINDIR)
	cp -f README_MLAN $(BINDIR)
	cp -f README_RBC $(BINDIR)
ifneq ($(APPDIR),)
	$(MAKE) -C mapp/mlanconfig $@ INSTALLDIR=$(BINDIR)
	$(MAKE) -C mapp/mlanutl $@ INSTALLDIR=$(BINDIR)
	$(MAKE) -C mapp/mlan2040coex $@ INSTALLDIR=$(BINDIR)
endif
endif
ifeq ($(CONFIG_UAP_SUPPORT),y)
	cp -f README_UAP $(BINDIR)
ifneq ($(APPDIR),)
	$(MAKE) -C mapp/uaputl $@ INSTALLDIR=$(BINDIR)
endif
endif
ifeq ($(CONFIG_WIFI_DIRECT_SUPPORT),y)
	cp -f README_WIFIDIRECT $(BINDIR)
	cp -rpf script/wifidirect $(BINDIR)
ifneq ($(APPDIR),)
	$(MAKE) -C mapp/wifidirectutl $@ INSTALLDIR=$(BINDIR)
endif
endif
ifneq ($(APPDIR),)
	$(MAKE) -C mapp/mlanevent $@ INSTALLDIR=$(BINDIR)
endif

clean:
	-find . -name "*.o" -exec rm {} \;
	-find . -name "*.ko" -exec rm {} \;
	-find . -name ".*.cmd" -exec rm {} \;
	-find . -name "*.mod.c" -exec rm {} \;
	-find . -name "Module.symvers" -exec rm {} \;
	-find . -name "Module.markers" -exec rm {} \;
	-find . -name "modules.order" -exec rm {} \;
	-find . -name ".*.dwo" -exec rm {} \;
	-find . -name "*dwo" -exec rm {} \;
	-rm -rf .tmp_versions
ifneq ($(APPDIR),)
ifeq ($(CONFIG_STA_SUPPORT),y)
	$(MAKE) -C mapp/mlanconfig $@
	$(MAKE) -C mapp/mlanutl $@
	$(MAKE) -C mapp/mlan2040coex $@
endif
ifeq ($(CONFIG_UAP_SUPPORT),y)
	$(MAKE) -C mapp/uaputl $@
endif
ifeq ($(CONFIG_WIFI_DIRECT_SUPPORT),y)
	$(MAKE) -C mapp/wifidirectutl $@
endif
	$(MAKE) -C mapp/mlanevent $@
endif
#ifdef SDIO
#endif // SDIO

install: default

	cp -f mlan.$(MODEXT) $(INSTALLDIR)/mlan$(DBG).$(MODEXT)
	cp -f moal.$(MODEXT) $(INSTALLDIR)/moal$(DBG).$(MODEXT)
	echo $(INSTALLDIR)
	echo "MX Driver Installed"

distclean:
	-find . -name "*.o" -exec rm {} \;
	-find . -name "*.orig" -exec rm {} \;
	-find . -name "*.swp" -exec rm {} \;
	-find . -name "*.*~" -exec rm {} \;
	-find . -name "*~" -exec rm {} \;
	-find . -name "*.d" -exec rm {} \;
	-find . -name "*.a" -exec rm {} \;
	-find . -name "tags" -exec rm {} \;
	-find . -name ".*" -exec rm -rf 2> /dev/null \;
	-find . -name "*.ko" -exec rm {} \;
	-find . -name ".*.cmd" -exec rm {} \;
	-find . -name "*.mod.c" -exec rm {} \;
	-find . -name ".*.dwo" -exec rm {} \;
	-find . -name "*dwo" -exec rm {} \;
	-rm -rf .tmp_versions
ifneq ($(APPDIR),)
ifeq ($(CONFIG_STA_SUPPORT),y)
	$(MAKE) -C mapp/mlanconfig $@
	$(MAKE) -C mapp/mlanutl $@
	$(MAKE) -C mapp/mlan2040coex $@
endif
ifeq ($(CONFIG_UAP_SUPPORT),y)
	$(MAKE) -C mapp/uaputl $@
endif
ifeq ($(CONFIG_WIFI_DIRECT_SUPPORT),y)
	$(MAKE) -C mapp/wifidirectutl $@
endif
	$(MAKE) -C mapp/mlanevent $@
endif

# End of file
