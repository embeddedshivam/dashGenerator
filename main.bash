#!/bin/bash

export DASHIN=/home/shivam/Desktop/dash_example/script/video.mp4
export DASHOUT=/home/shivam/Desktop/dash_example/script/output/

cd $DASHOUT
bash ../convert_video.bash -q 1920*1080 -b 5800 -t video_1080p.mp4
bash ../convert_video.bash -q 1280*720 -b 3000 -t video_720p.mp4
bash ../convert_video.bash -q 720*480 -b 1750 -t video_480p.mp4

bash ../convert_audio.bash -n 1 -b 128 -t audio.m4a

MP4Box -dash 4000 -frag 4000 -rap \
-segment-name 'segment_$RepresentationID$_' -fps 24 \
video_480p.mp4#video:id=480p \
video_720p.mp4#video:id=720p \
video_1080p.mp4#video:id=1080p \
audio.m4a#audio:id=English:role=main \
-out play.mpd