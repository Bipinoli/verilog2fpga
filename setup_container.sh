#!/bin/bash

docker build -t fgpa_synthesis .

# For linux:
# allow access to usb device from container
# mount current directory in the container to provice synthesis script and verilog files
docker run -it --device=/dev/bus/usb --privileged --mount type=bind,src="$(pwd)",target=/synthesis_pipeline fpga_synthesis bash

