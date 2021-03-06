
# Required CM packages
PRODUCT_PACKAGES += \
    LatinIME

# Include CM LatinIME dictionaries
PRODUCT_PACKAGE_OVERLAYS += vendor/cm/overlay/dictionaries

# Default notification/alarm sounds
PRODUCT_PROPERTY_OVERRIDES += \
    ro.config.notification_sound=Argon.ogg \
    ro.config.alarm_alert=Helium.ogg

ifeq ($(TARGET_SCREEN_WIDTH) $(TARGET_SCREEN_HEIGHT),$(space))
    PRODUCT_COPY_FILES += \
        vendor/cm/prebuilt/common/bootanimation/480.zip:system/media/bootanimation.zip
endif

# World APN list
PRODUCT_COPY_FILES += \
    vendor/cm/prebuilt/common/etc/apns-conf.xml:system/etc/apns-conf.xml

# Selective SPN list for operator number who has the problem.
PRODUCT_COPY_FILES += \
    vendor/cm/prebuilt/common/etc/selective-spn-conf.xml:system/etc/selective-spn-conf.xml

# Telephony packages
PRODUCT_PACKAGES += \
    Mms \
    Stk \
    CellBroadcastReceiver

# Mms depends on SoundRecorder for recorded audio messages
PRODUCT_PACKAGES += \
    SoundRecorder

# Default ringtone
PRODUCT_PROPERTY_OVERRIDES += \
    ro.config.ringtone=Orion.ogg

PRODUCT_COPY_FILES += \
    vendor/cm/config/permissions/com.cyanogenmod.nfc.enhanced.xml:system/etc/permissions/com.cyanogenmod.nfc.enhanced.xml

#
# CyanogenMod Audio Files
#

ALARM_PATH := vendor/cm/prebuilt/common/media/audio/alarms
NOTIFICATION_PATH := vendor/cm/prebuilt/common/media/audio/notifications
RINGTONE_PATH := vendor/cm/prebuilt/common/media/audio/ringtones
UI_PATH := vendor/cm/prebuilt/common/media/audio/ui

# Alarms
PRODUCT_COPY_FILES += \
	$(ALARM_PATH)/CyanAlarm.ogg:system/media/audio/alarms/CyanAlarm.ogg \
	$(ALARM_PATH)/NuclearLaunch.ogg:system/media/audio/alarms/NuclearLaunch.ogg

# Notifications
PRODUCT_COPY_FILES += \
	$(NOTIFICATION_PATH)/CyanDoink.ogg:system/media/audio/notifications/CyanDoink.ogg \
	$(NOTIFICATION_PATH)/CyanMail.ogg:system/media/audio/notifications/CyanMail.ogg \
	$(NOTIFICATION_PATH)/CyanMessage.ogg:system/media/audio/notifications/CyanMessage.ogg \
	$(NOTIFICATION_PATH)/Laser.ogg:system/media/audio/notifications/Laser.ogg \
	$(NOTIFICATION_PATH)/Naughty.ogg:system/media/audio/notifications/Naughty.ogg \
	$(NOTIFICATION_PATH)/Pong.ogg:system/media/audio/notifications/Pong.ogg \
	$(NOTIFICATION_PATH)/Rang.ogg:system/media/audio/notifications/Rang.ogg \
	$(NOTIFICATION_PATH)/Stone.ogg:system/media/audio/notifications/Stone.ogg

# Ringtones
ifeq ($(TARGET_NEEDS_BOOSTED_SOUNDS),true)
PRODUCT_COPY_FILES += \
	$(RINGTONE_PATH)/boosted/Boxbeat.ogg:system/media/audio/ringtones/Boxbeat.ogg \
	$(RINGTONE_PATH)/boosted/CyanTone.ogg:system/media/audio/ringtones/CyanTone.ogg \
	$(RINGTONE_PATH)/boosted/Highscore.ogg:system/media/audio/ringtones/Highscore.ogg \
	$(RINGTONE_PATH)/boosted/Lyon.ogg:system/media/audio/ringtones/Lyon.ogg \
	$(RINGTONE_PATH)/boosted/Rockin.ogg:system/media/audio/ringtones/Rockin.ogg
