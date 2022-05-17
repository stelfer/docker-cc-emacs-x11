#!/bin/sh


DIST=ubuntu
DIST_VER=jammy

CLANG_VER=14
GCC_VER=12
GDB_VER=12

INSTANCE_NAME=dev
INSTANCE_PORT=2222

DOCKER_KEY="$(cat ~/.ssh/docker_ecdsa.pub)"
GITHUB_KEY="$(cat ~/.ssh/github_ecdsa)"

DIST_BASE=${DIST}_${DIST_VER}
TOOLCHAIN_BASE=clang${CLANG_VER}-gcc${GCC_VER}-gdb${GDB_VER}
BASE=${DIST_BASE}-${TOOLCHAIN_BASE}
APP_BASE=${BASE}-apps
DEV_BASE=${APP_BASE}-dev

set -ue

true && (
    cd $DIST
    docker image build -t ${BASE}:latest \
	   --build-arg DIST=$DIST \
	   --build-arg DIST_VER=$DIST_VER \
	   --build-arg CLANG_VER=$CLANG_VER \
	   --build-arg GCC_VER=$GCC_VER \
	   --build-arg GDB_VER=$GDB_VER \
	   -f compilers.dockerfile \
	   .)

true && (
    cd $DIST
    docker image build -t ${APP_BASE}:latest \
	   --build-arg BASE=${BASE} \
	   -f apps.dockerfile \
	   .) 

true && (
    docker image build -t ${DEV_BASE}:latest \
	   --build-arg BASE=$APP_BASE \
	   --build-arg DOCKER_PUBLIC_KEY="$DOCKER_KEY" \
	   --build-arg GITHUB_PRIVATE_KEY="$GITHUB_KEY" \
	   .)


true && (
    docker run -d -p ${INSTANCE_PORT}:22 --name ${INSTANCE_NAME} --hostname ${INSTANCE_NAME} ${DEV_BASE}
    docker update --restart unless-stopped ${INSTANCE_NAME}
    )
    



