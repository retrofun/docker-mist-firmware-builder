FROM ubuntu:22.04

LABEL org.opencontainers.image.description Docker image to compile the firmware for MiST FPGA

WORKDIR /tmp
COPY install_arm-none-eabi-gcc.sh.patch .

RUN apt update && \
apt -y --no-install-recommends install bzip2 ca-certificates g++ gcc git libgmp-dev libmpc-dev libmpfr-dev make patch wget xz-utils && \
wget --no-verbose https://github.com/mist-devel/mist-board/raw/master/tools/install_arm-none-eabi-gcc.sh && \
patch -p0 <install_arm-none-eabi-gcc.sh.patch && \
chmod +x install_arm-none-eabi-gcc.sh && \
./install_arm-none-eabi-gcc.sh && \
binutils=$(find . -type d -name 'binutils-[0-9]*') && \
[ -n "${binutils}" ] && \
gcc=$(find . -type d -name 'gcc-[0-9]*') && \
[ -n "${gcc}" ] && \
newlib=$(find . -type d -name 'newlib-[0-9]*') && \
[ -n "${newlib}" ] && \
rm -rf archives "${binutils}" "${gcc}" "${newlib}" install_arm-none-eabi-gcc.sh install_arm-none-eabi-gcc.sh.patch
