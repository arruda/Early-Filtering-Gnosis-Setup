#!/bin/bash

# working fast for rtmp server
ffmpeg -f v4l2 -i /dev/video0 -f lavfi -i anullsrc=channel_layout=stereo:sample_rate=44100 -profile:v main -pix_fmt yuv420p -preset ultrafast -tune zerolatency -vcodec libx264 -r 10 -g 10 -keyint_min 10 -sc_threshold 0 -b:v 2000k -maxrate 2000k -bufsize 2000k -s 720x480 -acodec aac  -f flv rtmp://localhost:1934/live/mystream