else
PRODUCT_COPY_FILES += \
	$(RINGTONE_PATH)/Boxbeat.ogg:system/media/audio/ringtones/Boxbeat.ogg \
	$(RINGTONE_PATH)/CyanTone.ogg:system/media/audio/ringtones/CyanTone.ogg \
	$(RINGTONE_PATH)/Highscore.ogg:system/media/audio/ringtones/Highscore.ogg \
	$(RINGTONE_PATH)/Lyon.ogg:system/media/audio/ringtones/Lyon.ogg \
	$(RINGTONE_PATH)/Rockin.ogg:system/media/audio/ringtones/Rockin.ogg \
	$(RINGTONE_PATH)/Sheep.mp3:system/media/audio/ringtones/Sheep.mp3
endif

# Optional CM packages
PRODUCT_PACKAGES += \
    Galaxy4 \
    HoloSpiralWallpaper \
    LiveWallpapers \
    LiveWallpapersPicker \
    MagicSmokeWallpapers \
    NoiseField \
    PhaseBeam \
    VisualizationWallpapers \
    PhotoTable \
    SoundRecorder \
    PhotoPhase

# Extra tools in CM
PRODUCT_PACKAGES += \
    vim \
    zip \
    unrar \
    curl

PRODUCT_BRAND ?= stayboogy

ifneq ($(TARGET_SCREEN_WIDTH) $(TARGET_SCREEN_HEIGHT),$(space))
# determine the smaller dimension
TARGET_BOOTANIMATION_SIZE := $(shell \
  if [ $(TARGET_SCREEN_WIDTH) -lt $(TARGET_SCREEN_HEIGHT) ]; then \
    echo $(TARGET_SCREEN_WIDTH); \
  else \
    echo $(TARGET_SCREEN_HEIGHT); \
  fi )

# get a sorted list of the sizes
bootanimation_sizes := $(subst .zip,, $(shell ls vendor/cm/prebuilt/common/bootanimation))
bootanimation_sizes := $(shell echo -e $(subst $(space),'\n',$(bootanimation_sizes)) | sort -rn)

# find the appropriate size and set
define check_and_set_bootanimation
$(eval TARGET_BOOTANIMATION_NAME := $(shell \
  if [ -z "$(TARGET_BOOTANIMATION_NAME)" ]; then
    if [ $(1) -le $(TARGET_BOOTANIMATION_SIZE) ]; then \
      echo $(1); \
      exit 0; \
    fi;
  fi;
  echo $(TARGET_BOOTANIMATION_NAME); ))
endef
$(foreach size,$(bootanimation_sizes), $(call check_and_set_bootanimation,$(size)))

ifeq ($(TARGET_BOOTANIMATION_HALF_RES),true)
PRODUCT_BOOTANIMATION := vendor/cm/prebuilt/common/bootanimation/halfres/$(TARGET_BOOTANIMATION_NAME).zip
else
PRODUCT_BOOTANIMATION := vendor/cm/prebuilt/common/bootanimation/$(TARGET_BOOTANIMATION_NAME).zip
endif
endif

PRODUCT_PROPERTY_OVERRIDES += \
    ro.rommanager.developerid=stayboogy

PRODUCT_BUILD_PROP_OVERRIDES += BUILD_UTC_DATE=0

ifeq ($(PRODUCT_GMS_CLIENTID_BASE),)
PRODUCT_PROPERTY_OVERRIDES += \
    ro.com.google.clientidbase=android-google
else
PRODUCT_PROPERTY_OVERRIDES += \
    ro.com.google.clientidbase=$(PRODUCT_GMS_CLIENTID_BASE)
endif

PRODUCT_PROPERTY_OVERRIDES += \
    keyguard.no_require_sim=true \
    ro.url.legal=http://www.google.com/intl/%s/mobile/android/basic/phone-legal.html \
    ro.url.legal.android_privacy=http://www.google.com/intl/%s/mobile/android/basic/privacy.html \
    ro.com.android.wifi-watchlist=GoogleGuest \
    ro.setupwizard.enterprise_mode=1 \
    ro.com.android.dateformat=MM-dd-yyyy \
    ro.com.android.dataroaming=false

