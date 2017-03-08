#!/bin/bash

if [ -z "$OUT" ]; then
	echo "out path is not set. please run source envsetup.sh & lunch first"
	return
fi

cd $OUT
pwd

arm-linux-androideabi-addr2line -C -f -e "symbols$2" "$1"


