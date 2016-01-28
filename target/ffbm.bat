
adb root
adb wait-for-device

adb shell "echo ffbm-01 > /dev/block/bootdevice/by-name/misc"

adb shell sync

adb reboot





