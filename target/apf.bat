@echo off

echo "deleting useless files..."
adb shell "rm /data/misc/camera/cam_socket*"
adb shell "rm /data/misc/camera/*.dump"
adb shell "rm /data/misc/camera/*.txt"

echo "getting yuv/raw/jpeg frames..."
adb pull /data/misc/camera

echo "Done!"





