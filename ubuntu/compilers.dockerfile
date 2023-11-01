
ARG DIST_VER
FROM ubuntu:$DIST_VER
ARG DIST_VER
ARG CLANG_VER
ARG GCC_VER
ARG GDB_VER

RUN apt-get update -y ; apt-get upgrade -y

RUN apt-get install -y python3-software-properties software-properties-common wget \
    gnupg2 apt-transport-https curl

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

RUN apt-get install -y dialog man-db

RUN apt-get autoremove -y && apt-get clean && rm -rf /var/lib/apt/lists/*
