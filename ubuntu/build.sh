
#!/bin/bash

set -ue

[ $# -eq 2 ] || (echo "USAGE: build.sh prefix dockerfile-prefix" ; exit 1)

[ -f $2.dockerfile ] || (echo "NO DOCKERFILE $2.dockerfile " ; exit 1)

dockerfile=$2.dockerfile

pfx=$1

../build_with_keys.sh -f $dockerfile -t $pfx-$2 --build-arg USER=$USER --build-arg BASE=$pfx:latest


