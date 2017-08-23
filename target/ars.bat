@echo off

if "%1" == "ms" (
	echo "restarting media server..."
	for /f "tokens=2" %%a in ('"adb shell ps | findstr mediaserver"') do adb shell kill -9  %%a
	echo "Done!"
) else if "%1" == "mm" (
	echo "restarting mm-qcamera-daemon"
	for /f "tokens=2" %%a in ('"adb shell ps | findstr mm-qcamera-daemon"') do adb shell kill -9  %%a
	echo "Done!"
) else if "%1" == "all" (
rem 	echo "restarting media server..."
rem 	for /f "tokens=2" %%a in ('"adb shell ps | findstr mediaserver"') do adb shell kill -9  %%a
rem 	echo "Done!"

	echo "restarting camera server..."
	for /f "tokens=2" %%a in ('"adb shell ps | findstr cameraserver"') do adb shell kill -9  %%a
	echo "Done!"

	echo "restarting mm-qcamera-daemon"
	for /f "tokens=2" %%a in ('"adb shell ps | findstr mm-qcamera-daemon"') do adb shell kill -9  %%a
	echo "Done!"
) else if "%1" == "cs" (
	echo "restarting cameraserver"
	for /f "tokens=2" %%a in ('"adb shell ps | findstr cameraserver"') do adb shell kill -9  %%a
	echo "Done!"
) else (
	echo "invalid input params..."
)











