#! /bin/bash
#creating default content variables
HOST=$1
FILENAME=$2

#if no parameters given, exit
if [ -z "$1" ];then
    echo "first parameter : hostname missing"
    exit 1
fi
if [ -z "$2" ];then
    echo "second parameter : filename missing"
    exit 1
fi

ping -c 100 -i 0.2 $HOST | awk 'BEGIN{FS="[:]"}{if($2 != ""){print $2}}' | awk 'BEGIN {FS="[=]|[ ]"}{if($7 != ""){print $7}}' > $FILENAME