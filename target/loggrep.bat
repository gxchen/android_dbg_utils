@echo off

adb wait-for-device
adb logcat -v threadtime | findstr %1













