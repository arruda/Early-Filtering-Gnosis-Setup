#!/bin/bash

# this one works:
# ./ffmpeg_bin/ffmpeg-linux64-v3.3.1 -f video4linux2 -i /dev/video0 -pix_fmt yuv420p -c:v libx264 \
#  -g 1 -keyint_min 1 \
#  -an -f flv rtmp://localhost/hls/mystream

# testar rodar dentro de container
# ./ffmpeg_bin/ffmpeg-linux64-v3.3.1 -f video4linux2 -i /dev/video0 -pix_fmt yuv420p -c:v libx264 \
#  -g 1 -keyint_min 1 \
#  -flags:v +global_header -bsf:v "dump_extra=freq=keyframe" -max_delay 0 -bf 0 -an -f rtp rtp://127.0.0.1:5004
# # dentro do container
# ./ffmpeg_bin/ffmpeg-linux64-v3.3.1 -re -stream_loop -1 -i ./medias/cars.mp4 -pix_fmt yuv420p -c:v libx264 \
#  -g 1 -keyint_min 1 \
#  -flags:v +global_header -bsf:v "dump_extra=freq=keyframe" -max_delay 0 -bf 0 -an -f rtp rtp://media-server:5004



# ./ffmpeg_bin/ffmpeg-linux64-v3.3.1 -re -f lavfi -i testsrc=s=hd720,format=yuv420p -f lavfi -i anullsrc -c:v libx264 -g 50 -c:a aac -f flv rtmp://localhost:1935/live/mystream

# ./ffmpeg_bin/ffmpeg-linux64-v3.3.1 -re \
# 	-f video4linux2 \
# 	-i /dev/video0 \
#     -pix_fmt yuv420p \
# 	-framerate 10 \
# 	-vcodec libx264 \
# 	-vprofile baseline \
#     -acodec libmp3lame \
#     -ar 44100 \
#     -ac 1 \
# 	-f flv \
# 	rtmp://localhost:1935/live/mystream
# 	# -map 0:v \
# 	# -b:v 800k \
# 	# -vf "scale=640:360" \

# http://localhost:8080/hls/mystream.m3u8
# http://localhost:8080/dash/mystream.mpd
# rtmp://localhost/hls/mystream

# janus?
# fmpeg -re -stream_loop -1 -i ./short.mp4 -s 852x480 -c:v libx264 -profile:v baseline -b:v 4M -r 24 -g 60 -flags:v +global_header -bsf:v "dump_extra=freq=keyframe" -max_delay 0 -bf 0 -an -f rtp rtp://media-server:5004
# ./ffmpeg_bin/ffmpeg-linux64-v3.3.1 -re -stream_loop -1 -i ./medias/cars.mp4 -s 852x480 -c:v libx264 -profile:v baseline -b:v 4M -r 24 -g 60 -flags:v +global_header -bsf:v "dump_extra=freq=keyframe" -max_delay 0 -bf 0 -an -f rtp rtp://media-server:5004
# ./ffmpeg_bin/ffmpeg-linux64-v3.3.1 -re -stream_loop -1 -i ./media-server-conf/cars.mp4 -c:v libx264 -profile:v main -s 1920x1080 -an -preset ultrafast -tune zerolatency -g 50 -f flv rtmp://localhost:1935/stream
# -c:v libx264 -profile:v main -s 1920x1080 -an -preset ultrafast -tune zerolatency -g 50 -f


# ./ffmpeg_bin/ffmpeg-linux64-v3.3.1 -f video4linux2 -i /dev/video0 -r 10 -pix_fmt yuv420p -s 720x480 -c:v libx264 \
#  -profile:v baseline -an -preset ultrafast -tune zerolatency \
#  -g 10 -keyint_min 10 \
#  -an -f flv rtmp://localhost:1934/live/mystream

