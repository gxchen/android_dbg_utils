#!/usr/bin/python

import os
import sys
import time


def main():
	splitLen = 100000         # 20 lines per file
	outputBase = 'output' # output.1.txt, output.2.txt, etc.

	input = open('usr.log', 'r')

	count = 0
	at = 0
	dest = None
	for line in input:
		if count % splitLen == 0:
			if dest: dest.close()
			dest = open(outputBase + str(at) + '.txt', 'w')
			at += 1
		dest.write(line)
		count += 1


if __name__ == '__main__':
	main()


