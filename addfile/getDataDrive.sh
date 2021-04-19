#!/bin/bash
if [ $# != 2 ]; then
   echo "Usage: getDataDrive.sh ID save_name"
   exit 0
fi
#-- db epoch 258
#fileid="1O_vA-_AgYpgpN5JVBrhLsFiN6LajLYzF"
#$filename="db.zip"
#
#-- bin 1.26.2 
#$fileid="1y1ZBVXGInMJ8F2X8wVQ47ZvIgY8CEFFi"
#$filename="bin.zip"
#
curl -c ./cookie -s -L "https://drive.google.com/uc?export=download&id=$1" > /dev/null
curl -Lb ./cookie "https://drive.google.com/uc?export=download&confirm=`awk '/download/ {print $NF}' ./cookie`&id=$1" -o $2
