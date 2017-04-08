#!/bin/bash
# PSP SDK and toolchain Container Start Script
#
# Copyright (c) 2017 Belldandu <kami@ilp.moe> MIT Licensed
# ##
sleep 3

if [ "$(pwd)" -ne "/home/container" ]; then
	cd /home/container
fi

echo ":/home/container$ /bin/bash"
/bin/bash

if [ $? -ne 0 ]; then
    echo "PTDL_CONTAINER_ERR: There was an error while attempting to run the start command."
    exit 1
fi
