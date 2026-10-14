FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

EMB_PLUS_UBOOT_CFG = ""
EMB_PLUS_UBOOT_CFG:emb-plus-ve2302-amr = "file://emb-plus-amr.cfg"
EMB_PLUS_UBOOT_CFG:alveo-v80-amr = "file://alveo-amr.cfg"

SRC_URI += "${EMB_PLUS_UBOOT_CFG}"
