BIF_FSBL_ATTR:emb-plus-ve2302-amr = "base-pdi"
BIF_AMC_ATTR:emb-plus-ve2302-amr = "amcfw"
BIF_FSBL_ATTR:alveo-v80-amr = "base-pdi"
BIF_AMC_ATTR:alveo-v80-amr = "amcfw"

# specify BIF partition attributes for AMC
BIF_PARTITION_ATTR[amcfw] = "core=r5-0"
BIF_PARTITION_IMAGE[amcfw] = "${DEPLOY_DIR_IMAGE}/amc-firmware-${MACHINE}.elf"
BIF_PARTITION_ID[amcfw] = "0x1c000006"
BIF_PARTITION_NAME[0x1c000006] = "amr_subsystem, delay_handoff"
BIF_PARTITION_ATTR:alveo-v80-amr = "${BIF_FSBL_ATTR} ${BIF_AMC_ATTR}"

BIF_PARTITION_ATTR:emb-plus-ve2302-amr = "${BIF_FSBL_ATTR} ${BIF_AMC_ATTR}"

ADDN_COMPILE_DEPENDS = ""
ADDN_COMPILE_DEPENDS:emb-plus-ve2302-amr = "amcfw:do_deploy"
ADDN_COMPILE_DEPENDS:alveo-v80-amr = "amcfw:do_deploy"

# Build hello-world for R5-1
HELLOWORLD_MCDEPENDS = ""
HELLOWORLD_MCDEPENDS:emb-plus-ve2302-amr = "mc::emb-plus-ve2302-amr-cortexr5-1-baremetal:hello-world:do_deploy"

do_compile[depends] += "${ADDN_COMPILE_DEPENDS}"
do_compile[mcdepends] += "${HELLOWORLD_MCDEPENDS}"

# Overlay CDO: merge AMR subsystem definitions into the base PDI
# before the main bootgen assembles BOOT.bin. The design BIF from
# SDT artifacts references CDO files via relative paths; bootgen
# resolves them from the BIF's directory.
AMC_CDO = "${DEPLOY_DIR_IMAGE}/amc-firmware-${MACHINE}.cdo"

AMR_OVERLAY_PDI = "${B}/base-design-overlay.pdi"

# Design BIF filename its folder is found automatically at build time.
AMR_DESIGN_BIF = ""
AMR_DESIGN_BIF:emb-plus-ve2302-amr = "ve2302_xdma_base.bif"
AMR_DESIGN_BIF:alveo-v80-amr = "v80_base_boot.bif"

# Use overlay PDI instead of original base-pdi for AMR machines.
# Varflags can't have overrides, so use variable indirection.
EMB_PLUS_BASE_PDI_IMAGE ?= "${RECIPE_SYSROOT}/boot/base-design.pdi"
EMB_PLUS_BASE_PDI_IMAGE:emb-plus-ve2302-amr = "${AMR_OVERLAY_PDI}"
EMB_PLUS_BASE_PDI_IMAGE:alveo-v80-amr = "${AMR_OVERLAY_PDI}"
BIF_PARTITION_IMAGE[base-pdi] = "${EMB_PLUS_BASE_PDI_IMAGE}"

# Generate overlay PDI for AMR machines (skipped when AMR_DESIGN_BIF is empty)
amr_overlay_cdo() {
    [ -z "${AMR_DESIGN_BIF}" ] && return 0
    if [ ! -f "${AMC_CDO}" ]; then
        bbfatal "AMR overlay CDO not found: ${AMC_CDO}"
    fi
    design_bif=$(find ${SYSTEM_DTFILE_DIR}/extracted -type f -name "${AMR_DESIGN_BIF}" 2>/dev/null | sort | head -1)
    if [ -z "${design_bif}" ] || [ ! -f "${design_bif}" ]; then
        bbfatal "Design BIF '${AMR_DESIGN_BIF}' not found under ${SYSTEM_DTFILE_DIR}/extracted"
    fi
    cd $(dirname ${design_bif})
    bootgen -arch ${BOOTGEN_ARCH} -image $(basename ${design_bif}) \
        -overlay_cdo ${AMC_CDO} -w -o ${AMR_OVERLAY_PDI}
}

do_amr_overlay_cdo() {
    amr_overlay_cdo
}
do_amr_overlay_cdo[depends] += "${ADDN_COMPILE_DEPENDS}"
addtask amr_overlay_cdo after do_prepare_recipe_sysroot before do_configure

# The aggregate manifest hashes BIF_PARTITION_IMAGE[base-pdi], which on AMR is
# the overlay PDI generated above, so aggregation must run after it.
# It also hashes the deploy-path partition images, so depend on their deploy.
do_manifest_aggregate[depends] += "${ADDN_COMPILE_DEPENDS}"
addtask manifest_aggregate after do_amr_overlay_cdo
