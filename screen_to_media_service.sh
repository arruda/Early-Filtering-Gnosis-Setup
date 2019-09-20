#!/bin/bash


./ffmpeg_bin/ffmpeg-linux64-v3.3.1 -video_size 640x480 -framerate 30 -f x11grab -i :0.0+100,200 -c:v libx264 -vf "drawtext=ffmpeg_bin/KhmerOS.ttf:fontcolor=white:text='%{pts\:gmtime\:1507046400\:%d-%m-%Y %T}:fontsize=14'[out]" -an -f flv rtmp://localhost/live/mystream