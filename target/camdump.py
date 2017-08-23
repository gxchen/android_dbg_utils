#!/usr/bin/python

import os
import sys
import time



def check_android_device():
	return True


def root_device():
	return True


def main():
	if len(sys.argv) != 2:
		print("[ERR] incorrect arguments!!")
		return

	dmp_types = sys.argv[1]
	ui_string = "Dump HAL imgs of: "
	prop_value = 0;

	for x in dmp_types:
		# print(x)

		if x == 'p':
			ui_string  += " Preview "
			prop_value += 1
		elif x == 'v':
			ui_string  += " Video "
			prop_value += 2
		elif x == 's':
			ui_string  += " Snapshot "
			prop_value += 4
		elif x == 't':
			ui_string  += " Thumbnail "
			prop_value += 8
		elif x == 'j':
			ui_string  += " Jpeg "
			prop_value += 32
			
	print(ui_string)

	cmd_line = "adb shell setprop persist.camera.stats.debug.mask " + str(prop_value)
	print("Running: " + cmd_line)
	os.system(cmd_line)

	os.system("adb shell getprop persist.camera.stats.debug.mask ")


if __name__ == '__main__':
	main()


