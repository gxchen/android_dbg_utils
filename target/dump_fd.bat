@echo off

:start

for /f "tokens=2" %%a in ('"adb shell ps | findstr cameraserver"') do adb shell ls -l /proc/%%a/fd 
echo ------------------------------------------

adb shell sleep 1

goto start





