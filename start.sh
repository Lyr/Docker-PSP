#!/bin/bash
# PSP SDK and toolchain Container Start Script
#
# Copyright (c) 2017 Belldandu <kami@ilp.moe> MIT Licensed
# ##
sleep 3

if [ "$(pwd)" -ne "/home/container" ]; then
	cd /home/container
fi

if [ ! -d "${PSPDEV}/bin" ]; then
	echo "First time running this container or ${PSPDEV} is corrupted. Either way compilation starts in 3 seconds and its going to take a while before it's finished."
	echo ":/home/container$ rm -rf ${PSPDEV}/*"
	rm -rf $PSPDEV/*
	echo "So grab a soda or something and enjoy the ride, or play a video game, or whatever you do when waiting."
	echo ":/home/container$ git clone https://github.com/pspdev/psptoolchain.git"
	git clone https://github.com/pspdev/psptoolchain.git
	sleep 3
	# Build psp toolchain (sdk is included in toolchain)
	echo ":/home/container$ cd psptoolchain"
	cd psptoolchain
	echo ":/home/container/psptoolchain$ ./toolchain.sh"
	./toolchain.sh
	echo ":/home/container/psptoolchain$ cd .."
	cd ..
	echo ":/home/container$ rm -rf psptoolchain"
	rm -rf psptoolchain
	echo "The PSP toolchain is now installed (the sdk is part of the toolchain)."

else
	echo "PSP toolchain already installed (sdk is included in toolchain)"
fi

echo "Make sure to read the readme at https://github.com/belldandu/Docker-PSP/blob/master/README.md so that you know how to properly start this image."
echo "Please type exit once you wish to stop the container."
echo ":/home/container$ /bin/bash"
/bin/bash
