#! /bin/bash

SETTINGSPATH='settings.ini'

FOLDERNAME="$(date +"%Y_%M_%d__%H_%S")"

NAME='hostdata'
EXT='data'
LENGTH=5
declare -a ARRAY=('google.fr' 'google.de' 'google.lv' 'google.jp' 'google.us')

echo $LENGTH > $SETTINGSPATH
echo $NAME >> $SETTINGSPATH
echo $EXT >> $SETTINGSPATH

for ((j=0; j<$LENGTH; j++))
do
    HOST=${ARRAY[j]}
    echo $HOST >> $SETTINGSPATH
    FILENAME=$NAME$j.$EXT
    # ping -c 100 -i 0.2 $HOST | awk 'BEGIN{FS="[:]"}{if($2 != ""){print $2}}' | awk 'BEGIN {FS="[=]|[ ]"}{if($7 != ""){print $7}}' >> $FILENAME
    ./runPing.sh $HOST $FILENAME &
    # get pid of last executed command and store it
    pids[${j}]=$!
done

# wait for all pids
for pid in ${pids[*]}; do
    wait $pid
done

python3 data.py $SETTINGSPATH > sumarry.$EXT
cat sumarry.$EXT

#clean project folder
mkdir -p $FOLDERNAME
mv sumarry.$EXT $FOLDERNAME/.
mv $SETTINGSPATH $FOLDERNAME/.
mv *.png $FOLDERNAME/.
for ((j=0; j<$LENGTH; j++))
do
    mv $NAME$j.$EXT $FOLDERNAME/.
done
echo "to run python on existing data, simply move python script in desired folder and execute with python3 data.py [settings file name (default=settings.ini)]"