# ./ffmpeg_bin/ffmpeg-linux64-v3.3.1 -f video4linux2 -i /dev/video0 -pix_fmt yuv420p -s 720x480 -c:v libx264 \
#  -profile:v baseline -an -preset ultrafast -tune zerolatency \
#  -g 1 -keyint_min 1 \
#  -an -f flv rtmp://localhost:1935/app/mystream9


# ./ffmpeg_bin/ffmpeg-linux64-v3.3.1 -f video4linux2 -i /dev/video0 -pix_fmt yuv420p -r 10 -s 720x480 \
#  - -vf format=yuv420p -c:v libx264 -profile:v baseline -an -preset ultrafast -tune zerolatency -g 1 -x264opts "keyint=1:min-keyint=1:no-scenecut" -an -f flv ${OUPUT_MEDIA_SERVER_URL}$QUERY_ID


# ./ffmpeg_bin/ffmpeg-linux64-v3.3.1 -f video4linux2 -framerate 10 -video_size 1280x720 -i /dev/video0 -c:v libx264 -preset ultrafast -tune zerolatency -g 10 -keyint_min 10 -sc_threshold 0 -b:v 2000k -maxrate 2000k -bufsize 2000k -pix_fmt yuv420p -f flv rtmp://localhost:1935/app/mystream7
# ./ffmpeg_bin/ffmpeg-linux64-v3.3.1 -f video4linux2 -probesize 32 -analyzeduration 0 -framerate 10 -video_size 1280x720 -i /dev/video0 -c:v libx264 -preset ultrafast -tune zerolatency -g 10 -keyint_min 10 -sc_threshold 0 -b:v 2000k -maxrate 2000k -bufsize 2000k -pix_fmt yuv420p -f flv rtmp://localhost:1935/app/mystream7

# ffmpeg -f video4linux2 -framerate 10 -video_size 1280x720 -i /dev/video0 -c:v libx264 -preset ultrafast -tune zerolatency -g 10 -keyint_min 10 -sc_threshold 0 -b:v 2000k -maxrate 2000k -bufsize 2000k -pix_fmt yuv420p -x264opts "keyint=1:min-keyint=1:no-scenecut:bframes=0:threads=0" -f flv rtmp://localhost:1935/app/mystream9

# ffmpeg -f video4linux2 -framerate 10 -video_size 1280x720 -i /dev/video0 -c:v libx264 -preset ultrafast -tune zerolatency -g 10 -keyint_min 10 -sc_threshold 0 -b:v 2000k -maxrate 2000k -bufsize 2000k -pix_fmt yuv420p -x264opts "keyint=1:min-keyint=1:no-scenecut" -f flv rtmp://localhost:1935/app/mystream9




#!/bin/bash


# ./ffmpeg_bin/ffmpeg-linux64-v3.3.1 -video_size 1280x720 -f x11grab -i :0.0+100,200 -probesize 32 -analyzeduration 0 -framerate 10 -c:v libx264 -profile:v baseline -preset ultrafast -tune zerolatency -g 10 -keyint_min 10 -sc_threshold 0 -b:v 2000k -maxrate 2000k -bufsize 2000k -pix_fmt yuv420p -x264opts "keyint=1:min-keyint=1:no-scenecut" -f flv rtmp://localhost:1935/app/mystream10
# ./ffmpeg_bin/ffmpeg-linux64-v3.3.1 -video_size 768x432 -framerate 10 -f x11grab -i :0.0+100,200 -probesize 32 -analyzeduration 0  -c:v libx264 -profile:v main -preset ultrafast -tune zerolatency -g 10 -keyint_min 10 -sc_threshold 0 -b:v 2000k -maxrate 2000k -bufsize 2000k -pix_fmt yuv420p -x264opts "keyint=10:min-keyint=10:no-scenecut" -f flv rtmp://localhost:1935/app/mystream10
# ./ffmpeg_bin/ffmpeg-linux64-v3.3.1 -video_size 768x432 -framerate 10 -f x11grab -i :0.0+100,200 -probesize 32 -analyzeduration 0 -c:a aac -c:v libx264 -profile:v main -preset ultrafast -tune zerolatency -g 10 -keyint_min 10 -sc_threshold 0 -b:v 2000k -maxrate 2000k -bufsize 2000k -pix_fmt yuv420p -x264opts "keyint=10:min-keyint=10:no-scenecut" -f flv rtmp://localhost:1935/app/mystream10


