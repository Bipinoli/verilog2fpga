#!/bin/bash

docker build -t fgpa_synthesis .


# For linux:
docker run -it --device=/dev/bus/usb:/dev/bus/usb:/dev/ttyUSB0 --privileged fpga_synthesis bash
