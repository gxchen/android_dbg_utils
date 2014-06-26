#!/usr/bin/python

import os
import sys
from subprocess import PIPE
from subprocess import Popen

STR_PS_PREFIX = "adb shell ps "


def cmdline(command):
	#os.system(adb_ps_cmd + "media")
	process = Popen(
		args   = command,
		stdout = PIPE,
		shell  = True
	)
	
	(out, err) = process.communicate()
	#print("[DBG] ", out, err)
	if err:
		print("[ERR] err in running cmd (" + command + ")")
		return None
	else:
		return out
	#return process.communicate()
	#return process.communicate()[0]


def check_android_device():
	return True

# may be we can return a list here.
# so we can accept args like 'all', 
# and kill all interested processes...
def get_ps_query_name(arg1):
	query_name = ''

	if arg1:
		if arg1 == 'ms':
			query_name = 'mediaserver'
		elif arg1 == 'mm':
			query_name = 'mm-qcam'

		print("[DBG] argv[1]: " + arg1 + ", query_name: " + query_name)
	else:
		print("[ERR] arguments is None")

	return query_name


def get_process_info(query_name):
	#query_name = 'mediaserver'

	adb_ps_cmd = STR_PS_PREFIX + query_name
	output = cmdline(adb_ps_cmd)
	#print("[DBG] adb ps cmd output\n" + output)

	process_info = output.split('\n')[1]
	if (not process_info) or (process_info == ''):
		print("[ERR] can't find process: " + query_name)
		return (0, None)

	#print("[DBG] process info: " + process_info)

	p_info_list = process_info.split()
	pid   = p_info_list[1]
	pname = p_info_list[8]

	return (pid, pname)


def kill_process(pid):
	print('\n[WRN] killing process: ' + pid)
	os.system('adb shell kill ' + pid)


def main():
	if len(sys.argv) != 2:
		print("[ERR] incorrect arguments!!")
		return

	ps_query_name = get_ps_query_name(sys.argv[1])
	if ps_query_name == '':
		print("[ERR] incorrect arguments!!")
		return

	(pid, pname) = get_process_info(ps_query_name)
	print("\n[INF] <<<<<< PROCESS INFO >>>>>>\n[INF] Full name: " + pname + '\n[INF] PID: ' + pid)

	kill_process(pid)

	(pid, pname) = get_process_info(ps_query_name)
	print("\n[INF] <<<<<< PROCESS INFO (after kill) >>>>>>\n[INF] Full name: " + pname + '\n[INF] PID: ' + pid)

if __name__ == '__main__':
	main()


