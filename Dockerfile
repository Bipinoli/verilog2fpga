FROM haskell:latest

# synthesis pipeline:
# 1. yosys - open rtl synthesis framework
# 2. nextpnr - place and route tool for FPGAs
# 3. icestorm - docs and tools for Lattice iCE40 FPGAs
# 4. icedude - programming tool for the iCE40 FPGA evaluation boards


# icdedude depends on libusb via bindings-libusb library 
# libusb library is located with the help of pkg-config 
# so, pkg-config also needs to be installed and pointed to the right path to .pc file
# Location of `.pc` file can be identified by running `dpkg -L libusb-1.0-0.dev` 
RUN apt-get update && \
    apt-get install -y pkg-config && \
    apt-get install -y libusb-1.0-0-dev && \
    apt-get install -y yosys && \
    apt-get install -y nextpnr-ice40 && \
    apt-get install -y fpga-icestorm


RUN cabal update

ENV PKG_CONFIG_PATH=$PKG_CONFIG_PATH:/usr/lib/x86_64-linux-gnu/pkgconfig/

WORKDIR /synthesis_pipeline

RUN git clone https://github.com/reactive-systems/icedude.git

RUN cd icedude && \
    cabal v2-install && \
    cd ..

