#!/bin/sh

VERILOG_FILE=btn_led.v
TOP_MODULE=btn_led
BUILDDIR=target

mkdir -p $BUILDDIR

# synthesize to net-list file 
yosys -p "read_verilog $VERILOG_FILE; hierarchy -check; proc; opt"
yosys -p "read_verilog $VERILOG_FILE; synth_ice40 -top $TOP_MODULE -json $BUILDDIR/${TOP_MODULE}.json"

# placing and routing to ice10hk1k FPGA using the specific "pin contrainst file" i.e iceblink.pcf
nextpnr-ice40 --pcf-allow-unconstrained \
    --no-tmdriv \
    --hx1k \
    --package vq100 \
    --json $BUILDDIR/${TOP_MODULE}.json \
    --pcf iceblink.pcf \
    --asc $BUILDDIR/${TOP_MODULE}.asc

# Generate bitstream (.bin) from the "place and route file (.asc)"
icepack $BUILDDIR/${TOP_MODULE}.asc $BUILDDIR/${TOP_MODULE}.bin

# Upload/program the FPGA (ice10hk1k-blink-evn) with the bitstream
iCEDude -U flash:w:$BUILDDIR/${TOP_MODULE}.bin