# works and fast, but I need to to be my webcam!
# ./ffmpeg_bin/ffmpeg-linux64-v3.3.1 -re -i /home/arruda/Videos/presentation.mkv -c:v libx264 -c:a aac -f flv rtmp://localhost:1935/app/mystream10

# ./ffmpeg_bin/ffmpeg-linux64-v3.3.1 -framerate 10 -video_size 1280x720 -i /dev/video0 -c:v libx264 -c:a aac -f flv rtmp://localhost:1935/app/mystream10


#using gstreamer
# gst-launch-1.0 v4l2src device=/dev/video0 ! "video/x-raw,framerate=10,width=1280,height=720" ! queue ! x264enc tune=zerolatency speed-preset=ultrafast key-int-max=10 intra-refresh=true ! queue ! flvmux ! rtmpsink location=rtmp://localhost:1935/app/mystream9
# gst-launch-1.0 v4l2src device=/dev/video0 ! queue ! x264enc tune=zerolatency speed-preset=ultrafast  ! queue ! flvmux ! rtmpsink location=rtmp://localhost:1935/app/mystream9
# gst-launch-1.0 v4l2src device=/dev/video0 ! queue ! x264enc ! flvmux streamable=true ! queue ! rtmpsink location='rtmp://localhost:1935/app/mystream10'


# gst-launch-1.0 v4l2src device=/dev/video0 ! queue ! x264enc ! flvmux streamable=true ! rtmpsink location=rtmp://localhost:1935/app/mystream9
# gst-launch-1.0 v4l2src device=/dev/video0 ! video/x-raw ! queue ! videoconvert ! video/x-raw,format=I420 ! queue ! x264enc tune=zerolatency ! queue ! flvmux ! rtmpsink location=rtmp://localhost:1935/app/mystream9
# gst-launch-1.0 v4l2src device=/dev/video0 ! \
#     video/x-raw,width=1280,height=720,framerate=10/1 ! \
#     videoscale ! videorate ! videoconvert ! x264enc tune=zerolatency ! queue ! flvmux ! rtmpsink location=rtmp://localhost:1935/app/mystream10



    #  video/x-raw,format=I420 ! queue ! x264enc tune=zerolatency ! queue ! flvmux ! rtmpsink location=rtmp://localhost:1935/app/mystream9




    # video/x-raw,width=1280,height=720,framerate=10/1 ! \
    # videoscale ! videorate ! videoconvert !

# gst-launch-1.0 autovideosrc device=/dev/video0 \
#   ! video/x-raw,width=1280,height=720 \
#   ! queue \
#   ! x264enc bitrate=2000 byte-stream=false key-int-max=10 bframes=0 aud=true tune=zerolatency pass=17 ! "video/x-h264,profile=main" \
#   ! flvmux streamable=true name=mux \
#   ! rtmpsink location="rtmp://localhost:1935/app/mystream10" \
#   autoaudiosrc ! queue ! audioresample ! "audio/x-raw,rate=44100" ! queue ! mux.



# working but slow startup:
# gst-launch-1.0 v4l2src device=/dev/video0 ! \
#     video/x-raw,width=1280,height=720,framerate=10/1 ! \
#     videoscale ! videorate ! videoconvert ! x264enc tune=zerolatency ! queue ! flvmux ! rtmpsink location=rtmp://localhost:1935/app/mystream10


# gst-launch-1.0 v4l2src device=/dev/video0 ! \
#     video/x-raw,width=1280,height=720,framerate=10/1 ! \
#     videoscale ! videorate ! videoconvert ! \
#     x264enc tune=zerolatency tune=fastdecode key-int-max=1 ! \
#     queue ! flvmux ! rtmpsink location=rtmp://localhost:1935/app/mystream10



