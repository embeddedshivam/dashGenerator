#!/bin/bash

set -e

helpFunction()
{
   echo "Open Source MP4 to DASH Converter"
   echo -e "\t Set the Environment Variable as Path for input mp4 file"
   echo -e "\t Set the Destination Path for creating DASH Media"
   echo -e "\t -b video_bitrate < 1920*1080 | 1280*720 | 720x480 | 640x480>"
   echo -e "\t -b video_quality < <5800 | 4300> | <3000 | 2350> | <1750> | <1050>>"
   exit 1 # Exit script after printing help
}

[[ -z ${DASHIN+x} ]] && echo "You must set the variable PYTHON in order to use this script." && echo && helpFunction && exit 1
[[ -z ${DASHOUT+x} ]] && echo "You must set the variable PIP in order to use this script." && echo && helpFunction && exit 1

while getopts "b:q:t:" opt
do
   case "$opt" in
      b ) video_bitrate="$OPTARG" ;;
      q ) video_quality="$OPTARG" ;;
      t ) title="$OPTARG" ;;
      ? ) helpFunction ;; # Print helpFunction in case parameter is non-existent
   esac
done

# Print helpFunction in case parameters are empty
if [ -z "$video_bitrate" ] || [ -z "$video_quality" ] || [ -z "$title" ]
then
   echo "Some or all of the parameters are empty";
   helpFunction
fi


# Video Encoding is done as per the below mentioned mapping for optimized output
#Bitrate (kbps) - Resolution
#235 - 320x240
#375 - 384x288
#560 - 512x384
#750 - 512x384
#1050 - 640x480
#1750 - 720x480
#2350 - 1280x720
#3000 - 1280x720
#4300 - 1920x1080
#5800 - 1920x1080


echo $$video_quality
# Video quality of 1920*1080
if [ $video_quality == "1920*1080" ]
then
  echo "Encoding with 1920*1080"
  if [ $video_bitrate == "5800" ]
  then
    echo "Encoding Video Quality as 1920 x 1080 with Bitrate of 5800 kbps."
    ffmpeg -y -i $DASHIN -c:v libx264 -r 24 -x264opts 'keyint=48:min-keyint=48:no-scenecut' \
    -vf scale=-2:1080 -b:v 5800k -bufsize 8600k -maxrate 5800k -movflags faststart \
    -preset fast -profile:v main -an  "$DASHOUT""$title"
  elif [ $video_bitrate == "4300" ]
  then
    echo "Encoding Video Quality as 1920 x 1080 with Bitrate of 4300 kbps."
    ffmpeg -y -i $DASHIN -c:v libx264 -r 24 -x264opts 'keyint=48:min-keyint=48:no-scenecut' \
    -vf scale=-2:1080 -b:v 4300k -bufsize 8600k -maxrate 4300k -movflags faststart \
    -preset fast -profile:v main -an  "$DASHOUT""$title"
  else
    echo "Unexpected video_bitrate, Please select between 5800 and 4300 for 1920*1080"
  fi


# Video quality of 1280*720
elif [ $video_quality == "1280*720" ]; then
   echo "Encoding with 1280*720"
  if [ $video_bitrate == "3000" ]
  then
    echo "Encoding Video Quality as 1280*720 with Bitrate of 3000 kbps."
    ffmpeg -y -i $DASHIN -c:v libx264 -r 24 -x264opts 'keyint=48:min-keyint=48:no-scenecut' \
    -vf scale=-2:720 -b:v 3000k -bufsize 8600k -maxrate 3000k -movflags faststart \
    -preset fast -profile:v main -an  "$DASHOUT""$title"
  elif [ $video_bitrate == "2350" ]
  then
    echo "Encoding Video Quality as 1280*720 with Bitrate of 2350 kbps."
    ffmpeg -y -i $DASHIN -c:v libx264 -r 24 -x264opts 'keyint=48:min-keyint=48:no-scenecut' \
    -vf scale=-2:720 -b:v 2350k -bufsize 8600k -maxrate 2350k -movflags faststart \
    -preset fast -profile:v main -an  "$DASHOUT""$title"
  else
    echo "Unexpected video_bitrate, Please select between 3000 and 2350 for 1280*720"
  fi


# Video quality of 720*480
elif [ $video_quality == "720*480" ]; then
   echo "Encoding with 720x480"
  if [ $video_bitrate == "1750" ]
  then
    echo "Encoding Video Quality as 1280*720 with Bitrate of 1750 kbps."
    ffmpeg -y -i $DASHIN -c:v libx264 -r 24 -x264opts 'keyint=48:min-keyint=48:no-scenecut' \
    -vf scale=-2:480 -b:v 1750k -bufsize 8600k -maxrate 1750k -movflags faststart \
    -preset fast -profile:v main -an  "$DASHOUT""$title"
  else
    echo "Unexpected video_bitrate, Please select 1750 for 720x480"
  fi


# Video quality of 640*480
elif [ $video_quality == "640x480" ]; then
  echo "Encoding with 640x480"
  if [ $video_bitrate == "1050" ]
  then
    echo "Encoding Video Quality as 1280*720 with Bitrate of 1050 kbps."
    ffmpeg -y -i $DASHIN -c:v libx264 -r 24 -x264opts 'keyint=48:min-keyint=48:no-scenecut' \
    -vf scale=-2:480 -b:v 1050k -bufsize 8600k -maxrate 1050k -movflags faststart \
    -preset fast -profile:v main -an  "$DASHOUT""$title"
  else
    echo "Unexpected video_bitrate, Please select 1050 for 640x480"
  fi
else
  echo "Invalid Video Quality"
fi