PRODUCT_PROPERTY_OVERRIDES += \
    ro.build.selinux=1

ifneq ($(TARGET_BUILD_VARIANT),user)
# Thank you, please drive thru!
PRODUCT_PROPERTY_OVERRIDES += persist.sys.dun.override=0
endif

ADDITIONAL_DEFAULT_PROPERTIES += ro.adb.secure=1

# Copy over the changelog to the device
PRODUCT_COPY_FILES += \
    vendor/cm/CHANGELOG.mkdn:system/etc/CHANGELOG-CM.txt

# Backup Tool
ifneq ($(WITH_GMS),true)
PRODUCT_COPY_FILES += \
    vendor/cm/prebuilt/common/bin/backuptool.sh:install/bin/backuptool.sh \
    vendor/cm/prebuilt/common/bin/backuptool.functions:install/bin/backuptool.functions \
    vendor/cm/prebuilt/common/bin/50-cm.sh:system/addon.d/50-cm.sh \
    vendor/cm/prebuilt/common/bin/blacklist:system/addon.d/blacklist
endif

# Signature compatibility validation
PRODUCT_COPY_FILES += \
    vendor/cm/prebuilt/common/bin/otasigcheck.sh:install/bin/otasigcheck.sh

# init.d support
PRODUCT_COPY_FILES += \
    vendor/cm/prebuilt/common/etc/init.d/00banner:system/etc/init.d/00banner \
    vendor/cm/prebuilt/common/bin/sysinit:system/bin/sysinit

ifneq ($(TARGET_BUILD_VARIANT),user)
# userinit support
PRODUCT_COPY_FILES += \
    vendor/cm/prebuilt/common/etc/init.d/90userinit:system/etc/init.d/90userinit
endif

# CM-specific init file
PRODUCT_COPY_FILES += \
    vendor/cm/prebuilt/common/etc/init.local.rc:root/init.cm.rc

# Bring in camera effects
PRODUCT_COPY_FILES +=  \
    vendor/cm/prebuilt/common/media/LMprec_508.emd:system/media/LMprec_508.emd \
    vendor/cm/prebuilt/common/media/PFFprec_600.emd:system/media/PFFprec_600.emd

# Copy over added mimetype supported in libcore.net.MimeUtils
PRODUCT_COPY_FILES += \
    vendor/cm/prebuilt/common/lib/content-types.properties:system/lib/content-types.properties

# Enable SIP+VoIP on all targets
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.sip.voip.xml:system/etc/permissions/android.software.sip.voip.xml

# Enable wireless Xbox 360 controller support
PRODUCT_COPY_FILES += \
    frameworks/base/data/keyboards/Vendor_045e_Product_028e.kl:system/usr/keylayout/Vendor_045e_Product_0719.kl

# This is CM!
PRODUCT_COPY_FILES += \
    vendor/cm/config/permissions/com.cyanogenmod.android.xml:system/etc/permissions/com.cyanogenmod.android.xml

# Theme engine
PRODUCT_PACKAGES += \
    ThemeChooser \
    ThemesProvider

PRODUCT_COPY_FILES += \
    vendor/cm/config/permissions/org.cyanogenmod.theme.xml:system/etc/permissions/org.cyanogenmod.theme.xml

# Required CM packages
PRODUCT_PACKAGES += \
    Development \
    BluetoothExt \
    Profiles

# Optional CM packages
PRODUCT_PACKAGES += \
    VoicePlus \
    Basic \
    libemoji \
    Terminal

# Custom CM packages
PRODUCT_PACKAGES += \
    Launcher3 \
    Trebuchet \
    AudioFX \
    CMWallpapers \
    CMFileManager \
    Eleven \
    LockClock \
    CMHome \
    CyanogenSetupWizard \
    CMSettingsProvider

# CM Platform Library
PRODUCT_PACKAGES += \
    org.cyanogenmod.platform-res \
    org.cyanogenmod.platform \
    org.cyanogenmod.platform.xml

# CM Hardware Abstraction Framework
PRODUCT_PACKAGES += \
    org.cyanogenmod.hardware \
    org.cyanogenmod.hardware.xml

