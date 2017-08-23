#!/system/bin/sh
###!/bin/bash

i=1
echo "Start Camera"
sleep 3

while [[ true ]]; do
	# open camera
	input tap 1275 2250
	sleep 2

	# take snapshot
	input tap 720 2250
	sleep 2

	# exit camera
	input tap 720 2480
	sleep 2

	echo "Iteration $i Finished"

	i=$((i + 1))
	if ((i % 3000 == 0)); then
		exit
	fi
done
