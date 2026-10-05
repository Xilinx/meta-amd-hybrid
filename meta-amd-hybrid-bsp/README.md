# meta-amd-hybrid-bsp

This layer provides the board support metadata for AMD x86 and FPGA hybrid
platforms: machine configuration files, machine/domain YAML, system device
trees, multiconfig files and the supporting `recipes-bsp` content for the
Alveo V80 (AMR), Alveo V95 (AMR) and Embedded+ VE2302 (AMR) boards.

Yocto Project guidelines indicate machines and distro settings should be in
different layers. The AMD hybrid machines and related settings are captured
in this layer, while the companion meta-amd-hybrid-core layer does NOT
contain any machine specific items.

## Maintainers, Mailing list, Patches

See meta-amd-hybrid README.md file for details on sending patches, and
maintainers.

## Dependencies

This layer depends on:

	URI: https://git.openembedded.org/openembedded-core
	layers: meta
	branch: wrynose

	URI: https://git.openembedded.org/meta-openembedded
	layers: meta-oe, meta-python
	branch: wrynose

	URI:
        https://git.yoctoproject.org/meta-xilinx (official version)
        https://github.com/Xilinx/meta-xilinx (development and AMD release)
	layers: meta-xilinx-core, meta-xilinx-standalone, meta-xilinx-standalone-sdt,
	        meta-microblaze
	branch: wrynose or AMD release version (e.g. rel-v2026.2)

	URI: https://github.com/Xilinx/meta-amd-adaptive-socs
	layers: meta-amd-adaptive-socs-core
	branch: AMD release version (e.g. rel-v2026.2)

	URI: https://github.com/Xilinx/meta-amd-hybrid
	layers: meta-amd-hybrid-core
	branch: AMD release version (e.g. rel-v2026.2)

## License

Copyright (C) 2024-2026, Advanced Micro Devices, Inc.\
SPDX-License-Identifier: MIT
