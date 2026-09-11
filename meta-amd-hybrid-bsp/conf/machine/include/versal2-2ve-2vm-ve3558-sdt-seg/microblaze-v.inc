
require conf/machine/include/xilinx-microblaze-v.inc

# compatible = "xlnx,microblaze_v";
TUNE_FEATURES:tune-microblaze-v = "${@oe.tune.riscv_isa_to_tune("rv32imac_zicsr_zifencei")}"

# compatible = "xlnx,microblaze_v_asu";
AVAILTUNES += "microblaze-v-asu"
TUNE_FEATURES:tune-microblaze-v-asu = "${@oe.tune.riscv_isa_to_tune("rv32imac_zicsr_zifencei")}"
PACKAGE_EXTRA_ARCHS:tune-microblaze-v-asu = "${TUNE_RISCV_PKGARCH}"
