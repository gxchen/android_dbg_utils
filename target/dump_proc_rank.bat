@echo off

adb shell procrank > procrank.txt
for /l %%i in (1,1,100000) do (
	echo num: %%i
	adb shell procrank >> procrank.txt
	adb shell sleep 5
)

pause