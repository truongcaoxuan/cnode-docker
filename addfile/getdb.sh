#!/bin/bash
if [ $# != 2 ]; then
   echo "Usage: downG.sh ID save_name"
   exit 0
fi
#fileid="1auBOPyiooV-0FrOc7GIAAMonFpMXjZMP"
#$fileid="1O_vA-_AgYpgpN5JVBrhLsFiN6LajLYzF"
#$filename="db.zip"

curl -c ./cookie -s -L "https://drive.google.com/uc?export=download&id=$1" > /dev/null
curl -Lb ./cookie "https://drive.google.com/uc?export=download&confirm=`awk '/download/ {print $NF}' ./cookie`&id=$1" -o $2
