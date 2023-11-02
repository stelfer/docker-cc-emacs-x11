
ARG DIST_VER
FROM ubuntu:$DIST_VER
ARG DIST_VER
ARG CLANG_VER
ARG GCC_VER
ARG GDB_VER

RUN apt-get update -y ; apt-get upgrade -y

RUN apt-get install -y python3-software-properties software-properties-common wget \
    gnupg2 apt-transport-https curl python-is-python3

RUN apt-get install -y \
    cmake \
    git \
    iwyu \
    ccache \
    gdb \
    xxd \
    unzip

# Verify gdb version
RUN [ `dpkg-query --showformat='${Version}' --show gdb | cut -d'.' -f1 ` -eq $GDB_VER ] || exit

ADD clang.sh /root/clang.sh
RUN /root/clang.sh

ADD gcc.sh /root/gcc.sh
RUN /root/gcc.sh

ADD cmake.sh /root/cmake.sh
RUN /root/cmake.sh

ADD ../functions.sh /root/functions.sh
ADD functions.sh /root/ubuntu/functions.sh
ADD ninja.sh /root/ubuntu/ninja.sh
RUN /root/ubuntu/ninja.sh

RUN apt-get install -y dialog man-db

RUN apt-get autoremove -y && apt-get clean && rm -rf /var/lib/apt/lists/*
