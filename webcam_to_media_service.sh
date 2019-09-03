#!/bin/bash


./ffmpeg_bin/ffmpeg-linux64-v3.3.1 -f video4linux2 -i /dev/video0 -c:v libx264 -vf "drawtext=ffmpeg_bin/KhmerOS.ttf:fontcolor=white:text='%{pts\:gmtime\:1507046400\:%d-%m-%Y %T}:fontsize=14'[out]" -an -f flv rtmp://localhost/live/mystream