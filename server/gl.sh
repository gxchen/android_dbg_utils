#!/bin/bash
# One time prep
# -------------
# Place this file gl.sh in your home directory i.e. ~/
# add the below line in your ~/.bashrc
# alias gl=' . ~/gl.sh'
#
# On linux build machine
# --------------------------
# assumes source...lunch are done
# After every mm just type gl from anywhere in the source tree
# A batch file called ld.bat will be generated in your $OUT directory 
# i.e say out/target/product/msm8974
#
# On Windows Laptop connected to device
# -----------------------------------
# open cmd prompt, cd to the $OUT directory i.e. out/target/product/msm8974
# just type ld.bat this will do 
# adb root,remount;
# push all new libraries since full make i.e. system.img generation
# adb shell sync; & also restart mediaserver and camera daemon for you :P

MARKER_FILE_NAME=ld_marker

 
cd $OUT;


if [ -e $MARKER_FILE_NAME ]
then
    if [ $MARKER_FILE_NAME -ot system.img ]
    then
        rm -f $MARKER_FILE_NAME
    fi
fi

if [ -e $MARKER_FILE_NAME ]
then
    echo "ld marker exists, using last ld.bat execution as reference timestamp"
    REFERENCE_TIMESTAMP_FILE=$MARKER_FILE_NAME;
else
    echo "ld marker does not exist using system.img as reference timestamp"
    REFERENCE_TIMESTAMP_FILE=system.img;
fi

printf "echo timestamp > $MARKER_FILE_NAME \n" > ld.bat;
printf "adb wait-for-device\n" >> ld.bat;
printf "adb root\n" >> ld.bat;
printf "adb wait-for-device\n">> ld.bat;
printf "adb remount\n">>ld.bat;
printf "adb wait-for-device\n">>ld.bat;
for i in `find  system -newer $REFERENCE_TIMESTAMP_FILE -type f -name *.so -o -newer system.img -type f -name *.so`;
do 
	echo adb push $i `dirname $i`>>ld.bat; 
done; 
printf "adb shell sync\n">>ld.bat;
printf "adb shell input keyevent 3\n" >> ld.bat

#Uncomment below line and comment 2 echo lines below if you want full reboot. 
#printf "adb reboot\n" >> ld.bat
echo "for /f \"tokens=2\" %%a in ('\"adb shell ps | findstr mediaserver\"') do adb shell kill -9  %%a" >> ld.bat
echo "for /f \"tokens=2\" %%a in ('\"adb shell ps | findstr cameraserver\"') do adb shell kill -9  %%a" >> ld.bat
echo "for /f \"tokens=2\" %%a in ('\"adb shell ps | findstr mm-qcamera-daemon\"') do adb shell kill -9  %%a" >> ld.bat

cd - > /dev/null
 
# In case you are wondering gl==generate list, ld==load