# Extra tools in CM
PRODUCT_PACKAGES += \
    libsepol \
    e2fsck \
    mke2fs \
    tune2fs \
    bash \
    nano \
    htop \
    powertop \
    lsof \
    mkfs.f2fs \
    fsck.f2fs \
    fibmap.f2fs \
    ntfsfix \
    ntfs-3g \
    gdbserver \
    micro_bench \
    oprofiled \
    sqlite3 \
    strace

WITH_EXFAT ?= true
ifeq ($(WITH_EXFAT),true)
TARGET_USES_EXFAT := true
PRODUCT_PACKAGES += \
    mount.exfat \
    fsck.exfat \
    mkfs.exfat
endif

# Openssh
PRODUCT_PACKAGES += \
    scp \
    sftp \
    ssh \
    sshd \
    sshd_config \
    ssh-keygen \
    start-ssh

# rsync
PRODUCT_PACKAGES += \
    rsync

# Stagefright FFMPEG plugin
PRODUCT_PACKAGES += \
    libffmpeg_extractor \
    libffmpeg_omx \
    media_codecs_ffmpeg.xml

PRODUCT_PROPERTY_OVERRIDES += \
    media.sf.omx-plugin=libffmpeg_omx.so \
    media.sf.extractor-plugin=libffmpeg_extractor.so

PRODUCT_PACKAGES += \
    procmem \
    procrank \
    su

PRODUCT_PROPERTY_OVERRIDES += \
    persist.sys.root_access=1

PRODUCT_PACKAGE_OVERLAYS += vendor/cm/overlay/common

PRODUCT_VERSION_MAJOR = 12
PRODUCT_VERSION_MINOR = 1
PRODUCT_VERSION_MAINTENANCE := stayboogy

CM_BUILDTYPE := UNOFFICIAL
CM_EXTRAVERSION :=.1.5-selinux

#CM_VERSION := $(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR).$(PRODUCT_VERSION_MAINTENANCE)-$(shell date -u +%Y%m%d)-$(CM_BUILDTYPE)$(CM_EXTRAVERSION)-$(CM_BUILD)
CM_VERSION := $(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR).$(PRODUCT_VERSION_MAINTENANCE)-$(CM_EXTRAVERSION)-$(shell date -u +%Y%m%d)

PRODUCT_PROPERTY_OVERRIDES += \
  ro.cm.version=$(CM_VERSION) \
  ro.cm.releasetype=$(CM_BUILDTYPE) \
  ro.modversion=$(PRODUCT_VERSION_MAINTENANCE) \
  ro.cmlegal.url=https://cyngn.com/legal/privacy-policy

-include vendor/cm-priv/keys/keys.mk

CM_DISPLAY_VERSION := $(CM_VERSION)

# by default, do not update the recovery with system updates
PRODUCT_PROPERTY_OVERRIDES += persist.sys.recovery_update=false

ifndef CM_PLATFORM_SDK_VERSION
  # This is the canonical definition of the SDK version, which defines
  # the set of APIs and functionality available in the platform.  It
  # is a single integer that increases monotonically as updates to
  # the SDK are released.  It should only be incremented when the APIs for
  # the new release are frozen (so that developers don't write apps against
  # intermediate builds).
  CM_PLATFORM_SDK_VERSION := 3
endif

ifndef CM_PLATFORM_REV
  # For internal SDK revisions that are hotfixed/patched
  # Reset after each CM_PLATFORM_SDK_VERSION release
  # If you are doing a release and this is NOT 0, you are almost certainly doing it wrong
  CM_PLATFORM_REV := 1
endif

PRODUCT_PROPERTY_OVERRIDES += \
  ro.cm.display.version=$(CM_DISPLAY_VERSION)

# CyanogenMod Platform SDK Version
PRODUCT_PROPERTY_OVERRIDES += \
  ro.cm.build.version.plat.sdk=$(CM_PLATFORM_SDK_VERSION)

# CyanogenMod Platform Internal
PRODUCT_PROPERTY_OVERRIDES += \
  ro.cm.build.version.plat.rev=$(CM_PLATFORM_REV)

-include $(WORKSPACE)/build_env/image-auto-bits.mk

-include vendor/cyngn/product.mk

$(call prepend-product-if-exists, vendor/extra/product.mk)