# working but still is slow:
# gst-launch-1.0 filesrc location=/home/arruda/Videos/presentation.mkv ! \
#     decodebin ! videoconvert ! \
#     videoscale ! videorate ! video/x-raw,width=1280,height=720,framerate=10/1 ! \
#     x264enc tune=zerolatency tune=fastdecode key-int-max=1 ! \
#     queue ! flvmux ! rtmpsink location=rtmp://localhost:1935/app/mystream10


# gst-launch-1.0 filesrc location=/home/arruda/Videos/presentation.mkv ! \
#     decodebin ! videoconvert ! \
#     videoscale ! videorate ! video/x-raw,width=1280,height=720,framerate=10/1 ! \
#     x264enc tune=zerolatency tune=fastdecode key-int-max=1 ! \
#     queue ! flvmux name=mux \
#     audiotestsrc ! audioconvert ! audioresample ! voaacenc bitrate=128000 ! queue ! mux. \
#     rtmpsink location=rtmp://localhost:1935/app/mystream10


# ffmpeg -f video4linux2 -i /dev/video0 \
# -i video="Integrated Webcam":audio="Microphone (Realtek Audio)" \
# -profile:v high -pix_fmt yuv420p -level:v 4.1 -preset ultrafast -tune zerolatency \
# -vcodec libx264 -r 10 -b:v 512k -s 640x360 \
# -acodec aac -ac 2 -ab 32k -ar 44100 \
#  -f flv rtmp://localhost:1935/app/mystream10

# working fast!
# ffmpeg -f v4l2 -i /dev/video0 -f alsa -i hw:0 -profile:v high -pix_fmt yuv420p -level:v 4.1 -preset ultrafast -tune zerolatency -vcodec libx264 -r 10 -b:v 512k -s 640x360 -acodec aac -strict -2 -ac 2 -ab 32k -ar 44100 -f flv rtmp://localhost:1935/app/mystream10

# ffmpeg -f v4l2 -i /dev/video0 -f alsa -profile:v high -pix_fmt yuv420p -level:v 4.1 -preset ultrafast -tune zerolatency -vcodec libx264 -r 10 -b:v 512k -s 640x360 -acodec aac -strict -2 -ac 2 -ab 32k -ar 44100 -f flv rtmp://localhost:1935/app/mystream10

# -i anullsrc

# works ! no sound and starts fast!
# ffmpeg -f v4l2 -framerate 10 -video_size 1280x720 -i /dev/video0 -f lavfi -i anullsrc=channel_layout=stereo:sample_rate=44100 -c:v libx264 -pix_fmt yuv420p -preset ultrafast -g 10 -b:v 2500k -c:a aac -f flv rtmp://localhost:1935/app/mystream10


# working fast for oven
# ffmpeg -f v4l2 -i /dev/video0 -f lavfi -i anullsrc=channel_layout=stereo:sample_rate=44100 -profile:v main -pix_fmt yuv420p -preset ultrafast -tune zerolatency -vcodec libx264 -r 10 -g 10 -keyint_min 10 -sc_threshold 0 -b:v 2000k -maxrate 2000k -bufsize 2000k -s 768x432 -acodec aac  -f flv rtmp://localhost:1935/app/mystream

# -g 10 -keyint_min 10 -sc_threshold 0 -x264opts "keyint=10:min-keyint=10:no-scenecut" -f flv rtmp://localhost:1935/app/mystream10

# working fast for rtmp server
ffmpeg -f v4l2 -i /dev/video0 -f lavfi -i anullsrc=channel_layout=stereo:sample_rate=44100 -profile:v main -pix_fmt yuv420p -preset ultrafast -tune zerolatency -vcodec libx264 -r 10 -g 10 -keyint_min 10 -sc_threshold 0 -b:v 2000k -maxrate 2000k -bufsize 2000k -s 720x480 -acodec aac  -f flv rtmp://localhost:1934/live/mystream
