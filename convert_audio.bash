#!/bin/bash

set -e

helpFunction()
{
   echo "Open Source MP4 to DASH Converter AUDIO"
   echo -e "\t Set the Environment Variable as Path for input mp4 file"
   echo -e "\t Set the Destination Path for creating DASH Media"
   exit 1 # Exit script after printing help
}

[[ -z ${DASHIN+x} ]] && echo "You must set the variable PYTHON in order to use this script." && echo && helpFunction && exit 1
[[ -z ${DASHOUT+x} ]] && echo "You must set the variable PIP in order to use this script." && echo && helpFunction && exit 1

while getopts "n:b:t:" opt
do
   case "$opt" in
      n ) n="$OPTARG" ;;
      b ) audio_bitrate="$OPTARG" ;;
      t ) title="$OPTARG" ;;
      ? ) helpFunction ;; # Print helpFunction in case parameter is non-existent
   esac
done

# Print helpFunction in case parameters are empty
if [ -z "$audio_bitrate" ] || [ -z "$n" ] || [ -z "$title" ]
then
   echo "Some or all of the parameters are empty";
   helpFunction
fi

if [ $audio_bitrate == "128" ]
  then
    echo "Encoding Video Quality as 1920 x 1080 with Bitrate of 5800 kbps."
    echo -y -i $DASHIN -map 0:$n -vn -c:a aac -b:a 128k -ar 48000 -ac 2 "$title"
    ffmpeg -y -i $DASHIN -map 0:$n -vn -c:a aac -b:a 128k -ar 48000 -ac 2 "$title"
  else
    echo "Unexpected Audio Bitrate, Please use 128k"
fi


