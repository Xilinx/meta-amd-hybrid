FILESEXTRAPATHS:append := ":${THISDIR}/u-boot-xlnx-scr"

SRC_URI:append:emb-plus-ve2302-amr = " file://boot.cmd.emb-plus"
UBOOT_XLNX_BOOT_SCR:emb-plus-ve2302-amr = "boot.cmd.emb-plus"

SRC_URI:append:alveo-v80-amr = " file://boot.cmd.emb-plus"
UBOOT_XLNX_BOOT_SCR:alveo-v80-amr = "boot.cmd.emb-plus"

