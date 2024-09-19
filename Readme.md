# Verilog2FGPA synthesis toolchain

It is a toolchain pipeline to synthesize a circuit for a ICE40HX1K-BLINK-EVN Fpga from a verilog. 

# How to use?

## Linux
1. Connect the FPGA via usb
2. Setup docker container with `./setup_container.sh`
3. Run `./synthesize.sh` with a path to your verilog files (.v, .pcf) as an argument. <br>
    Eg: `./synthesize.sh example_verilog`

## Windows / macOS
On macOS and Windows, Docker runs in a separate VM so docker doesn't have a native access to the usb devices.
You can look into [this post](https://bipinoli.github.io/2024/09/19/Dockerized-Verilog-to-FPGA-synthesis-pipeline.html) for details.
