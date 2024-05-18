# Docker mist-firmware-builder

This repository provides a Dockerfile to create a Docker image based on Ubuntu 24.04 LTS for building the [firmware](https://github.com/mist-devel/mist-firmware) for [MiST FPGA](https://github.com/mist-devel/mist-board/wiki).

A ready-built public Docker image is available at [ghcr.io/retrofun/mist-firmware-builder](https://ghcr.io/retrofun/mist-firmware-builder).

## Dockerfile details

* All necessary packages with tools to compile the cross compiler for ARM EABI will be installed.
* The [install_arm-none-eabi-gcc.sh](https://github.com/mist-devel/mist-board/blob/master/tools/install_arm-none-eabi-gcc.sh) script from [mist-board](https://github.com/mist-devel/mist-board) repository will be downloaded.
* The install script will be patched with `install_arm-none-eabi-gcc.sh.patch`
  * to download a newer/the latest version of gcc-5 because gcc-5.2.0 won't compile on newer systems,
  * to invoke `make` with the number of available processors for faster parallel build,
  * to use C++11 standard with `CXXFLAGS="-std=c++11"` to circumvent compile errors.
* Finally `install_arm-none-eabi-gcc.sh` is invoked

The target directory of the cross compiler for ARM EABI is `/opt/arm-none-eabi`.
