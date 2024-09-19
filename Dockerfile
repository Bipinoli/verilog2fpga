FROM haskell:9

# synthesis pipeline:
# 1. yosys - open rtl synthesis framework (https://github.com/cliffordwolf/yosys)
# 2. nextpnr - place and route tool for FPGAs (https://github.com/YosysHQ/nextpnr)
# 3. icestorm - docs and tools for Lattice iCE40 FPGAs (https://github.com/cliffordwolf/icestorm/)
# 4. icedude - programming tool for the iCE40 FPGA evaluation boards (https://github.com/reactive-systems/icedude)


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

ENV PKG_CONFIG_PATH=/usr/lib/pkgconfig/:/usr/lib/x86_64-linux-gnu/pkgconfig/

WORKDIR /synthesis_pipeline

# building icedude from a specific commit (message: GHC 9.6 support) 
# to make sure future changes doesn't break our build
RUN git clone https://github.com/reactive-systems/icedude.git
RUN cd icedude && \ 
    git checkout f70a86d && \
    cabal v2-install && \
    cd ..

