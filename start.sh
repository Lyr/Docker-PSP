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
	if [ ! -d $PSPDEV ]; then
		echo "First time running this container, creating ${PSPDEV} directory..."
		echo ":/home/container$ mkdir ${PSPDEV}"
		mkdir $PSPDEV
	else
		echo  "${PSPDEV} is corrupted, removing all files to prevent issues..."
		echo ":/home/container$ rm -rf ${PSPDEV}/*"
		rm -rf $PSPDEV/*
	fi
	echo "Compilation starts in 3 seconds and its going to take a while before it's finished.".
	echo "So grab a soda or something and enjoy the ride, or play a video game, or whatever you do when waiting."
	# echo ":/home/container$ git clone https://github.com/pspdev/psptoolchain.git"
	# git clone https://github.com/pspdev/psptoolchain.git
	# test fixed branch for opentri
	echo "Using userbranch that fixes opentri installation issues..."
	echo ":/home/container$ git clone https://github.com/iaDRM/psptoolchain.git"
	git clone https://github.com/iaDRM/psptoolchain.git
	if [ $? -ne 0 ]; then
		echo "ERROR: git clone exited with code 0."
		echo "Failed to clone the psptoolchain repository using git over https."
		exit 1
	else
		echo ":/home/container$ cd psptoolchain"
		cd psptoolchain
		echo ":/home/container/psptoolchain$ git checkout xissue_72"
		git checkout xissue_72
		sleep 3
		# Build psp toolchain (sdk is included in toolchain)
		echo ":/home/container/psptoolchain$ ./toolchain.sh"
		./toolchain.sh
		if [ $? -ne 0 ]; then
			echo "ERROR: /home/container/psptoolchain/toolchain.sh exited with code 0."
			echo "PSP toolchain failed to install."
			exit 1
		else
			echo "The PSP toolchain is now installed (the sdk is part of the toolchain)."
		fi
		echo ":/home/container/psptoolchain$ cd .."
		cd ..
		echo ":/home/container$ rm -rf psptoolchain"
		rm -rf psptoolchain
	fi
else
	echo "PSP toolchain already installed (sdk is included in toolchain)"
fi

echo "Make sure to read the readme at https://github.com/belldandu/Docker-PSP/blob/master/README.md so that you know how to properly start this image."
echo "Please type exit once you wish to stop the container."
echo ":/home/container$ /bin/bash"
/bin/bash


