#!/bin/sh


DIST=ubuntu
DIST_VER=jammy

TOOLCHAIN=clang
TOOLCHAIN_VER=14

INSTANCE_NAME=dev
INSTANCE_PORT=2222

DOCKER_KEY="$(cat ~/.ssh/docker_ecdsa.pub)"
GITHUB_KEY="$(cat ~/.ssh/github_ecdsa)"

DIST_BASE=${DIST}_${DIST_VER}
TOOLCHAIN_BASE=${TOOLCHAIN}_${TOOLCHAIN_VER}
BASE=${DIST_BASE}-${TOOLCHAIN_BASE}
APP_BASE=${BASE}-apps
DEV_BASE=${APP_BASE}-dev

set -ue

/bin/false && (
    cd $DIST
    docker image build -t ${BASE}:latest \
	   --build-arg DIST=$DIST \
	   --build-arg DIST_VER=$DIST_VER \
	   --build-arg TOOLCHAIN_VER=$TOOLCHAIN_VER \
	   -f $TOOLCHAIN.dockerfile \
	   .)

/bin/false && (
    cd $DIST
    docker image build -t ${APP_BASE}:latest \
	   --build-arg BASE=${BASE} \
	   -f apps.dockerfile \
	   .) 

/bin/true && (
    docker image build -t ${DEV_BASE}:latest \
	   --build-arg BASE=$APP_BASE \
	   --build-arg DOCKER_PUBLIC_KEY="$DOCKER_KEY" \
	   --build-arg GITHUB_PRIVATE_KEY="$GITHUB_KEY" \
	   .)


true && (
    docker run -d -p ${INSTANCE_PORT}:22 --name ${INSTANCE_NAME} --hostname ${INSTANCE_NAME} ${DEV_BASE}
    docker update --restart unless-stopped ${INSTANCE_NAME}
    )
    



