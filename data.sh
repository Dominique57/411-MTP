#! /bin/bash

SETTINGSPATH='settings.ini'

NAME='hostdata'
EXT='data'
LENGTH=5
declare -a ARRAY=('google.fr' 'google.de' 'google.lv' 'google.jp' 'google.us')

echo $LENGTH\n$LENGTH\n$EXT\n > $SETTINGSPATH


for ((j=0; j<$LENGTH; j++))
do
    HOST=${ARRAY[j]}
    echo $HOST >> $SETTINGSPATH
    FILENAME=$NAME$j.$EXT
    touch $FILENAME
    > $FILENAME
    ping -c 100 -i 0.2 $HOST | awk 'BEGIN{FS="[:]"}{if($2 != ""){print $2}}' | awk 'BEGIN {FS="[=]|[ ]"}{if($7 != ""){print $7}}' >> $FILENAME
    echo $j th iteration : $HOST data collected
    sleep 3s
done