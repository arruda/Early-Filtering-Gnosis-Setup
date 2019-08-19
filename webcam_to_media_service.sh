#!/bin/bash

./ffmpeg_bin/ffmpeg-linux64-v3.3.1 -f video4linux2 -i /dev/video0 -c:v libx264 -an -f flv rtmp://localhost/live/mystream