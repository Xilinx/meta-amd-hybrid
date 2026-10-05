# meta-amd-hybrid-core

This layer provides the machine-independent metadata for AMD x86 and FPGA
hybrid platforms. It contains the image, kernel and library recipes and
bbappends (`recipes-core`, `recipes-kernel`, `recipes-libraries`) shared
across the Alveo V80 (AMR) and Embedded+ VE2302 (AMR) boards.

Yocto Project guidelines indicate machine specific settings should live in a
separate layer, so all board support content is kept in the companion
meta-amd-hybrid-bsp layer instead.

## Maintainers, Mailing list, Patches

See meta-amd-hybrid README.md file for details on sending patches, and
maintainers.

## Dependencies

This layer depends on:

	URI: https://git.openembedded.org/openembedded-core
	layers: meta
	branch: wrynose

	URI: https://git.openembedded.org/meta-openembedded
	layers: meta-oe, meta-networking
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

## License

Copyright (C) 2024-2026, Advanced Micro Devices, Inc.\
SPDX-License-Identifier: MIT
