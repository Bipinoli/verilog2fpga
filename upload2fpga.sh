#!/bin/bash

docker build -t fgpa_synthesis .


# For linux:
docker run -it --device=/dev/bus/usb --privileged fpga_synthesis bash
