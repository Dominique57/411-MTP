#! /bin/bash

SETTINGSPATH='settings.ini'

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

python3 data.py $SETTINGSPATH