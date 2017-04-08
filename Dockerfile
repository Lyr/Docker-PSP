##
# Minimalist Docker Container for the psp sdk and toolchain
#
# MIT Licensed
##
FROM ubuntu:14.04

MAINTAINER  Belldandu, <kami@ilp.moe>
ENV         DEBIAN_FRONTEND noninteractive

# Install Dependencies
RUN         apt-get update
# libtool-bin is a part of libtool as of the latest version of ubuntu
RUN         apt-get install -y g++ build-essential autoconf automake automake1.9 \
                        cmake doxygen bison flex libncurses5-dev libsdl1.2-dev \
                        libreadline-dev libusb-dev texinfo libgmp3-dev libmpfr-dev \
                        libelf-dev libmpc-dev libfreetype6-dev zlib1g-dev libtool \
                        subversion git tcl unzip wget

RUN         useradd -m -d /home/container container

USER        container
ENV         HOME /home/container

WORKDIR     /home/container

SHELL       ["/bin/bash", "-c"]

RUN         mkdir /home/container/pspdev
ENV         PSPDEV /home/container/pspdev
ENV         PATH "${PATH}:$PSPDEV/bin"

RUN         git clone https://github.com/pspdev/psptoolchain.git
WORKDIR     /home/container/psptoolchain
RUN         /bin/bash  toolchain.sh

WORKDIR     /home/container

RUN         git clone https://github.com/pspdev/pspsdk.git
WORKDIR     /home/container/pspsdk
RUN         ./bootstrap
RUN         ./configure
RUN         make
RUN         make install

WORKDIR     /home/container

COPY        ./start.sh /start.sh

CMD         ["/bin/bash", "/start.sh"]
