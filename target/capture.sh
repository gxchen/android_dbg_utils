#!/system/bin/sh
i=0
echo "Start Camera"
sleep 3
while 
i=$((i+1))
if((i%3001==0))
then
echo "Passed 10 iterations"
sleep 3000000
fi
do 
input tap 1436 175
sleep 1
input tap 465 1775 
sleep 2
echo "Iteration $i Finished"
done
